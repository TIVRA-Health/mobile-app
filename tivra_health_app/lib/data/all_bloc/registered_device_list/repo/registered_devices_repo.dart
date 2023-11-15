import 'dart:convert';
import 'package:tivra_health/data/all_bloc/registered_device_list/repo/registered_devices_response.dart';
import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';
import 'package:tivra_health/data/remote/web_common_response.dart';
import 'package:tivra_health/data/remote/web_constants.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';
import 'package:tivra_health/data/remote/web_service.dart';


class RegisteredDevicesRepository {
  final Webservice webservice;
  final SharedPrefs sharedPrefs;
  dynamic returnResponse;

  RegisteredDevicesRepository(
      {required this.webservice, required this.sharedPrefs});

  Future<dynamic> mRegisteredDevices(
      dynamic mRegisteredDevicesRequest) async {
    final response = await webservice.getWithOutAuthAndStringRequest(
        WebConstants.actionDevicesList,
        mRegisteredDevicesRequest);
    try {
      WebCommonResponse mWebCommonResponse =
      WebCommonResponse.fromJson(response);
      if (mWebCommonResponse.statusCode.toString() == "200") {
        String sValue = "{\"data\":${mWebCommonResponse.data}}";
        RegisteredDevicesResponse mRegisteredDevicesResponse = RegisteredDevicesResponse.fromJson(json.decode(sValue));
        await sharedPrefs.setRegisteredDevices(sValue);
        returnResponse = mRegisteredDevicesResponse;
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
