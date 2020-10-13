import 'dart:async';
import 'package:http/http.dart' as http;

class BaseClient extends http.BaseClient {
  final String _baseUrl;
  final http.Client _inner;

  BaseClient(this._baseUrl, this._inner) : super();

  @override
  Future<http.Response> get(url, {Map<String, String> headers}) {
    final String requestUrl = this._baseUrl + url;

    return super.get(requestUrl, headers: headers);
  }

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    return _inner.send(request);
  }
}
