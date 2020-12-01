import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gonosen/configuration_app/configuration_app.dart';
import 'package:flutter_gonosen/secure_storage/secure_storage.dart';

class ApiClient {
  ApiClient() {
    _headers = {
      'Authorization':
          'Basic ' + base64Encode(utf8.encode('$username:$password')),
    };
    _client = Dio();
  }

  Map<String, String> _headers;
  Dio _client;
  final username = AppConfig.instance.apiUsername;
  final password = AppConfig.instance.apiPassword;

  ApiClient addHeader(Map<String, String> headers) {
    _headers.addAll(headers);
    return this;
  }

  Future<Response> authConnect(
    ApiMethod method,
    String url, {
    Map<String, String> headers,
    Map<String, String> query,
    Map<String, dynamic> body,
    bool handleError = true,
    bool hasCaching = true,
  }) async {
    if (headers != null) {
      _headers.addAll(headers);
    }

    return await normalConnect(
      method,
      url,
      body: body,
      headers: headers,
      query: query,
      handleError: handleError,
    );
  }

  Future<Response> normalConnect(
    ApiMethod method,
    String url, {
    Map<String, String> headers,
    Map<String, String> query,
    Map<String, dynamic> body,
    FormData data,
    bool handleError = true,
    bool hasCaching = true,
  }) async {
    Map<String, String> _headers = {};

    if (headers != null && data == null) {
      _headers.addAll(headers);
    }

    final options = Options(headers: _headers);

    Response response;

    final connectivity = await Connectivity().checkConnectivity();
    if (connectivity == ConnectivityResult.none) {
      // Read from cache when no internet connection
      if (method == ApiMethod.GET) {
        try {
          final cacheData = jsonDecode(await readCache(url + query.toString()));
          response = Response();
          response.statusCode = 200;
          response.data = cacheData;
        } catch (e) {
          debugPrint('Failed to parse cache: $e');
          throw 'No connection';
        }
      } else {
        throw 'No connection';
      }
    } else {
      switch (method) {
        case ApiMethod.GET:
          response =
              await _client.get(url, queryParameters: query, options: options);
          break;
        case ApiMethod.POST:
          response = await _client.post(url,
              queryParameters: query, options: options, data: data ?? body);
          break;
        default:
          response =
              await _client.get(url, queryParameters: query, options: options);
          break;
      }

      if (handleError && response.data is! Map<String, dynamic>) {
        debugPrint('Request URL = ${response.request.uri}');
        throw 'サーバー側から未知のエーラーが発生しています。\nサポートのため、アドミンにご連絡ください。';
      }

      // Cache api
      final success = !(response.data is List && response.data != null) &&
              response.data is Map<String, dynamic> &&
              response.data['success'] is bool
          ? response.data['success']
          : null;
      if (response.statusCode != 200 && response.statusCode != 201 ||
          (success != null && !success)) {
        if (handleError) {
          throw '';
        }
      } else {
        if (method == ApiMethod.GET) {
          saveCache(url + query.toString(), jsonEncode(response.data));
        }
      }
      // END cache api
    }

    debugPrint(response.request.uri.toString());
    return response;
  }
}

enum ApiMethod { GET, POST }
