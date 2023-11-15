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
import 'package:tivra_health/data/all_bloc/health_and_fitness_profile/bloc/tivra_health_health_and_fitness_bloc.dart';
import 'package:tivra_health/data/all_bloc/health_and_fitness_profile/bloc/tivra_health_health_and_fitness_event.dart';
import 'package:tivra_health/data/all_bloc/health_and_fitness_profile/repo/tivra_health_health_and_fitness_request.dart';
import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';
import 'package:rxdart/rxdart.dart';

class HealthAndFitnessModel {
  final BuildContext cBuildContext;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  HealthAndFitnessModel(this.cBuildContext);

  TextEditingController mWeightController = TextEditingController();
  String selectedHeight = "";
  String selectedSmoking = "";
  String selectedChronicCondition = "";

  bool weightValidator = false;
  bool heightValidator = false;
  bool smokeValidator = false;
  bool chronicConditionValidator = false;
  int? smoker;

  List<String> sMenuItems = [
    "4 ft",
    "4.1 ft",
    "4.2 ft",
    "4.3 ft",
    "4.4 ft",
    "4.5 ft",
    "4.6 ft",
    "4.7 ft",
    "4.8 ft",
    "4.9 ft",
    "4.10 ft",
    "4.11 ft",
    "5 ft",
    "5.1 ft",
    "5.2 ft",
    "5.3 ft",
    "5.4 ft",
    "5.5 ft",
    "5.6 ft",
    "5.7 ft",
    "5.8 ft",
    "5.9 ft",
    "5.10 ft",
    "5.11 ft",
    "6 ft",
    "6.1 ft",
    "6.2 ft",
    "6.3 ft",
    "6.4 ft",
    "6.5 ft",
    "6.6 ft",
    "6.7 ft",
    "6.8 ft",
    "6.9 ft",
    "6.10 ft",
    "6.11 ft",
    "7 ft",
    "7.1 ft",
    "7.2 ft",
    "7.3 ft",
    "7.4 ft",
    "7.5 ft"
  ];

  List<String> chronicConditions = [
    "Heart diseases and stroke",
    "Diabetes",
    "Arthritis",
    "Alcohol-related health issues",
    "Cancer",
    "Obesity",
    "Alzheimer's disease",
    "Smoking-related health issue",
    "No diagnosed chronic conditions"
  ];

  setHeight(String height) {
    selectedHeight = height;
  }

  setSmoke(String smoke) {
    selectedSmoking = smoke;
  }

  setChronicCondition(String condition) {
    selectedChronicCondition = condition;
  }

  bool isValidWeight() {
    return !mWeightController.text.isNotEmpty;
  }

  bool isValidHeight() {
    return !selectedHeight.isNotEmpty;
  }

  bool isValidSmoke() {
    return !selectedSmoking.isNotEmpty;
  }

  bool isValidChronicCondition() {
    return !selectedChronicCondition.isNotEmpty;
  }

  validateAllFields() {
    heightValidator = isValidHeight();
    weightValidator = isValidWeight();
    chronicConditionValidator = isValidChronicCondition();
    smokeValidator = isValidSmoke();
  }

  /// put demographic profile
  late TivraHealthHealthAndFitnessBloc _mTivraHealthHealthAndFitnessBloc;

  setTivraHealthHealthAndFitnessBloc() {
    _mTivraHealthHealthAndFitnessBloc = TivraHealthHealthAndFitnessBloc();
  }

  getTivraHealthHealthAndFitnessBloc() {
    return _mTivraHealthHealthAndFitnessBloc;
  }

  Future<void> putHealthAndFitnessProfile() async {
    String userId = await SharedPrefs().getUserId();

    await NetworkUtils().checkInternetConnection().then((isInternetAvailable) {
      if (isInternetAvailable) {
        _mTivraHealthHealthAndFitnessBloc.add(
            TivraHealthHealthAndFitnessClickEvent(
                mTivraHealthHealthAndFitnessListRequest:
                    TivraHealthHealthAndFitnessRequest(
                        formData: FormData(
                            userId: userId,
                            chronicCondition: selectedChronicCondition,
                            height: selectedHeight,
                            smoking: selectedSmoking,
                            weight: mWeightController.text))));
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
    print("###sUserDetails### ${sUserDetails}");
    mGetUserDetailsResponse =
        GetUserDetailsResponse.fromJson(jsonDecode(sUserDetails));
    selectedChronicCondition =
        mGetUserDetailsResponse.healthFitness?.chronicCondition ?? "";
    smoker = (mGetUserDetailsResponse.healthFitness?.smoker ?? false)
        ? 1
        : 2;
    if(smoker==1) {
      setSmoke(AppConstants.mWordConstants.sYes);
    }else {
      setSmoke(AppConstants.mWordConstants.sNo);
    }
    mWeightController.text =
        mGetUserDetailsResponse.healthFitness?.weight ?? "";
    selectedHeight =
        mGetUserDetailsResponse.healthFitness?.height ?? "";
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
