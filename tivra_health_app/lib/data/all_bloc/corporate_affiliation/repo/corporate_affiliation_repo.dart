import 'dart:convert';
import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';
import 'package:tivra_health/data/remote/web_common_response.dart';
import 'package:tivra_health/data/remote/web_constants.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';
import 'package:tivra_health/data/remote/web_service.dart';

import 'corporate_affiliation_response.dart';

class CorporateAffiliationRepository {
  final Webservice webservice;
  final SharedPrefs sharedPrefs;
  dynamic returnResponse;

  CorporateAffiliationRepository(
      {required this.webservice, required this.sharedPrefs});

  Future<dynamic> fetchCorporateAffiliation(
      dynamic mCorporateAffiliationRepoListRequest) async {
    final response = await webservice.putWithRequestWithoutAuth(
        WebConstants.actionCorporateAffiliation,
        mCorporateAffiliationRepoListRequest);
    try {
      WebCommonResponse mWebCommonResponse =
          WebCommonResponse.fromJson(response);
      if (mWebCommonResponse.statusCode.toString() == "200") {
        CorporateAffiliationResponse registerResponse =
            CorporateAffiliationResponse.fromJson(
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
