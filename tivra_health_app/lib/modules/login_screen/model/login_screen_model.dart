import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tivra_health/common/alert/app_alert.dart';
import 'package:tivra_health/common/app_constants.dart';
import 'package:tivra_health/common/message_constants.dart';
import 'package:tivra_health/common/utils/network_utils.dart';
import 'package:tivra_health/data/all_bloc/get_user_details/bloc/get_user_details_bloc.dart';
import 'package:tivra_health/data/all_bloc/get_user_details/bloc/get_user_details_event.dart';
import 'package:tivra_health/data/all_bloc/get_user_details/bloc/get_user_details_state.dart';
import 'package:tivra_health/data/all_bloc/tivra_health_login/bloc/tivra_health_login_screen_bloc.dart';
import 'package:tivra_health/data/all_bloc/tivra_health_login/bloc/tivra_health_login_screen_event.dart';
import 'package:tivra_health/data/all_bloc/tivra_health_login/bloc/tivra_health_login_screen_state.dart';
import 'package:tivra_health/data/all_bloc/tivra_health_login/repo/tivra_health_login_screen_request.dart';
import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';
import 'package:tivra_health/routes/route_constants.dart';

class LoginScreenModel {
  final BuildContext cBuildContext;
  bool isRemember = false;

  TextEditingController mUserNameTextEditingController =
      TextEditingController();
  TextEditingController mPasswordTextEditingController =
      TextEditingController();

  LoginScreenModel(this.cBuildContext);

  getRemember() async {
    // "techsupport@tivrahealth.com";
    // "Testing@123";
    String name = await SharedPrefs().getUserName();
    String password = await SharedPrefs().getUserPassword();
    mUserNameTextEditingController.text = name;
    mPasswordTextEditingController.text = password;
    if (name != null && name.isNotEmpty) {
      isRemember = true;
    }
  }

  ///TivraHealthLoginScreen

  late TivraHealthLoginScreenBloc _mTivraHealthLoginScreenBloc;

  setTivraHealthLoginScreenBloc() {
    _mTivraHealthLoginScreenBloc = TivraHealthLoginScreenBloc();
  }

  getTivraHealthLoginScreenBloc() {
    return _mTivraHealthLoginScreenBloc;
  }

  Future<void> fetchTivraHealthLoginScreenUrl() async {
    await NetworkUtils().checkInternetConnection().then((isInternetAvailable) {
      if (isInternetAvailable) {
        _mTivraHealthLoginScreenBloc.add(TivraHealthLoginScreenClickEvent(
            mTivraHealthLoginScreenListRequest: TivraHealthLoginScreenRequest(
                userName: mUserNameTextEditingController.text,
                password: mPasswordTextEditingController.text)));
      } else {
        AppAlert.showSnackBar(
            cBuildContext, MessageConstants.noInternetConnection);
      }
    });
  }

  blocTivraHealthLoginScreenListener(
      BuildContext context, TivraHealthLoginScreenState state) async {
    switch (state.status) {
      case TivraHealthLoginScreenStatus.loading:
        AppAlert.showProgressDialog(context);
        break;
      case TivraHealthLoginScreenStatus.failed:
        AppAlert.closeDialog(context);
        AppAlert.showSnackBar(
            context, state.webResponseFailed?.statusMessage ?? "");
        break;
      case TivraHealthLoginScreenStatus.success:
        AppAlert.closeDialog(context);

        AppAlert.showSnackBar(
            context, state.mTivraHealthLoginScreenResponse?.message ?? "");

        if (state.mTivraHealthLoginScreenResponse?.token != null) {
          if (isRemember) {
            await SharedPrefs()
                .setUserName(mUserNameTextEditingController.text);
            await SharedPrefs()
                .setUserPassword(mPasswordTextEditingController.text);
          } else {
            await SharedPrefs().setUserName("");
            await SharedPrefs().setUserPassword("");
          }
          initGetUserDetails(
              state.mTivraHealthLoginScreenResponse?.userId ?? "0");
        }

        break;
    }
  }

  /// Get user details Api
  late GetUserDetailsBloc _mGetUserDetailsBloc;

  setDashboardDetailsBloc() {
    _mGetUserDetailsBloc = GetUserDetailsBloc();
  }

  getUserDetailsBloc() {
    return _mGetUserDetailsBloc;
  }

  Future<void> initGetUserDetails(String sUserId) async {
    await NetworkUtils().checkInternetConnection().then((isInternetAvailable) {
      if (isInternetAvailable) {
        _mGetUserDetailsBloc
            .add(GetUserDetailsClickEvent(mStringRequest: sUserId));
      } else {
        AppAlert.showSnackBar(
            cBuildContext, MessageConstants.noInternetConnection);
      }
    });
  }

  getUserDetailsListener(BuildContext context, GetUserDetailsState state) async{
    switch (state.status) {
      case GetUserDetailsStatus.loading:
        AppAlert.showProgressDialog(context);
        break;
      case GetUserDetailsStatus.failed:
        loadEnd();
        if (state.webResponseFailed != null) {
          AppAlert.showSnackBar(
              context, state.webResponseFailed!.statusMessage ?? "");
        } else {
          AppAlert.showSnackBar(
              cBuildContext, AppConstants.mWordConstants.wSomethingWentWrong);
        }
        break;
      case GetUserDetailsStatus.success:
        await SharedPrefs().setUserDetails(jsonEncode(state.mGetUserDetailsResponse));
        loadEnd();
        showNextPage(RouteConstants.rDashboardScreenWidget);
        break;
    }
  }

  void loadEnd() {
    AppAlert.closeDialog(cBuildContext);
  }

  ///

  showNextPage(String nextPage, {bool bRemove = true}) async {
    if (bRemove) {
      Navigator.pushNamedAndRemoveUntil(
          cBuildContext, nextPage, (route) => false);
    } else {
      Navigator.pushNamed(cBuildContext, nextPage);
    }
  }
}
