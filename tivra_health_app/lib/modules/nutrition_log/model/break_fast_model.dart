import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tivra_health/common/alert/app_alert.dart';
import 'package:tivra_health/common/message_constants.dart';
import 'package:tivra_health/common/utils/network_utils.dart';
import 'package:tivra_health/data/all_bloc/food_search/bloc/food_search_bloc.dart';
import 'package:tivra_health/data/all_bloc/food_search/bloc/food_search_event.dart';
import 'package:tivra_health/data/all_bloc/food_search/repo/food_search_response.dart';
import 'package:tivra_health/data/all_bloc/nutirition_food_details/bloc/nutrition_food_details_bloc.dart';
import 'package:tivra_health/data/all_bloc/nutirition_food_details/bloc/nutrition_food_details_event.dart';
import 'package:tivra_health/data/all_bloc/nutirition_food_details/repo/nutrition_food_details_request.dart';
import 'package:tivra_health/data/all_bloc/nutirition_food_details/repo/nutrition_food_details_response.dart';
import 'package:tivra_health/data/all_bloc/nutrition_log/bloc/nutrition_log_on_date_bloc.dart';
import 'package:tivra_health/data/all_bloc/nutrition_log/bloc/nutrition_log_on_date_event.dart';
import 'package:tivra_health/data/all_bloc/nutrition_log/repo/nutrition_log_on_date_response.dart' as on_date_response;
import 'package:tivra_health/data/all_bloc/upload_food/bloc/upload_food_bloc.dart';
import 'package:tivra_health/data/all_bloc/upload_food/bloc/upload_food_event.dart';
import 'package:tivra_health/data/all_bloc/upload_food/repo/upload_food_request.dart';
import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';

class BreakFastModel {
  final BuildContext cBuildContext;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  String foodSearch = "";
  List<String> foodList = ["No option selected"];
  TextEditingController searchController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  bool showList = false;
  int selectedIndex = -1;
  List<String> uploadValues = ["0","0","0","0","0","0"];
  List<List<String>> finalResponse = [];
  BreakFastModel(this.cBuildContext);
  String selectedItem = "";
  String date = DateFormat('yyyy-MM-dd').format(DateTime.now());

  ///NutritionLog search
  late FoodSearchBloc _mFoodSearchBloc;
  late NutritionFoodDetailsBloc _mNutritionFoodDetailsBloc;
  late NutritionLogOnDateBloc _mNutritionLogOnDateBloc;
  late UploadFoodBloc _mUploadFoodBloc;

  setFoodSearchBloc() {
    _mFoodSearchBloc = FoodSearchBloc();
    _mNutritionFoodDetailsBloc = NutritionFoodDetailsBloc();
    _mNutritionLogOnDateBloc = NutritionLogOnDateBloc();
    _mUploadFoodBloc = UploadFoodBloc();
  }

  getFoodSearchBloc() {
    return _mFoodSearchBloc;
  }

  getFoodDetailsBloc() {
    return _mNutritionFoodDetailsBloc;
  }

  getNutritionLogOnDateBloc() {
    return _mNutritionLogOnDateBloc;
  }

  getUploadFoodBloc() {
    return _mUploadFoodBloc;
  }

  getFoodList() async {
    FoodSearchResponse foodSearchResponse;
    foodList.clear();
    await SharedPrefs().getFoodList().then((value) => {
      foodSearchResponse = FoodSearchResponse.fromJson(json.decode(value)),
      foodSearchResponse.data?.foods?.forEach((element) {
        foodList.add(element.description ?? "");
      }),
    });
  }

  Future<void> searchFood() async {
    await NetworkUtils().checkInternetConnection().then((isInternetAvailable) {
      if (isInternetAvailable) {
        _mFoodSearchBloc.add(FoodSearchClickEvent(mStringRequest: searchController.text));
      } else {
        AppAlert.showSnackBar(
            cBuildContext, MessageConstants.noInternetConnection);
      }
    });
  }

  Future<void> foodDetails() async {
    await NetworkUtils().checkInternetConnection().then((isInternetAvailable) {
      if (isInternetAvailable) {
        _mNutritionFoodDetailsBloc.add(NutritionFoodDetailsClickEvent(mNutritionFoodDetailsRequest: NutritionFoodDetailsRequest(
          query: "${quantityController.text} ${searchController.text}"
        ) ));
      } else {
        AppAlert.showSnackBar(
            cBuildContext, MessageConstants.noInternetConnection);
      }
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

  Future<void> getBreakFastValues() async {
    finalResponse.clear();
    on_date_response.NutritionLogOnDateResponse nutritionLogOnDateResponse;
    await SharedPrefs().getNutritionLogOnDate().then((value) => {
      nutritionLogOnDateResponse = on_date_response.NutritionLogOnDateResponse.fromJson(json.decode(value)),
      nutritionLogOnDateResponse.data?.forEach((element) {
        if(element.item == selectedItem && element.itemName != "") {
          List<String> allValues = [];
          allValues.add(element.itemName.toString());
          allValues.add(element.itemQty.toString());
          allValues.add((element.calories != "") ? getValue(element.calories.toString()) : "0");
          allValues.add((element.fat != "") ? getValue(element.fat.toString()) : "0");
          allValues.add((element.sugar != "") ? getValue(element.sugar.toString()) : "0");
          if(element.item == "breakfast") {
            allValues.add((element.protein != "")
                ? getValue(element.protein.toString())
                : "0");
          } else {
            allValues.add((element.protien != "")
                ? getValue(element.protien.toString())
                : "0");
          }
          allValues.add((element.fiber != "") ? getValue(element.fiber.toString()) : "0");
          allValues.add((element.cholesterol != "") ? getValue(element.cholesterol.toString()) : "0");
          finalResponse.add(allValues);
        }
      })
    });
  }

  uploadFoodItems(NutritionFoodDetailsResponse? nutritionFoodDetailsResponse) async {
    NutritionFoodDetailsResponse response;
    String userId = await SharedPrefs().getUserId();
    await SharedPrefs().getUploadFood().then((value) => {
      response = NutritionFoodDetailsResponse.fromJson(json.decode(value)),
      response.name?.foodNutrients?.forEach((element) {
        if (element.nutrientName?.toLowerCase() == "calories") {
          uploadValues[0] = element.value.toString();
        }
        if (element.nutrientName?.toLowerCase() == "fat") {
          uploadValues[1] = element.value.toString();
        }
        if (element.nutrientName?.toLowerCase() == "protien") {
          uploadValues[2] = element.value.toString();
        }
        if (element.nutrientName?.toLowerCase() == "protein") {
          uploadValues[2] = element.value.toString();
        }
        if (element.nutrientName?.toLowerCase() == "fiber") {
          uploadValues[3] = element.value.toString();
        }
        if (element.nutrientName?.toLowerCase() == "sugar") {
          uploadValues[4] = element.value.toString();
        }
        if (element.nutrientName?.toLowerCase() == "cholesterol") {
          uploadValues[5] = element.value.toString();
        }
      })

    });
    await NetworkUtils().checkInternetConnection().then((isInternetAvailable) {
      if (isInternetAvailable) {
        _mUploadFoodBloc
            .add(UploadFoodClickEvent(mUploadFoodRequest: UploadFoodRequest(itemQty: nutritionFoodDetailsResponse?.quantity.toString(),item: selectedItem,
            itemName: nutritionFoodDetailsResponse?.name?.foodName,userId: userId,calories: uploadValues[0],cholesterol: uploadValues[5],
        fat: uploadValues[1],fiber: uploadValues[3],protien: uploadValues[2],sugar: uploadValues[4],creationTs: date)));
      } else {
        AppAlert.showSnackBar(
            cBuildContext, MessageConstants.noInternetConnection);
      }
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
}