import 'dart:convert';
import 'package:tivra_health/data/all_bloc/social_profile/repo/tivra_health_social_profile_response.dart';
import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';
import 'package:tivra_health/data/remote/web_common_response.dart';
import 'package:tivra_health/data/remote/web_constants.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';
import 'package:tivra_health/data/remote/web_service.dart';

class TivraHealthSocialProfileRepository {
  final Webservice webservice;
  final SharedPrefs sharedPrefs;
  dynamic returnResponse;

  TivraHealthSocialProfileRepository(
      {required this.webservice, required this.sharedPrefs});

  Future<dynamic> putSocialProfile(
      dynamic mTivraHealthSocialProfileListRequest) async {
    final response = await webservice.putWithRequestWithoutAuth(
        WebConstants.actionSocialProfile,
        mTivraHealthSocialProfileListRequest);
    try {
      WebCommonResponse mWebCommonResponse =
          WebCommonResponse.fromJson(response);
      if (mWebCommonResponse.statusCode.toString() == "200") {
        TivraHealthSocialProfileResponse registerResponse =
            TivraHealthSocialProfileResponse.fromJson(
                json.decode(mWebCommonResponse.data));
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
