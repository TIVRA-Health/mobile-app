import 'dart:convert';
import 'package:tivra_health/data/all_bloc/request_otp/repo/tivra_health_register_screen_otp_response.dart';
import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';
import 'package:tivra_health/data/remote/web_common_response.dart';
import 'package:tivra_health/data/remote/web_constants.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';
import 'package:tivra_health/data/remote/web_service.dart';


class TivraHealthRegisterScreenOTPRepository {
  final Webservice webservice;
  final SharedPrefs sharedPrefs;
  dynamic returnResponse;

  TivraHealthRegisterScreenOTPRepository(
      {required this.webservice, required this.sharedPrefs});

  Future<dynamic> tivraHealthRegisterSendOTP(
      dynamic mTivraHealthRegisterScreenOTPRequest) async {
    final response = await webservice.postWithRequestWithoutAuth(
        WebConstants.actionTivraHealthRegisterAccountOtp,
        mTivraHealthRegisterScreenOTPRequest);
    try {
      WebCommonResponse mWebCommonResponse =
      WebCommonResponse.fromJson(response);
      if (mWebCommonResponse.statusCode.toString() == "200") {
        TivraHealthRegisterScreenOtpResponse otpResponse =
        TivraHealthRegisterScreenOtpResponse.fromJson(json.decode(mWebCommonResponse.data));
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
