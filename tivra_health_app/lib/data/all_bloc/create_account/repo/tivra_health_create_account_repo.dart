import 'dart:convert';
import 'package:tivra_health/data/all_bloc/create_account/repo/tivra_health_create_account_response.dart';
import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';
import 'package:tivra_health/data/remote/web_common_response.dart';
import 'package:tivra_health/data/remote/web_constants.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';
import 'package:tivra_health/data/remote/web_service.dart';

class TivraHealthCreateAccountRepository {
  final Webservice webservice;
  final SharedPrefs sharedPrefs;
  dynamic returnResponse;

  TivraHealthCreateAccountRepository(
      {required this.webservice, required this.sharedPrefs});

  Future<dynamic> fetchTivraHealthCreateAccount(
      dynamic mTivraHealthCreateAccountListRequest) async {
    final response = await webservice.putWithRequestWithoutAuth(
        WebConstants.actionTivraHealthRegisterCreateAccount,
        mTivraHealthCreateAccountListRequest);
    try {
      WebCommonResponse mWebCommonResponse =
          WebCommonResponse.fromJson(response);
      if (mWebCommonResponse.statusCode.toString() == "200") {
        TivraHealthCreateAccountResponse registerResponse =
            TivraHealthCreateAccountResponse.fromJson(
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
