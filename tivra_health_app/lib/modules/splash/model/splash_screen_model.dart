import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tivra_health/common/alert/app_alert.dart';
import 'package:tivra_health/common/app_constants.dart';
import 'package:tivra_health/common/message_constants.dart';
import 'package:tivra_health/common/utils/network_utils.dart';
import 'package:tivra_health/data/all_bloc/all_image/bloc/all_image_data_bloc.dart';
import 'package:tivra_health/data/all_bloc/all_image/bloc/all_image_data_event.dart';
import 'package:tivra_health/data/all_bloc/all_image/bloc/all_image_data_state.dart';
import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';
import 'package:tivra_health/routes/route_constants.dart';

class SplashScreenModel {
  final BuildContext mContext;

  SplashScreenModel(this.mContext);

  initSharedPreferencesInstance() async {
    await SharedPrefs().sharedPreferencesInstance();
  }

  String sUserDetails = "";
  String sFirstLaunch = "";

  getUserDetails() async {
    sFirstLaunch = await SharedPrefs().getFirstLaunch();
    if(sFirstLaunch == "false") {
      sUserDetails = await SharedPrefs().getUserId();
      if (sUserDetails.isNotEmpty) {
        nextWidget(RouteConstants.rDashboardScreenWidget);
      }
    } else {
      nextWidget(RouteConstants.rLoginScreenWidget);
    }
  }

  nextWidget(String sNext) {
    if (sNext.isNotEmpty) {
      Future.delayed(const Duration(milliseconds: 200), () {
        Navigator.pushNamedAndRemoveUntil(mContext, sNext, (route) => false);
      });
    }
  }

  /// AllImage Api
  late AllImageBloc _mAllImageBloc;

  setAllImageBloc() {
    _mAllImageBloc = AllImageBloc();
  }

  getAllImageBloc() {
    return _mAllImageBloc;
  }

  onRefresh() async {
    initAllImage();
  }

  Future<void> initAllImage() async {
    await NetworkUtils().checkInternetConnection().then((isInternetAvailable) {
      if (isInternetAvailable) {
        _mAllImageBloc.add(const AllImageClickEvent(mStringRequest: ""));
      } else {
        AppAlert.showSnackBar(mContext, MessageConstants.noInternetConnection);
      }
    });
  }

  blocAllImageListener(BuildContext context, AllImageState state) {
    switch (state.status) {
      case AllImageStatus.loading:
        AppAlert.showProgressDialog(context);
        break;
      case AllImageStatus.failed:
        loadEnd();
        if (state.webResponseFailed != null) {
          AppAlert.showSnackBar(
              context, state.webResponseFailed!.statusMessage ?? "");
        } else {
          AppAlert.showSnackBar(
              mContext, AppConstants.mWordConstants.wSomethingWentWrong);
        }
        break;
      case AllImageStatus.success:
        // setList(state.mAllImageResponse!);
        loadEnd();
        getUserDetails();
        break;
    }
  }

  void loadEnd() {
    AppAlert.closeDialog(mContext);
  }

  /// AllImageState

// var responseSubject = PublishSubject<AllImageResponse?>();
//
// Stream<AllImageResponse?> get responseStream =>
//     responseSubject.stream;
//
// void closeObservable() {
//   responseSubject.close();
// }
//
// void setList(AllImageResponse state) async {
//   try {
//     responseSubject.sink.add(state);
//   } catch (e) {
//     responseSubject.sink.addError(e);
//   }
// }
}
