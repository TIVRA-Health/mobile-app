import 'dart:convert';
import 'package:tivra_health/data/all_bloc/upload_food/repo/upload_food_response.dart';
import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';
import 'package:tivra_health/data/remote/web_common_response.dart';
import 'package:tivra_health/data/remote/web_constants.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';
import 'package:tivra_health/data/remote/web_service.dart';

class UploadFoodRepository {
  final Webservice webservice;
  final SharedPrefs sharedPrefs;
  dynamic returnResponse;

  UploadFoodRepository({required this.webservice, required this.sharedPrefs});

  Future<dynamic> fetchUploadFood(dynamic mStringRequest) async {
    final response = await webservice
        .postWithRequestWithoutAuth(WebConstants.actionUploadFood,mStringRequest);

    try {
      WebCommonResponse mWebCommonResponse =
          WebCommonResponse.fromJson(response);
      if (mWebCommonResponse.statusCode.toString() == "200") {
        UploadFoodResponse TeamResponse =
            UploadFoodResponse.fromJson(json.decode(mWebCommonResponse.data));
        await sharedPrefs.setUploadFood(mWebCommonResponse.data);
        returnResponse = TeamResponse;
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
