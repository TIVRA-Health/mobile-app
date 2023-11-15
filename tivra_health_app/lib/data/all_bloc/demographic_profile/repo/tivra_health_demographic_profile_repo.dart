import 'dart:convert';
import 'package:tivra_health/data/all_bloc/demographic_profile/repo/tivra_health_demographic_profile_response.dart';
import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';
import 'package:tivra_health/data/remote/web_common_response.dart';
import 'package:tivra_health/data/remote/web_constants.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';
import 'package:tivra_health/data/remote/web_service.dart';

class TivraHealthDemographicProfileRepository {
  final Webservice webservice;
  final SharedPrefs sharedPrefs;
  dynamic returnResponse;

  TivraHealthDemographicProfileRepository(
      {required this.webservice, required this.sharedPrefs});

  Future<dynamic> putDemographicProfile(
      dynamic mTivraHealthDemographicProfileListRequest) async {
    final response = await webservice.putWithRequestWithoutAuth(
        WebConstants.actionDemographicProfile,
        mTivraHealthDemographicProfileListRequest);
    try {
      WebCommonResponse mWebCommonResponse =
      WebCommonResponse.fromJson(response);
      if (mWebCommonResponse.statusCode.toString() == "200") {
        TivraHealthDemographicProfileResponse registerResponse =
        TivraHealthDemographicProfileResponse.fromJson(
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
