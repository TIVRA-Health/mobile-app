import 'dart:convert';
import 'package:tivra_health/data/all_bloc/verify_otp/repo/tivra_health_verify_otp_response.dart';
import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';
import 'package:tivra_health/data/remote/web_common_response.dart';
import 'package:tivra_health/data/remote/web_constants.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';
import 'package:tivra_health/data/remote/web_service.dart';


class TivraHealthRegisterScreenVerifyOTPRepository {
  final Webservice webservice;
  final SharedPrefs sharedPrefs;
  dynamic returnResponse;

  TivraHealthRegisterScreenVerifyOTPRepository(
      {required this.webservice, required this.sharedPrefs});

  Future<dynamic> tivraHealthRegisterVerifyOTP(
      dynamic mTivraHealthRegisterScreenVerifyOTPRequest) async {
    final response = await webservice.postWithRequestWithoutAuth(
        WebConstants.actionTivraHealthRegisterVerifyOtp,
        mTivraHealthRegisterScreenVerifyOTPRequest);
    try {
      WebCommonResponse mWebCommonResponse =
      WebCommonResponse.fromJson(response);
      if (mWebCommonResponse.statusCode.toString() == "200") {
        TivraHealthVerifyOTPResponse otpResponse =
        TivraHealthVerifyOTPResponse.fromJson(json.decode(mWebCommonResponse.data));
        returnResponse = otpResponse;
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
