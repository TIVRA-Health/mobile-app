import 'dart:convert';
import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';
import 'package:tivra_health/data/remote/web_common_response.dart';
import 'package:tivra_health/data/remote/web_constants.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';
import 'package:tivra_health/data/remote/web_service.dart';

import 'nutrition_food_details_response.dart';

class NutritionFoodDetailsRepository {
  final Webservice webservice;
  final SharedPrefs sharedPrefs;
  dynamic returnResponse;

  NutritionFoodDetailsRepository({required this.webservice, required this.sharedPrefs});

  Future<dynamic> fetchNutritionFoodDetails(dynamic mStringRequest) async {
    final response = await webservice
        .postWithRequestWithoutAuth(WebConstants.actionFoodDetails,mStringRequest);

    try {
      WebCommonResponse mWebCommonResponse =
          WebCommonResponse.fromJson(response);
      if (mWebCommonResponse.statusCode.toString() == "200") {
        NutritionFoodDetailsResponse teamResponse =
            NutritionFoodDetailsResponse.fromJson(json.decode(mWebCommonResponse.data));
        await sharedPrefs.setUploadFood(mWebCommonResponse.data);
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
