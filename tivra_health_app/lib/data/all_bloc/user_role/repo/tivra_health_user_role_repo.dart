import 'dart:convert';
import 'package:tivra_health/data/all_bloc/user_role/repo/tivra_health_user_role_response.dart';
import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';
import 'package:tivra_health/data/remote/web_common_response.dart';
import 'package:tivra_health/data/remote/web_constants.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';
import 'package:tivra_health/data/remote/web_service.dart';

class TivraHealthUserRoleRepository {
  final Webservice webservice;
  final SharedPrefs sharedPrefs;
  dynamic returnResponse;

  TivraHealthUserRoleRepository(
      {required this.webservice, required this.sharedPrefs});

  Future<dynamic> putUserRole(
      dynamic mTivraHealthUserRoleListRequest) async {
    final response = await webservice.putWithRequestWithoutAuth(
        WebConstants.actionUserRole,
        mTivraHealthUserRoleListRequest);
    try {
      WebCommonResponse mWebCommonResponse =
          WebCommonResponse.fromJson(response);
      if (mWebCommonResponse.statusCode.toString() == "200") {
        TivraHealthUserRoleResponse registerResponse =
            TivraHealthUserRoleResponse.fromJson(
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
