import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:tivra_health/data/all_bloc/request_otp/repo/tivra_health_register_screen_otp_response.dart';
import 'package:tivra_health/data/all_bloc/tivra_health_registration/repo/tivra_health_register_screen_response.dart';
import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';
import 'package:tivra_health/data/remote/web_common_response.dart';
import 'package:tivra_health/data/remote/web_constants.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';
import 'package:tivra_health/data/remote/web_service.dart';

class TivraHealthRegisterScreenRepository {
  final Webservice webservice;
  final SharedPrefs sharedPrefs;
  dynamic returnResponse;

  TivraHealthRegisterScreenRepository(
      {required this.webservice, required this.sharedPrefs});

  Future<dynamic> fetchTivraHealthRegisterScreen(
      dynamic mTivraHealthRegisterScreenListRequest) async {
    final response = await webservice.postWithRequestWithoutAuth(
        WebConstants.actionTivraHealthRegisterAccountScreen,
        mTivraHealthRegisterScreenListRequest);
    try {
      WebCommonResponse mWebCommonResponse =
          WebCommonResponse.fromJson(response);
      if (mWebCommonResponse.statusCode.toString() == "200") {
        TivraHealthRegisterScreenResponse registerResponse =
            TivraHealthRegisterScreenResponse.fromJson(
                json.decode(mWebCommonResponse.data));

        await sharedPrefs.setUserId(
            registerResponse.userId.toString().toLowerCase() == "null"
                ? ""
                : registerResponse.userId.toString());
        String userId = await sharedPrefs.getUserId();
        await sharedPrefs.saveInitialData(
            json.encode(mTivraHealthRegisterScreenListRequest));

        await sharedPrefs.setCorporateAffiliation(registerResponse.corporateAffiliation.toString());
        returnResponse = registerResponse;
      } else {
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
