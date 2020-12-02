import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_gonosen/configuration_app/configuration_app.dart';
import 'package:http/http.dart' as http;

enum ApiClientMethod { get, post, put, delete, patch }

class ApiClient {
  /// `authorization` User hash or User Id which is used to authorization.
  /// `encryptParameter` The parammeters need to be encrypt before send to server.
  static Future<Map<String, dynamic>> connect(
    ApiClientMethod method, {
    @required String url,
    Map<String, String> header,
    Map<String, String> params,
    Map<String, String> body,
    String authorization,
    bool isCustomUrl = false,
  }) async {
    if (!isCustomUrl) {
      url = AppConfig.instance.apiUrl + url;
    }

    if (params != null) {
      url += '?';

      if (params != null) {
        params.forEach((key, value) {
          url += '$key=$value&';
        });
      }
    }

    debugPrint('$method: $url ${jsonEncode(body)}');
    try {
      final response = await _connect(
        method,
        url: url,
        header: header,
        body: body,
      );
      return jsonDecode(response.body);
    } catch (e) {
      throw 'Oops something went wrong!';
    }
  }

  static Future<http.Response> _connect(
    ApiClientMethod method, {
    @required String url,
    Map<String, String> header,
    Map<String, String> body,
  }) async {
    switch (method) {
      case ApiClientMethod.delete:
        return await http.delete(url, headers: header);
      case ApiClientMethod.get:
        return await http.get(url, headers: header);
      case ApiClientMethod.post:
        return await http.post(url, headers: header, body: jsonEncode(body));
      case ApiClientMethod.put:
        return await http.put(url, headers: header, body: body);
      case ApiClientMethod.patch:
        return await http.patch(url, headers: header, body: body);
      default:
        return await http.get(url, headers: header);
    }
  }
}
