import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:myportofolio_mobile/services/portfolio_api.dart';

PortfolioApi portfolioFixture({
  bool owner = false,
  void Function(http.Request)? onRequest,
}) {
  final project = <String, Object?>{
    'id': 1,
    'title': 'Skylite Musicals 2024',
    'role': 'Music Director',
    'year': 2024,
    'description': 'Produksi musikal.',
    'spotify_url': '',
  };
  var signedIn = owner;
  http.Response response(Object? data, [int status = 200]) => http.Response(
    jsonEncode(data),
    status,
    headers: {'content-type': 'application/json'},
  );

  Map<String, Object?> session() => {
    'csrf_token': 'token',
    'username': signedIn ? 'pemilik' : null,
    'can_manage_projects': signedIn,
  };

  return PortfolioApi(
    baseUrl: Uri.parse('http://127.0.0.1:8000'),
    client: MockClient((request) async {
      onRequest?.call(request);
      switch (request.url.path) {
        case '/auth/session/':
          return response(session());
        case '/auth/register/':
          return response({'message': 'Akun berhasil dibuat.'}, 201);
        case '/auth/login/':
          signedIn = true;
          return response(session());
        case '/auth/logout/':
          signedIn = false;
          return response(session());
        case '/api/v1/projects/':
          if (request.method == 'POST') {
            if (!signedIn) return response({'detail': 'Akses ditolak.'}, 403);
            project.addAll(jsonDecode(request.body) as Map<String, dynamic>);
            return response(project, 201);
          }
          return response([project]);
        case '/api/v1/projects/1/':
          return response(project);
        default:
          return response({'detail': 'Tidak ditemukan.'}, 404);
      }
    }),
  );
}
