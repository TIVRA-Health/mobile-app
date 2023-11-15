import 'dart:convert';

import 'package:tivra_health/data/all_bloc/devices_list/repo/devices_list_response.dart';
import 'package:tivra_health/data/all_bloc/my_team_list/repo/my_team_list_response.dart';
import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';
import 'package:tivra_health/data/remote/web_common_response.dart';
import 'package:tivra_health/data/remote/web_constants.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';
import 'package:tivra_health/data/remote/web_service.dart';


class MyTeamListRepository {
  final Webservice webservice;
  final SharedPrefs sharedPrefs;
  dynamic returnResponse;

  MyTeamListRepository({required this.webservice, required this.sharedPrefs});

  Future<dynamic> fetchMyTeamList(dynamic mStringRequest) async {
    final response = await webservice
        .getWithOutAuthAndStringRequest(WebConstants.actionMyTeamList,mStringRequest);

    try {
      WebCommonResponse mWebCommonResponse =
          WebCommonResponse.fromJson(response);
      if (mWebCommonResponse.statusCode.toString() == "200") {
        String sValue = "{\"data\":${mWebCommonResponse.data}}";
        MyTeamListResponse dashboardResponse =
            MyTeamListResponse.fromJson(json.decode(sValue));
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
