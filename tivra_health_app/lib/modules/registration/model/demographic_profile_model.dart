import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tivra_health/common/alert/app_alert.dart';
import 'package:tivra_health/common/app_constants.dart';
import 'package:tivra_health/common/message_constants.dart';
import 'package:tivra_health/common/utils/date_utils.dart';
import 'package:tivra_health/common/utils/network_utils.dart';
import 'package:tivra_health/data/all_bloc/demographic_profile/bloc/tivra_health_demographic_profile_bloc.dart';
import 'package:tivra_health/data/all_bloc/demographic_profile/bloc/tivra_health_demographic_profile_event.dart';
import 'package:tivra_health/data/all_bloc/demographic_profile/repo/tivra_health_demographic_profile_request.dart';
import 'package:tivra_health/data/all_bloc/get_user_details/bloc/get_user_details_bloc.dart';
import 'package:tivra_health/data/all_bloc/get_user_details/bloc/get_user_details_event.dart';
import 'package:tivra_health/data/all_bloc/get_user_details/bloc/get_user_details_state.dart';
import 'package:tivra_health/data/all_bloc/get_user_details/repo/get_user_details_response.dart';
import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';
import 'package:rxdart/rxdart.dart';

class DemographicProfileModel {
  final BuildContext cBuildContext;

  DemographicProfileModel(this.cBuildContext);

  var scaffoldKey = GlobalKey<ScaffoldState>();

  List<DateTime?> dialogCalendarPickerValue = [];
  List<String?> stringCalendarPickerValue = [];

  TextEditingController mStreetAddress1Controller = TextEditingController();
  TextEditingController mStreetAddress2Controller = TextEditingController();
  TextEditingController mCityController = TextEditingController();
  TextEditingController mStateController = TextEditingController();
  TextEditingController mZipcodeController = TextEditingController();
  TextEditingController mCountryController = TextEditingController();
  TextEditingController mDateOfBirthController = TextEditingController();
  String selectedGender = "";

  bool streetAdd1Validator = false;
  bool cityValidator = false;
  bool stateValidator = false;
  bool zipcodeValidator = false;
  bool countryValidator = false;
  bool dobValidator = false;
  bool genderValidator = false;

  List<String> sMenuItems = ["Male", "Female"];

  setGender(String gender) {
    selectedGender = gender;
  }

  bool isValidAdd1() {
    return !mStreetAddress1Controller.text.isNotEmpty;
  }

  bool isValidCity() {
    return !mCityController.text.isNotEmpty;
  }

  bool isValidState() {
    return !mStateController.text.isNotEmpty;
  }

  bool isValidZipcode() {
    return !mZipcodeController.text.isNotEmpty;
  }

  bool isValidCountry() {
    return !mCountryController.text.isNotEmpty;
  }

  bool isValidDob() {
    return !mDateOfBirthController.text.isNotEmpty;
  }

  bool isValidGender() {
    return !selectedGender.isNotEmpty;
  }

  validateAllFields() {
    streetAdd1Validator = isValidAdd1();
    cityValidator = isValidCity();
    stateValidator = isValidState();
    zipcodeValidator = isValidZipcode();
    countryValidator = isValidCountry();
    genderValidator = isValidGender();
    dobValidator = isValidDob();
  }

  /// put demographic profile
  late TivraHealthDemographicProfileBloc _mTivraHealthDemographicProfileBloc;

  setTivraHealthDemographicProfileBloc() {
    _mTivraHealthDemographicProfileBloc = TivraHealthDemographicProfileBloc();
  }

  getTivraHealthDemographicProfileBloc() {
    return _mTivraHealthDemographicProfileBloc;
  }

  Future<void> putDemographicProfile() async {
    String userId = await SharedPrefs().getUserId();

    await NetworkUtils().checkInternetConnection().then((isInternetAvailable) {
      if (isInternetAvailable) {
        _mTivraHealthDemographicProfileBloc.add(
            TivraHealthDemographicProfileClickEvent(
                mTivraHealthDemographicProfileListRequest:
                    TivraHealthDemographicProfileRequest(
                        formData: FormData(
                            address1: mStreetAddress1Controller.text.toString(),
                            address2: mStreetAddress2Controller.text.toString(),
                            city: mCityController.text.toString(),
                            country: mCountryController.text.toString(),
                            dob: mDateOfBirthController.text.toString(),
                            gender: selectedGender,
                            state: mStateController.text.toString(),
                            userId: userId,
                            zip: mZipcodeController.text.toString()))));
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
    mStreetAddress1Controller.text = mGetUserDetailsResponse.demographic?.address1??"";
    mStreetAddress2Controller.text = mGetUserDetailsResponse.demographic?.address2??"";
    mCityController.text = mGetUserDetailsResponse.demographic?.city??"";
    mStateController.text = mGetUserDetailsResponse.demographic?.state??"";
    mZipcodeController.text = mGetUserDetailsResponse.demographic?.zip??"";
    mCountryController.text = mGetUserDetailsResponse.demographic?.country??"";
    mDateOfBirthController.text = getDate(mGetUserDetailsResponse.demographic?.dob??"");
    setGender(mGetUserDetailsResponse.demographic?.gender ??"");
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
