import 'dart:convert';
import 'package:tivra_health/data/all_bloc/health_and_fitness_profile/repo/tivra_health_health_and_fitness_profile_response.dart';
import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';
import 'package:tivra_health/data/remote/web_common_response.dart';
import 'package:tivra_health/data/remote/web_constants.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';
import 'package:tivra_health/data/remote/web_service.dart';

class TivraHealthHealthAndFitnessRepository {
  final Webservice webservice;
  final SharedPrefs sharedPrefs;
  dynamic returnResponse;

  TivraHealthHealthAndFitnessRepository(
      {required this.webservice, required this.sharedPrefs});

  Future<dynamic> fetchTivraHealthHealthAndFitness(
      dynamic mTivraHealthHealthAndFitnessListRequest) async {
    final response = await webservice.putWithRequestWithoutAuth(
        WebConstants.actionHealthAndFitnessProfile,
        mTivraHealthHealthAndFitnessListRequest);
    try {
      WebCommonResponse mWebCommonResponse =
          WebCommonResponse.fromJson(response);
      if (mWebCommonResponse.statusCode.toString() == "200") {
        TivraHealthHealthAndFitnessResponse registerResponse =
            TivraHealthHealthAndFitnessResponse.fromJson(
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
