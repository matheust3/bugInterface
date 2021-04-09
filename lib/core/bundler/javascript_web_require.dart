@JS()
library web_request_alert;

import 'dart:async';
import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter
import 'dart:js_util';
import 'package:js/js.dart';

@JS('WebRequest')
class _WebRequest {
  @JS('get')
  external static dynamic get(String text);
}

class WebRequest {
  static Future<WebRequestResponse> get(String url,
      {Map<String, Map<String, dynamic>>? queryParams}) async {
    String callUrl = url;
    if (queryParams != null) {
      queryParams.forEach((key, value) {
        if (url == callUrl) {
          callUrl += '?';
        } else {
          callUrl += '&';
        }
        callUrl += '$key=' + Uri.encodeComponent(jsonEncode(value));
      });
    }
    final String response = await promiseToFuture(_WebRequest.get(callUrl));
    if (response.startsWith('STATUS_CODE:')) {
      return WebRequestResponse('', int.parse(response.substring(12)));
    } else {
      return WebRequestResponse(response, 200);
    }
  }
}

class WebRequestResponse {
  final String response;
  final int statusCode;

  WebRequestResponse(this.response, this.statusCode);
}
