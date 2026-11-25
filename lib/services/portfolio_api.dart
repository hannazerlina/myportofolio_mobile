import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:myportofolio_mobile/models/portfolio_project.dart';
import 'package:myportofolio_mobile/services/session_client.dart';

class ApiException implements Exception {
  const ApiException(this.message);

  final String message;

  @override
  String toString() => message;
}

class PortfolioApi extends ChangeNotifier {
  PortfolioApi({http.Client? client, Uri? baseUrl})
    : _client = client ?? createSessionClient(),
      _baseUrl = baseUrl ?? _defaultBaseUrl();

  static Uri _defaultBaseUrl() {
    const configured = String.fromEnvironment('DJANGO_BASE_URL');
    if (configured.isNotEmpty) return Uri.parse(configured);
    final host = !kIsWeb && defaultTargetPlatform == TargetPlatform.android
        ? '10.0.2.2'
        : '127.0.0.1';
    return Uri.http('$host:8000');
  }

  final Uri _baseUrl;
  final http.Client _client;
  Future<void>? _refreshInFlight;
  String? _csrfToken;
  String? _username;
  bool _canManageProjects = false;
  bool _disposed = false;

  String? get username => _username;
  bool get canManageProjects => _canManageProjects;

  Future<void> restoreSession() async {
    try {
      await refreshSession();
    } on ApiException {
      // Browsing remains available and signing in can retry.
    }
  }

  Future<void> refreshSession() {
    return _refreshInFlight ??= _fetchSession().whenComplete(() {
      _refreshInFlight = null;
    });
  }

  Future<void> _fetchSession() async {
    final data = await _request('/auth/session/') as Map<String, dynamic>;
    _updateSession(data);
  }

  void _updateSession(Map<String, dynamic> data) {
    if (_disposed) return;
    _csrfToken = data['csrf_token'] as String;
    _username = data['username'] as String?;
    _canManageProjects = data['can_manage_projects'] == true;
    notifyListeners();
  }

  Future<void> login(String username, String password) async {
    final data = await _request(
      '/auth/login/',
      payload: {'username': username, 'password': password},
    ) as Map<String, dynamic>;
    _updateSession(data);
  }

  Future<void> register(
    String username,
    String password,
    String confirm,
  ) async {
    await _request(
      '/auth/register/',
      payload: {
        'username': username,
        'password1': password,
        'password2': confirm,
      },
    );
  }

  Future<void> logout() async {
    final data =
        await _request('/auth/logout/', payload: {}) as Map<String, dynamic>;
    _updateSession(data);
  }

  Future<List<PortfolioProject>> listProjects() async {
    final data = await _request('/api/v1/projects/') as List<dynamic>;
    return data
        .cast<Map<String, dynamic>>()
        .map(PortfolioProject.fromJson)
        .toList(growable: false);
  }

  Future<PortfolioProject> project(int id) async {
    final data =
        await _request('/api/v1/projects/$id/') as Map<String, dynamic>;
    return PortfolioProject.fromJson(data);
  }

  Future<PortfolioProject> createProject({
    required String title,
    required String role,
    required int year,
    required String description,
    required String spotifyUrl,
  }) async {
    final data = await _request(
      '/api/v1/projects/',
      payload: {
        'title': title,
        'role': role,
        'year': year,
        'description': description,
        'spotify_url': spotifyUrl,
      },
    ) as Map<String, dynamic>;
    return PortfolioProject.fromJson(data);
  }

  Future<Object?> _request(String path, {Map<String, Object?>? payload}) async {
    if (payload != null && _csrfToken == null) await refreshSession();
    final request =
        http.Request(payload == null ? 'GET' : 'POST', _baseUrl.resolve(path))
          ..followRedirects = false
          ..headers['Accept'] = 'application/json';
    if (payload != null) {
      request.headers['Content-Type'] = 'application/json';
      request.headers['X-CSRFToken'] = _csrfToken!;
      request.body = jsonEncode(payload);
    }

    try {
      final response = await _client
          .send(request)
          .then(http.Response.fromStream)
          .timeout(const Duration(seconds: 12));
      final body = utf8.decode(response.bodyBytes);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return jsonDecode(body);
      }
      throw _responseError(response.statusCode, body);
    } on FormatException {
      throw const ApiException('Respons Django tidak dapat dibaca.');
    } on TimeoutException {
      throw const ApiException('Django terlalu lama merespons. Coba lagi.');
    } on http.ClientException {
      throw const ApiException('Tidak dapat terhubung ke Django.');
    }
  }

  ApiException _responseError(int status, String body) {
    try {
      final data = jsonDecode(body);
      if (data is Map<String, dynamic>) {
        final message = data['message'] ?? data['detail'];
        if (message is String) return ApiException(message);
        final errors = data['errors'] ?? data;
        if (errors is Map<String, dynamic>) {
          for (final value in errors.values) {
            if (value is List && value.isNotEmpty) {
              return ApiException(value.first.toString());
            }
          }
        }
      }
    } on FormatException {
      // Django's CSRF error, for example, can be an HTML response.
    }
    return ApiException(
      status == 403
          ? 'Akses ditolak. Periksa sesi akun dan izin pemilik portofolio.'
          : 'Permintaan gagal (HTTP $status).',
    );
  }

  @override
  void dispose() {
    _disposed = true;
    _client.close();
    super.dispose();
  }
}
