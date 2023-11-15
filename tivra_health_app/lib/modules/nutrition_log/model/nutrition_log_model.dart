import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tivra_health/common/alert/app_alert.dart';
import 'package:tivra_health/common/message_constants.dart';
import 'package:tivra_health/common/utils/network_utils.dart';
import 'package:tivra_health/data/all_bloc/nutrition_log/bloc/nutrition_log_on_date_bloc.dart';
import 'package:tivra_health/data/all_bloc/nutrition_log/bloc/nutrition_log_on_date_event.dart';
import 'package:tivra_health/data/all_bloc/nutrition_log/repo/nutrition_log_on_date_response.dart';
import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';

class NutritionLogModel {
  final BuildContext cBuildContext;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  NutritionLogModel(this.cBuildContext);

  List<int> breakFastValues = [0, 0, 0, 0, 0, 0];
  List<int> lunchValues = [0, 0, 0, 0, 0, 0];
  List<int> dinnerValues = [0, 0, 0, 0, 0, 0];
  String date = DateFormat('yyyy-MM-dd').format(DateTime.now());

  ///NutritionLog On Date
  late NutritionLogOnDateBloc _mNutritionLogOnDateBloc;

  setNutritionLogOnDateBloc() {
    _mNutritionLogOnDateBloc = NutritionLogOnDateBloc();
  }

  getNutritionLogOnDateBloc() {
    return _mNutritionLogOnDateBloc;
  }

  Future<void> getBreakFastValues() async {
    breakFastValues = [0, 0, 0, 0, 0, 0];
    NutritionLogOnDateResponse nutritionLogOnDateResponse;
    await SharedPrefs().getNutritionLogOnDate().then((value) => {
      nutritionLogOnDateResponse = NutritionLogOnDateResponse.fromJson(json.decode(value)),
      nutritionLogOnDateResponse.data?.forEach((element) {
        if(element.item == "breakfast") {
          breakFastValues[0] = breakFastValues[0] + int.parse((element.calories != "" ? getValue(element.calories.toString()) : "0").toString());
          breakFastValues[1] = breakFastValues[1] + int.parse((element.fat != "" ? getValue(element.fat.toString()) : "0").toString());
          breakFastValues[2] = breakFastValues[2] + 0; //int.parse(((element.protein != null || element.protein != "") ? getValue(element.protein.toString()) : "0").toString());
          breakFastValues[3] = breakFastValues[3] + int.parse((element.fiber != "" ? getValue(element.fiber.toString()) : "0").toString());
          breakFastValues[4] = breakFastValues[4] + int.parse((element.sugar != "" ? getValue(element.sugar.toString()) : "0").toString());
          breakFastValues[5] = breakFastValues[5] + int.parse((element.cholesterol != "" ? getValue(element.cholesterol.toString()) : "0").toString());
        }
      })
    });
  }


  String getValue(String value) {
    String elementValue = "";
    if(value.contains(".")) {
      elementValue = value.substring(0,(value.indexOf(".")));
      return elementValue;
    }
    return value;
  }

  Future<void> getLunchValues() async {
    lunchValues = [0, 0, 0, 0, 0, 0];
    NutritionLogOnDateResponse nutritionLogOnDateResponse;
    await SharedPrefs().getNutritionLogOnDate().then((value) => {
      nutritionLogOnDateResponse = NutritionLogOnDateResponse.fromJson(json.decode(value)),
      nutritionLogOnDateResponse.data?.forEach((element) {
        if(element.item == "lunch") {
          lunchValues[0] = lunchValues[0] + int.parse((element.calories != "" ? getValue(element.calories.toString()) : "0").toString());
          lunchValues[1] = lunchValues[1] + int.parse((element.fat != "" ? getValue(element.fat.toString()) : "0").toString());
          lunchValues[2] = lunchValues[2] + 0; //int.parse(((element.protein != null || element.protein != "") ? getValue(element.protien.toString()) : "0").toString());
          lunchValues[3] = lunchValues[3] + int.parse((element.fiber != "" ? getValue(element.fiber.toString()) : "0").toString());
          lunchValues[4] = lunchValues[4] + int.parse((element.sugar != "" ? getValue(element.sugar.toString()) : "0").toString());
          lunchValues[5] = lunchValues[5] + int.parse((element.cholesterol != "" ? getValue(element.cholesterol.toString()) : "0").toString());
        }
      })
    });
  }

  Future<void> getDinnerValues() async {
    dinnerValues = [0, 0, 0, 0, 0, 0];
    NutritionLogOnDateResponse nutritionLogOnDateResponse;
    await SharedPrefs().getNutritionLogOnDate().then((value) => {
      nutritionLogOnDateResponse = NutritionLogOnDateResponse.fromJson(json.decode(value)),
      nutritionLogOnDateResponse.data?.forEach((element) {
        if(element.item == "dinner") {
          dinnerValues[0] = dinnerValues[0] + int.parse((element.calories != "" ? getValue(element.calories.toString()) : "0").toString());
          dinnerValues[1] = dinnerValues[1] + int.parse((element.fat != "" ? getValue(element.fat.toString()) : "0").toString());
          dinnerValues[2] = dinnerValues[2] + 0; //int.parse(((element.protein != null || element.protein != "") ? getValue(element.protien.toString()) : "0").toString());
          dinnerValues[3] = dinnerValues[3] + int.parse((element.fiber != "" ? getValue(element.fiber.toString()) : "0").toString());
          dinnerValues[4] = dinnerValues[4] + int.parse((element.sugar != "" ? getValue(element.sugar.toString()) : "0").toString());
          dinnerValues[5] = dinnerValues[5] + int.parse((element.cholesterol != "" ? getValue(element.cholesterol.toString()) : "0").toString());
        }
      })
    });
  }

  Future<void> fetchNutritionLogOnDate() async {
    String userId = await SharedPrefs().getUserId();
    await NetworkUtils().checkInternetConnection().then((isInternetAvailable) {
      if (isInternetAvailable) {
        _mNutritionLogOnDateBloc
            .add(NutritionLogOnDateClickEvent(mStringRequest: "$userId/$date"));
      } else {
        AppAlert.showSnackBar(
            cBuildContext, MessageConstants.noInternetConnection);
      }
    });
  }
}
