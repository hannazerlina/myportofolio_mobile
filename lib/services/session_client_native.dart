import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

http.Client createSessionClient() => _SessionClient();

class _SessionClient extends http.BaseClient {
  final _client = IOClient();
  final _cookies = <String, Cookie>{};

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final cookies = _cookies.values.where(
      (cookie) => !cookie.secure || request.url.scheme == 'https',
    );
    if (cookies.isNotEmpty) {
      request.headers['Cookie'] = cookies
          .map((cookie) => '${cookie.name}=${cookie.value}')
          .join('; ');
    }
    final response = await _client.send(request);
    final raw = response.headers['set-cookie'];
    if (raw != null) {
      // An Expires date also contains a comma, so split only before a name=value.
      for (final value in raw.split(RegExp(r',\s*(?=[^;,\s=]+=)'))) {
        final cookie = Cookie.fromSetCookieValue(value);
        if (cookie.maxAge == 0 || cookie.value.isEmpty) {
          _cookies.remove(cookie.name);
        } else {
          _cookies[cookie.name] = cookie;
        }
      }
    }
    return response;
  }

  @override
  void close() => _client.close();
}
