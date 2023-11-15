import 'dart:convert';
import 'dart:developer';

import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';
import 'package:tivra_health/data/remote/web_common_response.dart';
import 'package:tivra_health/data/remote/web_constants.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';
import 'package:tivra_health/data/remote/web_service.dart';
import 'get_dashboard_config_response_new.dart';

class GetDashboardConfigRepository {
  final Webservice webservice;
  final SharedPrefs sharedPrefs;
  dynamic returnResponse;

  GetDashboardConfigRepository({required this.webservice, required this.sharedPrefs});

  Future<dynamic> fetchGetDashboardConfig(dynamic mStringRequest) async {
    final response = await webservice
        .getWithOutAuthAndStringRequest(WebConstants.actionGetDashboardConfig,mStringRequest);

    try {
      WebCommonResponse mWebCommonResponse =
          WebCommonResponse.fromJson(response);
      if (mWebCommonResponse.statusCode.toString() == "200") {
        String sValue = "{\"data\":${mWebCommonResponse.data}}";
        GetDashboardConfigResponseNew dashboardResponse =
            GetDashboardConfigResponseNew.fromJson(json.decode(sValue));
        await sharedPrefs.setDashboardConfig(sValue);
        returnResponse = dashboardResponse;
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
