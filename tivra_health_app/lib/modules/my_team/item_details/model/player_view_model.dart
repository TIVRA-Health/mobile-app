import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tivra_health/common/alert/app_alert.dart';
import 'package:tivra_health/common/app_constants.dart';
import 'package:tivra_health/common/color_constants.dart';
import 'package:tivra_health/common/message_constants.dart';
import 'package:tivra_health/common/size_constants.dart';
import 'package:tivra_health/common/text_styles_constants.dart';
import 'package:tivra_health/common/utils/network_utils.dart';
import 'package:tivra_health/data/all_bloc/all_image/repo/all_image_data_response.dart';
import 'package:tivra_health/data/all_bloc/get_dashboard/bloc/get_dashboard_details_bloc.dart';
import 'package:tivra_health/data/all_bloc/get_dashboard/bloc/get_dashboard_details_event.dart';
import 'package:tivra_health/data/all_bloc/get_dashboard/bloc/get_dashboard_details_state.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tivra_health/data/all_bloc/get_dashboard/repo/get_dashboard_details_response.dart';
import 'package:tivra_health/data/all_bloc/get_user_details/bloc/get_user_details_bloc.dart';
import 'package:tivra_health/data/all_bloc/get_user_details/bloc/get_user_details_event.dart';
import 'package:tivra_health/data/all_bloc/get_user_details/bloc/get_user_details_state.dart';
import 'package:tivra_health/data/all_bloc/get_user_details/repo/get_user_details_response.dart';
import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';

class PlayerDetailsModel {
  final BuildContext mBuildContext;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  final String playerId;

  PlayerDetailsModel(this.mBuildContext, this.playerId);

  List<String> listDropdownData = [
    "Live",
    "Hourly",
    "Weekly",
    "Monthly",
  ];
  String selectedValue = "Live";

  List<DropdownMenuItem<String>> createList(List<String> paymentTypeList) {
    return paymentTypeList
        .map<DropdownMenuItem<String>>(
          (value) => DropdownMenuItem(
            value: value,
            child: Container(
              color: ColorConstants.cSideMenuSelectText,
              width: SizeConstants.s1 * 90,
              child: Text(
                value ?? "",
                style: getTextMedium(
                  colors: ColorConstants.cWhite,
                  size: SizeConstants.s1 * 16,
                ),
              ),
            ),
          ),
        )
        .toList();
  }

  late AllImageResponse mAllImageResponse;

  getAllImage() async {
    String sAllImage = await SharedPrefs().getAllImage();
    print("###sAllImage### ${sAllImage}");
    if (sAllImage.isNotEmpty) {
      mAllImageResponse = AllImageResponse.fromJson(jsonDecode(sAllImage));
    }
    initGetUserDetails(playerId);
  }

  /// GetDashboardDetails Api
  late GetDashboardDetailsBloc _mGetDashboardDetailsBloc;

  setDashboardDetailsBloc() {
    _mGetDashboardDetailsBloc = GetDashboardDetailsBloc();
  }

  getDashboardDetailsBloc() {
    return _mGetDashboardDetailsBloc;
  }

  onRefresh() async {
    initGetDashboardDetails(playerId);
  }

  Future<void> initGetDashboardDetails(String sUserId) async {
    await NetworkUtils().checkInternetConnection().then((isInternetAvailable) {
      if (isInternetAvailable) {
        if (selectedValue != "Live") {
          sUserId = "$sUserId/${selectedValue.toLowerCase()}";
        }

        _mGetDashboardDetailsBloc
            .add(GetDashboardDetailsClickEvent(mStringRequest: sUserId));
      } else {
        AppAlert.showSnackBar(
            mBuildContext, MessageConstants.noInternetConnection);
      }
    });
  }

  getDashboardDetailsListener(
      BuildContext context, GetDashboardDetailsState state) {
    switch (state.status) {
      case GetDashboardDetailsStatus.loading:
        AppAlert.showProgressDialog(context);
        break;
      case GetDashboardDetailsStatus.failed:
        loadEnd();
        if (state.webResponseFailed != null) {
          AppAlert.showSnackBar(
              context, state.webResponseFailed!.statusMessage ?? "");
        } else {
          AppAlert.showSnackBar(
              mBuildContext, AppConstants.mWordConstants.wSomethingWentWrong);
        }
        break;
      case GetDashboardDetailsStatus.success:
        print(
            "##mGetDashboardDetailsResponse###${jsonEncode(state.mGetDashboardDetailsResponse)}");
        // if (state.mGetDashboardDetailsResponse?.userId != null) {
        setList(state.mGetDashboardDetailsResponse!);
        // }
        loadEnd();
        break;
    }
  }

  void loadEnd() {
    AppAlert.closeDialog(mBuildContext);
  }

  /// GetDashboardDetailsState

  var responseSubject = PublishSubject<GetDashboardDetailsResponse?>();

  Stream<GetDashboardDetailsResponse?> get responseStream =>
      responseSubject.stream;

  void closeObservable() {
    responseSubject.close();
  }

  void setList(GetDashboardDetailsResponse state) async {
    try {
      responseSubject.sink.add(state);
    } catch (e) {
      responseSubject.sink.addError(e);
    }
  }

  ///

  Future<String>? getImage(String name) async {
    if (mAllImageResponse != null) {
      for (AllImageData mAllImageData in mAllImageResponse.data ?? []) {
        if (mAllImageData.imageName == name) {
          return mAllImageData.imageData ?? "";
        }
      }
      return "";
    } else {
      return "";
    }
  }

  ///getUserDetails

  // getUserDetails() async {
  //   // String sUserDetails = await SharedPrefs().getUserDetails();
  //   // print("###sUserDetails### ${sUserDetails}");
  //   // GetUserDetailsResponse mGetUserDetailsResponse =
  //   //     GetUserDetailsResponse.fromJson(jsonDecode(sUserDetails));
  //   // setUserDetails(mGetUserDetailsResponse);
  //
  //   initGetUserDetails(playerId);
  // }

  /// GetDashboardDetailsState

  var responseSubjectUserDetails = PublishSubject<GetUserDetailsResponse?>();

  Stream<GetUserDetailsResponse?> get responseStreamUserDetails =>
      responseSubjectUserDetails.stream;

  void closeObservableUserDetails() {
    responseSubject.close();
  }

  void setUserDetails(GetUserDetailsResponse state) async {
    try {
      responseSubjectUserDetails.sink.add(state);
    } catch (e) {
      responseSubjectUserDetails.sink.addError(e);
    }
  }

  /// Get user details Api
  late GetUserDetailsBloc _mGetUserDetailsBloc;

  setUserDetailsBloc() {
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
            mBuildContext, MessageConstants.noInternetConnection);
      }
    });
  }

  getUserDetailsListener(BuildContext context, GetUserDetailsState state) {
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
              mBuildContext, AppConstants.mWordConstants.wSomethingWentWrong);
        }
        break;
      case GetUserDetailsStatus.success:
        if (state.mGetUserDetailsResponse?.id != null) {
          onRefresh();
          setUserDetails(
              state.mGetUserDetailsResponse ?? GetUserDetailsResponse());
        }
        setList(GetDashboardDetailsResponse());
        loadEnd();
        break;
    }
  }
}
