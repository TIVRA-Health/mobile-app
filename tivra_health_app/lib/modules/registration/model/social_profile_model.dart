import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tivra_health/common/alert/app_alert.dart';
import 'package:tivra_health/common/app_constants.dart';
import 'package:tivra_health/common/message_constants.dart';
import 'package:tivra_health/common/utils/network_utils.dart';
import 'package:tivra_health/data/all_bloc/get_user_details/bloc/get_user_details_bloc.dart';
import 'package:tivra_health/data/all_bloc/get_user_details/bloc/get_user_details_event.dart';
import 'package:tivra_health/data/all_bloc/get_user_details/bloc/get_user_details_state.dart';
import 'package:tivra_health/data/all_bloc/get_user_details/repo/get_user_details_response.dart';
import 'package:tivra_health/data/all_bloc/social_profile/bloc/tivra_health_social_profile_bloc.dart';
import 'package:tivra_health/data/all_bloc/social_profile/bloc/tivra_health_social_profile_event.dart';
import 'package:tivra_health/data/all_bloc/social_profile/repo/tivra_health_social_profile_request.dart';
import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';
import 'package:rxdart/rxdart.dart';

class SocialProfileModel {
  final BuildContext cBuildContext;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  SocialProfileModel(this.cBuildContext);

  TextEditingController mHospitalSystemController = TextEditingController();
  String selectedEducation = "";
  String selectedHouseHoldIncomeRange = "";
  bool selectedHealthCare = false;

  bool incomeRangeValidator = false;
  bool educationValidator = false;
  bool healthCareValidator = false;
  bool setHealthCareValue = false;
  int? healthCare;

  List<String> sMenuItems = [
    "No formal education",
    "Primary education",
    "Secondary education or high school",
    "GED",
    "Vocational qualification",
    "Bachelor's degree",
    "Master's degree",
    "Doctorate or higher"
  ];

  List<String> sHouseHoldIncomeRange = [
    "Below \$60K",
    "\$60K to \$80K",
    "\$80K to \$100K",
    "\$100K to \$150K",
    "\$150K to \$250K",
    "Above \$250",
  ];

  setEducation(String education) {
    selectedEducation = education;
  }

  setHouseHoldIncomeRange(String incomeRange) {
    selectedHouseHoldIncomeRange = incomeRange;
  }

  setHealthCare(bool healthCare) {
    setHealthCareValue = true;
    selectedHealthCare = healthCare;
  }

  bool isValidIncomeRange() {
    return !selectedHouseHoldIncomeRange.isNotEmpty;
  }

  bool isValidEducation() {
    return !selectedEducation.isNotEmpty;
  }

  bool isValidHealthCare() {
    return !setHealthCareValue;
  }

  validateAllFields() {
    incomeRangeValidator = isValidIncomeRange();
    educationValidator = isValidEducation();
    healthCareValidator = isValidHealthCare();
  }

  late TivraHealthSocialProfileBloc _mTivraHealthSocialProfileBloc;

  setTivraHealthSocialProfileBloc() {
    _mTivraHealthSocialProfileBloc = TivraHealthSocialProfileBloc();
  }

  getTivraHealthSocialProfileBloc() {
    return _mTivraHealthSocialProfileBloc;
  }

  Future<void> putSocialProfile() async {
    String userId = await SharedPrefs().getUserId();

    await NetworkUtils().checkInternetConnection().then((isInternetAvailable) {
      if (isInternetAvailable) {
        _mTivraHealthSocialProfileBloc.add(TivraHealthSocialProfileClickEvent(
            mTivraHealthRSocialProfileListRequest:
                TivraHealthSocialProfileRequest(
                    formData: FormData(
                        userId: userId,
                        educationLevel: selectedEducation,
                        healthCare: selectedHealthCare,
                        hospitalAssociated:
                            mHospitalSystemController.text.toString(),
                        incomeRange: selectedHouseHoldIncomeRange))));
      } else {
        AppAlert.showSnackBar(
            cBuildContext, MessageConstants.noInternetConnection);
      }
    });
  }

  /// Get user details Api
  late GetUserDetailsBloc _mGetUserDetailsBloc;

  setDashboardDetailsBloc() {
    _mGetUserDetailsBloc = GetUserDetailsBloc();
  }

  getUserDetailsBloc() {
    return _mGetUserDetailsBloc;
  }

  Future<void> initGetUserDetails() async {
    String userId = await SharedPrefs().getUserId();

    await NetworkUtils().checkInternetConnection().then((isInternetAvailable) {
      if (isInternetAvailable) {
        _mGetUserDetailsBloc
            .add(GetUserDetailsClickEvent(mStringRequest: userId));
      } else {
        AppAlert.showSnackBar(
            cBuildContext, MessageConstants.noInternetConnection);
      }
    });
  }

  getUserDetailsListener(
      BuildContext context, GetUserDetailsState state) async {
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
        await SharedPrefs()
            .setUserDetails(jsonEncode(state.mGetUserDetailsResponse));
        loadEnd();
        Navigator.pop(context, "return");
        break;
    }
  }

  void loadEnd() {
    AppAlert.closeDialog(cBuildContext);
  }

  ///

  late GetUserDetailsResponse mGetUserDetailsResponse;

  getUserDetails() async {
    String sUserDetails = await SharedPrefs().getUserDetails();
    mGetUserDetailsResponse =
        GetUserDetailsResponse.fromJson(jsonDecode(sUserDetails));
    mHospitalSystemController.text =
        mGetUserDetailsResponse.socialProfile?.hospitalAssociated ?? "";
    setEducation(mGetUserDetailsResponse.socialProfile?.educationLevel ?? "");
    setHouseHoldIncomeRange(
        mGetUserDetailsResponse.socialProfile?.incomeRange ?? "");
    healthCare =
        (mGetUserDetailsResponse.socialProfile?.healthCare ?? false) ? 1 : 2;
    if (healthCare == 1) {
      setHealthCare(true);
    } else {
      setHealthCare(false);
    }
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
