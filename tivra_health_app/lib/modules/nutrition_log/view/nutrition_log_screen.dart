import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:intl/intl.dart';
import 'package:tivra_health/common/alert/app_alert.dart';
import 'package:tivra_health/common/app_constants.dart';
import 'package:tivra_health/common/appbars_constants.dart';
import 'package:tivra_health/common/size_constants.dart';
import 'package:tivra_health/data/all_bloc/nutrition_log/bloc/nutrition_log_on_date_bloc.dart';
import 'package:tivra_health/data/all_bloc/nutrition_log/bloc/nutrition_log_on_date_state.dart';
import 'package:tivra_health/modules/menu/view/side_menu_drawer.dart';
import 'package:tivra_health/modules/nutrition_log/model/nutrition_log_model.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:tivra_health/routes/route_constants.dart';

class NutritionLogScreenWidget extends StatefulWidget {
  const NutritionLogScreenWidget({super.key});

  @override
  State<NutritionLogScreenWidget> createState() =>
      _NutritionLogScreenWidgetState();
}

class _NutritionLogScreenWidgetState extends State<NutritionLogScreenWidget> {
  late NutritionLogModel mNutritionLogModel;

  @override
  void initState() {
    super.initState();
    mNutritionLogModel = NutritionLogModel(context);
    mNutritionLogModel.setNutritionLogOnDateBloc();
    mNutritionLogModel.fetchNutritionLogOnDate();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(child: _buildUI(), listeners: [
      BlocListener<NutritionLogOnDateBloc, NutritionLogOnDateState>(
        bloc: mNutritionLogModel.getNutritionLogOnDateBloc(),
        listener: (context, state) {
          blocNutritionLogOnDateListener(context, state);
        },
      ),
    ]);
  }

  _buildUI() {
    return Scaffold(
        key: mNutritionLogModel.scaffoldKey,
        appBar:
            AppBars.appBarDashboard((value) {}, mNutritionLogModel.scaffoldKey),
        drawer: SideMenuDrawer(
            sMenuType: AppConstants.mWordConstants.sNutritionLog),
        body: _buildWelcomeView());
  }

  _buildWelcomeView() {
    return SingleChildScrollView(
      child: FocusDetector(
          child: SafeArea(
              child: Column(
                children: [
                  SizedBox(
                    height: SizeConstants.s1 * 5,
                  ),
                  Container(
                      color: const Color.fromARGB(255, 241, 239, 239),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 80,
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white),
                                    child: DatePicker(
                                      DateTime.now(),
                                      initialSelectedDate: DateTime.now(),
                                      selectionColor: Color.fromARGB(255, 35, 23, 105),
                                      selectedTextColor: Colors.white,
                                      onDateChange: (date) {
                                        final DateFormat formatter =
                                        DateFormat('yyyy-MM-dd');
                                        final String formatted = formatter.format(date);
                                        setState(() {
                                          mNutritionLogModel.date = formatted;
                                          mNutritionLogModel.fetchNutritionLogOnDate();
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            const Text(
                              "Breakfast",
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            GestureDetector(
                              onTap: () {
                                List<String> items = [];
                                items.add("breakfast");
                                items.add(mNutritionLogModel.date);
                                Navigator.pushNamed(context, RouteConstants.rSearchFood, arguments: items);
                              },
                              child: breakFastCard(context, mNutritionLogModel),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Lunch",
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            GestureDetector(
                              onTap: () {
                                List<String> items = [];
                                items.add("lunch");
                                items.add(mNutritionLogModel.date);
                                Navigator.pushNamed(context, RouteConstants.rSearchFood, arguments: items);
                              },
                              child: lunchCard(context, mNutritionLogModel),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Dinner",
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            GestureDetector(
                              onTap: () {
                                List<String> items = [];
                                items.add("dinner");
                                items.add(mNutritionLogModel.date);
                                Navigator.pushNamed(context, RouteConstants.rSearchFood, arguments: items);
                              },
                              child: dinnerCard(context, mNutritionLogModel),
                            ),
                          ],
                        ),
                      )),
                ],
              ))),
    );
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
        getNutrition();
        break;
    }
  }

  getNutrition() async {
    await mNutritionLogModel.getBreakFastValues();
    await mNutritionLogModel.getLunchValues();
    await mNutritionLogModel.getDinnerValues();
    setState(() {
      mNutritionLogModel.breakFastValues;
      mNutritionLogModel.lunchValues;
      mNutritionLogModel.dinnerValues;
    });
  }
}

Widget breakFastCard(context, NutritionLogModel mNutritionLogModel) {
  List<String> energyTypes = [
    "Cal",
    "Fat",
    "Protein",
    "Fiber",
    "Suger",
    "Choles"
  ];
  List<String> energyWeights = ["(Kcal)", "(g)", "(g)", "(g)", "(g)", "(g)"];

  return Card(
    elevation: 1,
    child: Container(
      height: 150,
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
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: SizedBox(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(children: [
                    Text(
                      energyTypes[index],
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    Text(
                      energyWeights[index],
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    Text(
                      mNutritionLogModel.breakFastValues[index].toString(),
                      maxLines: 4,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 35, 23, 105),
                          fontSize: 18),
                    )
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

Widget lunchCard(context, NutritionLogModel mNutritionLogModel) {
  List<String> energyTypes = [
    "Cal",
    "Fat",
    "Protein",
    "Fiber",
    "Suger",
    "Choles"
  ];
  List<String> energyWeights = ["(Kcal)", "(g)", "(g)", "(g)", "(g)", "(g)"];
  List<String> energyCalories = ["123", "123", "123", "123", "123", "123"];

  return Card(
    elevation: 1,
    child: Container(
      height: 150,
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
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: SizedBox(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(children: [
                    Text(
                      energyTypes[index],
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    Text(
                      energyWeights[index],
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    Text(
                      mNutritionLogModel.lunchValues[index].toString(),
                      maxLines: 4,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 35, 23, 105),
                          fontSize: 18),
                    )
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

Widget dinnerCard(context, NutritionLogModel mNutritionLogModel) {
  List<String> energyTypes = [
    "Cal",
    "Fat",
    "Protein",
    "Fiber",
    "Suger",
    "Choles"
  ];
  List<String> energyWeights = ["(Kcal)", "(g)", "(g)", "(g)", "(g)", "(g)"];

  return Card(
    elevation: 1,
    child: Container(
      height: 150,
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
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: SizedBox(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(children: [
                    Text(
                      energyTypes[index],
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    Text(
                      energyWeights[index],
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    Text(
                      mNutritionLogModel.dinnerValues[index].toString(),
                      maxLines: 4,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 35, 23, 105),
                          fontSize: 18),
                    )
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
