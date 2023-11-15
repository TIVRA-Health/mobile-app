import 'dart:convert';
import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';
import 'package:tivra_health/data/remote/web_common_response.dart';
import 'package:tivra_health/data/remote/web_constants.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';
import 'package:tivra_health/data/remote/web_service.dart';

import 'nutrition_log_on_date_response.dart';

class NutritionLogOnDateRepository {
  final Webservice webservice;
  final SharedPrefs sharedPrefs;
  dynamic returnResponse;

  NutritionLogOnDateRepository({required this.webservice, required this.sharedPrefs});

  Future<dynamic> fetchNutritionLogOnDate(dynamic mStringRequest) async {
    final response = await webservice
        .getWithOutAuthAndStringRequest(WebConstants.actionNutritionLogBasedOnDate,mStringRequest);

    try {
      WebCommonResponse mWebCommonResponse =
          WebCommonResponse.fromJson(response);
      if (mWebCommonResponse.statusCode.toString() == "200") {
        String sValue = "{\"data\":${mWebCommonResponse.data}}";
        NutritionLogOnDateResponse nutritionLogOnDateResponse =
            NutritionLogOnDateResponse.fromJson(json.decode(sValue));
        await sharedPrefs.setNutritionLogOnDate(sValue);
        returnResponse = nutritionLogOnDateResponse;
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
