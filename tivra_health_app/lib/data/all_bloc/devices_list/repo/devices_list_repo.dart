import 'dart:convert';
import 'dart:developer';

import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';
import 'package:tivra_health/data/remote/web_common_response.dart';
import 'package:tivra_health/data/remote/web_constants.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';
import 'package:tivra_health/data/remote/web_service.dart';

import 'devices_list_response.dart';


class DevicesListRepository {
  final Webservice webservice;
  final SharedPrefs sharedPrefs;
  dynamic returnResponse;

  DevicesListRepository({required this.webservice, required this.sharedPrefs});

  Future<dynamic> fetchDevicesList(dynamic mStringRequest) async {
    final response = await webservice
        .getWithOutAuthAndStringRequest(WebConstants.actionDevicesList,mStringRequest);

    try {
      WebCommonResponse mWebCommonResponse =
          WebCommonResponse.fromJson(response);
      if (mWebCommonResponse.statusCode.toString() == "200") {
        String sValue = "{\"data\":${mWebCommonResponse.data}}";
        DevicesListResponse dashboardResponse = DevicesListResponse.fromJson(json.decode(sValue));
        await sharedPrefs.setDeviceList(sValue);
        returnResponse = dashboardResponse;
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
