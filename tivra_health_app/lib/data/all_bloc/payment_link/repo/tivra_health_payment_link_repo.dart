import 'dart:convert';

import 'package:tivra_health/data/all_bloc/payment_link/repo/tivra_health_payment_link_response.dart';
import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';
import 'package:tivra_health/data/remote/web_common_response.dart';
import 'package:tivra_health/data/remote/web_constants.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';
import 'package:tivra_health/data/remote/web_service.dart';


class TivraHealthPaymentLinkRepository {
  final Webservice webservice;
  final SharedPrefs sharedPrefs;
  dynamic returnResponse;

  TivraHealthPaymentLinkRepository(
      {required this.webservice, required this.sharedPrefs});

  Future<dynamic> fetchTivraHealthPaymentLink(
      dynamic mTivraHealthPaymentLinkListRequest) async {
    final response = await webservice.postWithRequestWithoutAuth(
        WebConstants.actionPaymentLink,
        mTivraHealthPaymentLinkListRequest);
    try {
      WebCommonResponse mWebCommonResponse =
          WebCommonResponse.fromJson(response);
      if (mWebCommonResponse.statusCode.toString() == "200") {
        TivraHealthPaymentLinkResponse dashboardResponse =
            TivraHealthPaymentLinkResponse.fromJson(json.decode(mWebCommonResponse.data));
        await sharedPrefs.setPaymentUrl(dashboardResponse.url!);
        returnResponse = dashboardResponse;
      }else{
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
