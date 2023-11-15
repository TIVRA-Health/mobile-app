import 'dart:convert';
import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';
import 'package:tivra_health/data/remote/web_common_response.dart';
import 'package:tivra_health/data/remote/web_constants.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';
import 'package:tivra_health/data/remote/web_service.dart';

import 'device_registration_response.dart';


class DeviceRegistrationRepository {
  final Webservice webservice;
  final SharedPrefs sharedPrefs;
  dynamic returnResponse;

  DeviceRegistrationRepository(
      {required this.webservice, required this.sharedPrefs});

  Future<dynamic> mDeviceRegistration(
      dynamic mDeviceRegistrationRequest) async {
    final response = await webservice.postWithRequestWithoutAuth(
        WebConstants.actionDeviceRegistration,
        mDeviceRegistrationRequest);
    try {
      WebCommonResponse mWebCommonResponse =
      WebCommonResponse.fromJson(response);
      if (mWebCommonResponse.statusCode.toString() == "200") {
        DeviceRegistrationResponse mDeviceRegistrationResponse =
        DeviceRegistrationResponse.fromJson(json.decode(mWebCommonResponse.data));
        returnResponse = mDeviceRegistrationResponse;
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
