import 'dart:convert';

import 'package:tivra_health/data/all_bloc/save_dashboard_config/repo/save_dashboard_config_response.dart';
import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';
import 'package:tivra_health/data/remote/web_common_response.dart';
import 'package:tivra_health/data/remote/web_constants.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';
import 'package:tivra_health/data/remote/web_service.dart';

class SaveDashboardConfigRepository {
  final Webservice webservice;
  final SharedPrefs sharedPrefs;
  dynamic returnResponse;

  SaveDashboardConfigRepository({required this.webservice, required this.sharedPrefs});

  Future<dynamic> fetchSaveDashboardConfig(dynamic mStringRequest) async {
    final response = await webservice
        .postWithRequestWithoutAuth(WebConstants.actionSaveDashboardConfig,mStringRequest);

    try {
      WebCommonResponse mWebCommonResponse =
          WebCommonResponse.fromJson(response);
      if (mWebCommonResponse.statusCode.toString() == "200") {
        SaveDashboardConfigResponse saveDashboardConfigResponse = SaveDashboardConfigResponse.fromJson(json.decode(mWebCommonResponse.data));
        returnResponse = saveDashboardConfigResponse;
      }else{
        WebResponseFailed mWebResponseFailed = WebResponseFailed();
        mWebResponseFailed.setMessage("Sorry, Home details does not exist.");
        returnResponse = mWebResponseFailed;
      }
    } catch (e) {
      WebResponseFailed mWebResponseFailed = WebResponseFailed();
      mWebResponseFailed.setMessage("Sorry, Home details does not exist.");
      returnResponse = mWebResponseFailed;
    }

    return returnResponse;
  }
}
