import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tivra_health/common/alert/alert_action.dart';
import 'package:tivra_health/common/alert/app_alert.dart';
import 'package:tivra_health/common/app_constants.dart';
import 'package:tivra_health/common/message_constants.dart';
import 'package:tivra_health/common/widget/custom_image.dart';
import 'package:tivra_health/data/all_bloc/get_user_details/repo/get_user_details_response.dart';
import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';
import 'package:tivra_health/routes/route_constants.dart';
import 'package:rxdart/rxdart.dart';

class SideMenuDrawerModel {
  final BuildContext mContext;
  final String sMenuType;

  SideMenuDrawerModel(this.mContext, this.sMenuType);

  nextView(String sView) {
    if (!isSelect(sView)) {
      switch (sView) {
        case "Dashboard":
          nextWidget(RouteConstants.rDashboardScreenWidget);
          break;
        case "Profile":
          nextWidget(RouteConstants.rMyProfileScreenWidget);
          break;
        case "Devices":
          nextWidget(RouteConstants.rDevicesScreenWidget);
          break;
        case "Configure Dashboard":
          nextWidget(RouteConstants.rDashboardPreferenceScreenWidget);
          break;
        case "My Team":
          nextWidget(RouteConstants.rMyTeamScreenWidget);
          break;
        case "Nutrition Log":
          nextWidget(RouteConstants.rNutritionLogScreenWidget);
          break;
        case "Consultation":
          nextWidget(RouteConstants.rConsultationScreenWidget);
          break;
        case "My Connections":
          nextWidget(RouteConstants.rMyConnectionsScreenWidget);
          break;

        case "Logout":
          logout();
          break;
        default:
          nextWidget("");
      }
    } else {
      nextWidget("");
    }
  }

  logout() {
    AppAlert.showCustomDialogNoYes(
            mContext,
            AppConstants.mWordConstants.sLogout,
            MessageConstants.wLogoutMessage)
        .then((value) async {
      if (value == AlertAction.yes) {
        await SharedPrefs().clearSharedPreferences();
        await SharedPrefs().setUserId("");
        await SharedPrefs().setFirstLaunch("true");
        await imageCacheClear();
        Navigator.pushNamedAndRemoveUntil(
            mContext, RouteConstants.rSplashScreenWidget, (route) => false);
      } else {
        Navigator.of(mContext).pop();
      }
    });
  }

  nextWidget(String sNext) {
    Navigator.of(mContext).pop();
    if (sNext.isNotEmpty) {
      Future.delayed(const Duration(milliseconds: 200), () {
        Navigator.pushReplacementNamed(mContext, sNext);
      });
    }
  }

  isSelect(String sView) {
    return sMenuType == sView;
  }

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
