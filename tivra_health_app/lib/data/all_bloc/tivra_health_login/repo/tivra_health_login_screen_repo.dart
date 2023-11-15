import 'dart:convert';

import 'package:tivra_health/data/all_bloc/tivra_health_login/repo/tivra_health_login_screen_response.dart';
import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';
import 'package:tivra_health/data/remote/web_common_response.dart';
import 'package:tivra_health/data/remote/web_constants.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';
import 'package:tivra_health/data/remote/web_service.dart';


class TivraHealthLoginScreenRepository {
  final Webservice webservice;
  final SharedPrefs sharedPrefs;
  dynamic returnResponse;

  TivraHealthLoginScreenRepository(
      {required this.webservice, required this.sharedPrefs});

  Future<dynamic> fetchTivraHealthLoginScreen(
      dynamic mTivraHealthLoginScreenListRequest) async {
    final response = await webservice.postWithRequestWithoutAuth(
        WebConstants.actionTivraHealthLoginScreen,
        mTivraHealthLoginScreenListRequest);
    try {
      WebCommonResponse mWebCommonResponse =
          WebCommonResponse.fromJson(response);
      if (mWebCommonResponse.statusCode.toString() == "200") {
        TivraHealthLoginScreenResponse dashboardResponse =
            TivraHealthLoginScreenResponse.fromJson(json.decode(mWebCommonResponse.data));

        await sharedPrefs.setUserId(
            dashboardResponse.userId.toString().toLowerCase() == "null"
                ? ""
                : dashboardResponse.userId.toString());

        await sharedPrefs.setUserToken(
            dashboardResponse.token.toString().toLowerCase() == "null"
                ? ""
                : dashboardResponse.token.toString());

        returnResponse = dashboardResponse;
      }else{
        WebResponseFailed mWebResponseFailed = WebResponseFailed();
        mWebResponseFailed.setMessage("Sorry, user does not exist.");
        returnResponse = mWebResponseFailed;
      }
    } catch (e) {
      WebResponseFailed mWebResponseFailed = WebResponseFailed();
      mWebResponseFailed.setMessage("Sorry, user does not exist.");
      returnResponse = mWebResponseFailed;
    }

    return returnResponse;
  }
}
