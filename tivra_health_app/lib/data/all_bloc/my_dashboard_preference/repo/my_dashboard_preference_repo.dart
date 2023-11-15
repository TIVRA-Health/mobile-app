import 'dart:convert';
import 'dart:developer';

import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';
import 'package:tivra_health/data/remote/web_common_response.dart';
import 'package:tivra_health/data/remote/web_constants.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';
import 'package:tivra_health/data/remote/web_service.dart';

import 'my_dashboard_preference_response.dart';


class MyDashboardPreferenceRepository {
  final Webservice webservice;
  final SharedPrefs sharedPrefs;
  dynamic returnResponse;

  MyDashboardPreferenceRepository({required this.webservice, required this.sharedPrefs});

  Future<dynamic> fetchMyDashboardPreference(dynamic mStringRequest) async {
    final response = await webservice
        .getWithOutAuthAndStringRequest(WebConstants.actionGetMyDashboardPreference,mStringRequest);

    try {
      WebCommonResponse mWebCommonResponse =
          WebCommonResponse.fromJson(response);
      if (mWebCommonResponse.statusCode.toString() == "200") {
        MyDashboardPreferenceResponse dashboardResponse =
            MyDashboardPreferenceResponse.fromJson(json.decode(mWebCommonResponse.data));
        await sharedPrefs.setMyDashboardPreference(mWebCommonResponse.data);
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
