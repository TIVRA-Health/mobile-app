import 'dart:convert';
import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';
import 'package:tivra_health/data/remote/web_common_response.dart';
import 'package:tivra_health/data/remote/web_constants.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';
import 'package:tivra_health/data/remote/web_service.dart';
import 'consultation_response.dart';

class ConsultationRepository {
  final Webservice webservice;
  final SharedPrefs sharedPrefs;
  dynamic returnResponse;

  ConsultationRepository(
      {required this.webservice, required this.sharedPrefs});

  Future<dynamic> mConsultation(
      dynamic mConsultationRequest) async {
    final response = await webservice.postWithRequestWithoutAuth(
        WebConstants.actionConsultation,
        mConsultationRequest);
    try {
      WebCommonResponse mWebCommonResponse =
      WebCommonResponse.fromJson(response);
      if (mWebCommonResponse.statusCode.toString() == "200") {
        ConsultationResponse mConsultationResponse = ConsultationResponse.fromJson(json.decode(mWebCommonResponse.data));
        sharedPrefs.setMessage(mConsultationResponse.gptResponse ?? "");
        returnResponse = mConsultationResponse;
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
