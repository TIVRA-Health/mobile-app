import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:tivra_health/common/alert/app_alert.dart';
import 'package:tivra_health/common/appbars_constants.dart';
import 'package:tivra_health/common/button_constants.dart';
import 'package:tivra_health/common/size_constants.dart';
import 'package:tivra_health/data/all_bloc/food_search/bloc/food_search_bloc.dart';
import 'package:tivra_health/data/all_bloc/food_search/bloc/food_search_state.dart';
import 'package:tivra_health/data/all_bloc/nutirition_food_details/bloc/nutrition_food_details_bloc.dart';
import 'package:tivra_health/data/all_bloc/nutirition_food_details/bloc/nutrition_food_details_state.dart';
import 'package:tivra_health/data/all_bloc/nutrition_log/bloc/nutrition_log_on_date_bloc.dart';
import 'package:tivra_health/data/all_bloc/nutrition_log/bloc/nutrition_log_on_date_state.dart';
import 'package:tivra_health/data/all_bloc/upload_food/bloc/upload_food_bloc.dart';
import 'package:tivra_health/data/all_bloc/upload_food/bloc/upload_food_state.dart';
import 'package:tivra_health/modules/nutrition_log/model/break_fast_model.dart';

class BreakFastScreen extends StatefulWidget {
  final List<String> item;
  const BreakFastScreen({super.key, required this.item});

  @override
  State<BreakFastScreen> createState() => _BreakFastScreen();
}

class _BreakFastScreen extends State<BreakFastScreen> {
  late BreakFastModel mBreakFastModel;

  @override
  void initState() {
    super.initState();
    mBreakFastModel = BreakFastModel(context);
    mBreakFastModel.setFoodSearchBloc();
    mBreakFastModel.fetchNutritionLogOnDate();
    mBreakFastModel.date = widget.item[1];
    mBreakFastModel.selectedItem = widget.item[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBars.appBarBack((value) {}, mBreakFastModel.scaffoldKey),
        body: MultiBlocListener(child: _buildUI(), listeners: [
          BlocListener<FoodSearchBloc, FoodSearchState>(
            bloc: mBreakFastModel.getFoodSearchBloc(),
            listener: (context, state) {
              blocFoodSearchListener(context, state);
            },
          ),
          BlocListener<NutritionFoodDetailsBloc, NutritionFoodDetailsState>(
            bloc: mBreakFastModel.getFoodDetailsBloc(),
            listener: (context, state) {
              blocNutritionFoodDetailsListener(context, state);
            },
          ),
          BlocListener<NutritionLogOnDateBloc, NutritionLogOnDateState>(
            bloc: mBreakFastModel.getNutritionLogOnDateBloc(),
            listener: (context, state) {
              blocNutritionLogOnDateListener(context, state);
            },
          ),
          BlocListener<UploadFoodBloc, UploadFoodState>(
            bloc: mBreakFastModel.getUploadFoodBloc(),
            listener: (context, state) {
              blocUploadFoodListener(context, state);
            },
          ),
        ]));
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    mBreakFastModel.searchController.dispose();
    mBreakFastModel.quantityController.dispose();
    super.dispose();
  }

  _buildUI() {
    return Scaffold(
        body: Container(
            margin: const EdgeInsets.all(10),
            child: Stack(
              children: [
                Container(
                    height: SizeConstants.height,
                    margin: const EdgeInsets.fromLTRB(10, 80, 10, 10),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          if (mBreakFastModel.showList)
                            mBreakFastModel.foodList.isNotEmpty &&
                                    mBreakFastModel
                                        .searchController.text.isNotEmpty
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: mBreakFastModel.foodList.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return ListTile(
                                        title: Text(
                                            mBreakFastModel.foodList[index]),
                                        onTap: () {
                                          setState(() {
                                            mBreakFastModel.selectedIndex =
                                                index;
                                            mBreakFastModel
                                                    .searchController.text =
                                                mBreakFastModel.foodList[index];
                                            mBreakFastModel.showList = false;
                                          });
                                        },
                                      );
                                    },
                                  )
                                : Container(),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: mBreakFastModel.finalResponse.length,
                              itemBuilder: (BuildContext context, int index) {
                                return snacksCard(context, mBreakFastModel.finalResponse[index]);
                              })
                        ],
                      ),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: SizeConstants.width / 2,
                      height: 60,
                      child: TextField(
                        decoration: const InputDecoration(
                          filled: true,
                          hintText: "Enter food item",
                        ),
                        controller: mBreakFastModel.searchController,
                        onChanged: (value) {
                          if (value.length > 2) {
                            Future.delayed(const Duration(seconds: 1))
                                .then((value) {
                              FocusScope.of(context).unfocus();
                              mBreakFastModel.searchFood();
                              print("###$value");
                            });
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 60,
                      width: SizeConstants.width / 5,
                      child: TextField(
                        decoration: const InputDecoration(
                          filled: true,
                          hintText: "Qty",
                        ),
                        controller: mBreakFastModel.quantityController,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    Container(
                        alignment: Alignment.center,
                        height: 40,
                        width: SizeConstants.width / 5,
                        child: rectangleRoundedCornerButton("Add", () {
                          if (mBreakFastModel
                              .searchController.text.isNotEmpty &&
                              mBreakFastModel
                                  .quantityController.text.isNotEmpty) {
                            mBreakFastModel.foodDetails();
                          }
                        }, textColor: Colors.white)),
                  ],
                ),
              ],
            )));
  }

  Widget snacksCard(context, List<String> finalResponse) {
    List<String> energyTypes = [
      "Item Name",
      "Qty",
      "Cal",
      "Fat",
      "Sugar",
      "Protein",
      "Fiber",
      "Cholesterol",
    ];

    return Card(
      elevation: 1,
      child: Container(
        height: 200,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: StaggeredGridView.countBuilder(
          staggeredTileBuilder: (int index) => const StaggeredTile.fit(1),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: energyTypes.length,
          crossAxisCount: 3,
          crossAxisSpacing: 3,
          mainAxisSpacing: 3,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: SizedBox(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(children: [
                      Container(
                        child: Text(
                          energyTypes[index],
                          style:
                          const TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ),
                      Container(
                        height: 40,
                        alignment: Alignment.center,
                        child: Text(
                        finalResponse[index],
                        maxLines: 4,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 35, 23, 105),
                            fontSize: 16),
                      ),)
                    ]),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  blocFoodSearchListener(BuildContext context, FoodSearchState state) {
    switch (state.status) {
      case FoodSearchStatus.loading:
        AppAlert.showProgressDialog(context);
        break;
      case FoodSearchStatus.failed:
        AppAlert.closeDialog(context);
        AppAlert.showSnackBar(
            context, state.webResponseFailed?.statusMessage ?? "");
        break;
      case FoodSearchStatus.success:
        AppAlert.closeDialog(context);
        getFoodList();
        break;
    }
  }

  blocNutritionFoodDetailsListener(
      BuildContext context, NutritionFoodDetailsState state) {
    switch (state.status) {
      case NutritionFoodDetailsStatus.loading:
        AppAlert.showProgressDialog(context);
        break;
      case NutritionFoodDetailsStatus.failed:
        AppAlert.closeDialog(context);
        AppAlert.showSnackBar(
            context, state.webResponseFailed?.statusMessage ?? "");
        break;
      case NutritionFoodDetailsStatus.success:
        AppAlert.closeDialog(context);
        mBreakFastModel.uploadFoodItems(state.mNutritionFoodDetailsResponse);
        break;
    }
  }

  blocNutritionLogOnDateListener(
      BuildContext context, NutritionLogOnDateState state) {
    switch (state.status) {
      case NutritionLogOnDateStatus.loading:
        AppAlert.showProgressDialog(context);
        break;
      case NutritionLogOnDateStatus.failed:
        AppAlert.closeDialog(context);
        AppAlert.showSnackBar(
            context, state.webResponseFailed?.statusMessage ?? "");
        break;
      case NutritionLogOnDateStatus.success:
        AppAlert.closeDialog(context);
        getValues();
        break;
    }
  }

  blocUploadFoodListener(
      BuildContext context, UploadFoodState state) {
    switch (state.status) {
      case UploadFoodStatus.loading:
        AppAlert.showProgressDialog(context);
        break;
      case UploadFoodStatus.failed:
        AppAlert.closeDialog(context);
        AppAlert.showSnackBar(
            context, state.webResponseFailed?.statusMessage ?? "");
        break;
      case UploadFoodStatus.success:
        AppAlert.closeDialog(context);
        mBreakFastModel.searchController.clear();
        mBreakFastModel.quantityController.clear();
        mBreakFastModel.fetchNutritionLogOnDate();
        break;
    }
  }

  getValues() async {
    await mBreakFastModel.getBreakFastValues();
    setState(() {
      mBreakFastModel.finalResponse;
    });
  }

  getFoodList() async {
    await mBreakFastModel.getFoodList();
    setState(() {
      mBreakFastModel.showList = true;
      mBreakFastModel.foodList;
    });
  }
}
