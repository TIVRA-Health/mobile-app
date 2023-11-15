import 'dart:convert';
import 'package:tivra_health/data/all_bloc/save_team_preference/repo/save_team_response.dart';
import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';
import 'package:tivra_health/data/remote/web_common_response.dart';
import 'package:tivra_health/data/remote/web_constants.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';
import 'package:tivra_health/data/remote/web_service.dart';

class SaveTeamPreferenceRepository {
  final Webservice webservice;
  final SharedPrefs sharedPrefs;
  dynamic returnResponse;

  SaveTeamPreferenceRepository({required this.webservice, required this.sharedPrefs});

  Future<dynamic> fetchSaveTeamPreference(dynamic mStringRequest) async {
    final response = await webservice
        .putWithRequestWithoutAuth(WebConstants.actionTeamPreference,mStringRequest);

    try {
      WebCommonResponse mWebCommonResponse =
          WebCommonResponse.fromJson(response);
      if (mWebCommonResponse.statusCode.toString() == "200") {
        SaveTeamPreferenceResponse teamResponse =
            SaveTeamPreferenceResponse.fromJson(json.decode(mWebCommonResponse.data));
        returnResponse = teamResponse;
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
