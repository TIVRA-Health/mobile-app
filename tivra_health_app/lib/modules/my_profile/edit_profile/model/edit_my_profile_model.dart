import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tivra_health/data/all_bloc/get_user_details/repo/get_user_details_response.dart';
import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';

class EditMyProfileScreenModel {
  final BuildContext context;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  final Function onRefreshPage;

  EditMyProfileScreenModel(this.context, this.onRefreshPage);

  getUserDetails() async {
    String sUserDetails = await SharedPrefs().getUserDetails();
    print("###sUserDetails### ${sUserDetails}");
    GetUserDetailsResponse mGetUserDetailsResponse =
        GetUserDetailsResponse.fromJson(jsonDecode(sUserDetails));
    setUserDetailsList(mGetUserDetailsResponse);
  }

  /// GetDashboardDetailsState

  var responseSubject = PublishSubject<GetUserDetailsResponse?>();

  Stream<GetUserDetailsResponse?> get responseStream => responseSubject.stream;

  void closeObservable() {
    responseSubject.close();
  }

  void setUserDetailsList(GetUserDetailsResponse state) async {
    try {
      responseSubject.sink.add(state);
    } catch (e) {
      responseSubject.sink.addError(e);
    }
  }
}
