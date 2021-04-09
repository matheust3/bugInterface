import 'dart:convert';

import 'package:assist_agro/core/app_data.dart';
import 'package:assist_agro/core/bundler/javascript_web_require.dart';
import 'package:assist_agro/core/core/admin_data.dart';
import 'package:assist_agro/core/core/core_handler.dart';
import 'package:assist_agro/core/errors/failures.dart';

abstract class WebAdapter {
  Future<CoreHandle<Map<String, dynamic>>> get(
      {required String url, Map<String, Map<String, dynamic>>? queryParams});
}

class WebAdapterImpl implements WebAdapter {
  final AdminData adminData;

  WebAdapterImpl({required this.adminData});

  @override
  Future<CoreHandle<Map<String, dynamic>>> get(
      {required String url,
      Map<String, Map<String, dynamic>>? queryParams}) async {
    if (queryParams == null) queryParams = {};
    queryParams['token'] = {'loginToken': adminData.getLoginToken};

    final result =
        await WebRequest.get('${AppData.host}$url', queryParams: queryParams);
    if (result.statusCode == 200) {
      try {
        final Map<String, dynamic> jsonBody = jsonDecode(result.response);
        return CoreHandle(response: jsonBody);
      } catch (e) {
        return CoreHandle(failure: WebAdapterFailure(message: e.toString()));
      }
    } else {
      return CoreHandle(failure: WebAdapterNoOkFailure(result.statusCode));
    }
  }
}
