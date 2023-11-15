import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:tivra_health/common/app_constants.dart';
import 'package:tivra_health/common/appbars_constants.dart';
import 'package:tivra_health/common/color_constants.dart';
import 'package:tivra_health/common/dashboard_common_view.dart';
import 'package:tivra_health/common/image_assets.dart';
import 'package:tivra_health/common/size_constants.dart';
import 'package:tivra_health/common/text_styles_constants.dart';
import 'package:tivra_health/common/widget/dropdown_button_view/dropdown_button2.dart';
import 'package:tivra_health/common/widget/empty_view/empty_view.dart';
import 'package:tivra_health/data/all_bloc/get_dashboard/bloc/get_dashboard_details_bloc.dart';
import 'package:tivra_health/data/all_bloc/get_dashboard/bloc/get_dashboard_details_state.dart';
import 'package:tivra_health/data/all_bloc/get_dashboard/repo/get_dashboard_details_response.dart';
import 'package:tivra_health/data/all_bloc/get_user_details/bloc/get_user_details_bloc.dart';
import 'package:tivra_health/data/all_bloc/get_user_details/bloc/get_user_details_state.dart';
import 'package:tivra_health/data/all_bloc/get_user_details/repo/get_user_details_response.dart';
import 'package:tivra_health/modules/my_team/item_details/model/player_view_model.dart';
import 'package:tivra_health/modules/my_team/item_details/view/player_fitness_chart_widget.dart';
import 'package:tivra_health/modules/my_team/item_details/view/player_fitness_screen.dart';
import 'package:tivra_health/modules/my_team/item_details/view/player_health_screen.dart';
import 'package:tivra_health/modules/my_team/item_details/view/player_nutrition_screen.dart';

class PlayerDetailsScreenWidget extends StatefulWidget {
  final String playerId;

  const PlayerDetailsScreenWidget({super.key, required this.playerId});

  @override
  State<PlayerDetailsScreenWidget> createState() =>
      _PlayerDetailsScreenWidgetState();
}

class _PlayerDetailsScreenWidgetState extends State<PlayerDetailsScreenWidget> {
  String sSelectValue = AppConstants.mWordConstants.wHealth;
  late PlayerDetailsModel mPlayerDetailsModel;

  @override
  void initState() {
    super.initState();

    mPlayerDetailsModel = PlayerDetailsModel(context, widget.playerId);
    mPlayerDetailsModel.setDashboardDetailsBloc();
    mPlayerDetailsModel.setUserDetailsBloc();
    mPlayerDetailsModel.getAllImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: mPlayerDetailsModel.scaffoldKey,
        appBar: AppBars.appBarBack((value) {}, mPlayerDetailsModel.scaffoldKey),
        body: _buildWelcomeView());
  }

  _buildWelcomeView() {
    return FocusDetector(
        onVisibilityGained: () {},
        child: MultiBlocListener(child: blocView(), listeners: [
          BlocListener<GetDashboardDetailsBloc, GetDashboardDetailsState>(
            bloc: mPlayerDetailsModel.getDashboardDetailsBloc(),
            listener: (context, state) {
              mPlayerDetailsModel.getDashboardDetailsListener(context, state);
            },
          ),
          BlocListener<GetUserDetailsBloc, GetUserDetailsState>(
            bloc: mPlayerDetailsModel.getUserDetailsBloc(),
            listener: (context, state) {
              mPlayerDetailsModel.getUserDetailsListener(context, state);
            },
          ),
        ]));
  }

  blocView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [getUserDetailsView(), Expanded(child: getView())],
    );
  }

  getUserDetailsView() {
    return StreamBuilder<GetUserDetailsResponse?>(
      stream: mPlayerDetailsModel.responseSubjectUserDetails,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          GetUserDetailsResponse mGetUserDetailsResponse =
              snapshot.data as GetUserDetailsResponse;
          return Container(
            margin: EdgeInsets.only(
                left: SizeConstants.s1 * 10,
                right: SizeConstants.s1 * 10,
                top: SizeConstants.s1 * 13,
                bottom: SizeConstants.s1 * 10),
            padding: EdgeInsets.only(
              left: SizeConstants.s1 * 10,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0, 1), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: SizeConstants.s1 * 50,
                  width: SizeConstants.s1 * 50,
                  margin: EdgeInsets.only(
                    top: SizeConstants.s1 * 15,
                    bottom: SizeConstants.s1 * 15,
                  ),
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: ColorConstants.cProfile),
                  child: Icon(Icons.person,
                      size: SizeConstants.s1 * 35, color: Colors.white),
                ),
                SizedBox(
                  width: SizeConstants.s1 * 10,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${mGetUserDetailsResponse.firstName ?? "--"} ${mGetUserDetailsResponse.middleName ?? "--"} ${mGetUserDetailsResponse.lastName ?? "--"}",
                      style: getTextMedium(
                        colors: Colors.black,
                        size: SizeConstants.s1 * 20,
                      ),
                    ),
                    SizedBox(
                      height: SizeConstants.s1 * 3,
                    ),
                    Text(
                      mGetUserDetailsResponse.roleName ?? "--",
                      style: getTextRegular(
                          size: SizeConstants.s1 * 14,
                          colors: Colors.grey.shade600),
                    )
                  ],
                )),
                SizedBox(
                  width: SizeConstants.s1 * 5,
                ),
                Container(
                    margin: EdgeInsets.only(
                      right: SizeConstants.s1 * 10,
                    ),
                    child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                      items: mPlayerDetailsModel
                          .createList(mPlayerDetailsModel.listDropdownData),
                      icon: const Icon(
                        Icons.keyboard_arrow_down_outlined,
                        color: ColorConstants.cWhite,
                      ),
                      value: mPlayerDetailsModel.selectedValue,
                      onChanged: (value) {
                        setState(() {
                          mPlayerDetailsModel.selectedValue = value as String;
                          mPlayerDetailsModel.onRefresh();
                        });
                      },
                      customButton: Container(
                          height: SizeConstants.s1 * 40,
                          width: SizeConstants.s1 * 110,
                          margin: EdgeInsets.only(
                              top: SizeConstants.s1 * 5,
                              bottom: SizeConstants.s1 * 5),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(SizeConstants.s1 * 6),
                            color: ColorConstants.cSideMenuSelectText,
                          ),
                          alignment: Alignment.center,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: SizeConstants.s1 * 10,
                              ),
                              Expanded(
                                  child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  mPlayerDetailsModel.selectedValue,
                                  style: getTextMedium(
                                    colors: ColorConstants.cWhite,
                                    size: SizeConstants.s1 * 16,
                                  ),
                                ),
                              )),
                              const Icon(
                                Icons.arrow_drop_down_sharp,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: SizeConstants.s1 * 6,
                              ),
                            ],
                          )),
                      dropdownPadding: EdgeInsets.all(SizeConstants.s1 * 0),
                      dropdownScrollPadding:
                          EdgeInsets.all(SizeConstants.s1 * 1),
                      dropdownDecoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(SizeConstants.s1 * 6),
                        color: ColorConstants.cSideMenuSelectText,
                      ),
                    ))),
              ],
            ),
          );
        }
        return Container(
          margin: EdgeInsets.only(
              left: SizeConstants.s1 * 10,
              right: SizeConstants.s1 * 10,
              top: SizeConstants.s1 * 13,
              bottom: SizeConstants.s1 * 10),
          padding: EdgeInsets.only(
            left: SizeConstants.s1 * 10,
            top: SizeConstants.s1 * 10,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(0, 1), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: SizeConstants.s1 * 50,
                width: SizeConstants.s1 * 50,
                margin: EdgeInsets.only(
                  top: SizeConstants.s1 * 15,
                  bottom: SizeConstants.s1 * 15,
                ),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: ColorConstants.cProfile),
                child: Icon(Icons.person,
                    size: SizeConstants.s1 * 35, color: Colors.white),
              ),
              SizedBox(
                width: SizeConstants.s1 * 10,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "--",
                    style: getTextMedium(
                      colors: Colors.black,
                      size: SizeConstants.s1 * 20,
                    ),
                  ),
                  SizedBox(
                    height: SizeConstants.s1 * 3,
                  ),
                  Text(
                    "--",
                    style: getTextRegular(
                        size: SizeConstants.s1 * 14,
                        colors: Colors.grey.shade600),
                  )
                ],
              )),
              SizedBox(
                width: SizeConstants.s1 * 5,
              ),
              Container(
                  margin: EdgeInsets.only(
                    right: SizeConstants.s1 * 10,
                  ),
                  child: DropdownButtonHideUnderline(
                      child: DropdownButton2(
                    items: mPlayerDetailsModel
                        .createList(mPlayerDetailsModel.listDropdownData),
                    icon: const Icon(
                      Icons.keyboard_arrow_down_outlined,
                      color: ColorConstants.cWhite,
                    ),
                    value: mPlayerDetailsModel.selectedValue,
                    onChanged: (value) {
                      setState(() {
                        mPlayerDetailsModel.selectedValue = value as String;
                        mPlayerDetailsModel.onRefresh();
                      });
                    },
                    customButton: Container(
                        height: SizeConstants.s1 * 40,
                        width: SizeConstants.s1 * 110,
                        margin: EdgeInsets.only(
                            top: SizeConstants.s1 * 5,
                            bottom: SizeConstants.s1 * 5),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(SizeConstants.s1 * 6),
                          color: ColorConstants.cSideMenuSelectText,
                        ),
                        alignment: Alignment.center,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: SizeConstants.s1 * 10,
                            ),
                            Expanded(
                                child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                mPlayerDetailsModel.selectedValue,
                                style: getTextMedium(
                                  colors: ColorConstants.cWhite,
                                  size: SizeConstants.s1 * 16,
                                ),
                              ),
                            )),
                            const Icon(
                              Icons.arrow_drop_down_sharp,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: SizeConstants.s1 * 6,
                            ),
                          ],
                        )),
                    dropdownPadding: EdgeInsets.all(SizeConstants.s1 * 0),
                    dropdownScrollPadding: EdgeInsets.all(SizeConstants.s1 * 1),
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(SizeConstants.s1 * 6),
                      color: ColorConstants.cSideMenuSelectText,
                    ),
                  ))),
            ],
          ),
        );
      },
    );
  }

  getView() {
    return StreamBuilder<GetDashboardDetailsResponse?>(
      stream: mPlayerDetailsModel.responseSubject,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          GetDashboardDetailsResponse mGetDashboardDetailsResponse =
              snapshot.data as GetDashboardDetailsResponse;
          return dashboardView(mGetDashboardDetailsResponse);
        }
        return Container();
      },
    );
  }

  dashboardView(GetDashboardDetailsResponse mGetDashboardDetailsResponse) {
    return SafeArea(
        child: Column(
      children: [
        mGetDashboardDetailsResponse.dashboardInfo == null
            ? const SizedBox()
            : Container(
                margin: EdgeInsets.only(
                    left: SizeConstants.s1 * 5, right: SizeConstants.s1 * 5),
                child: Row(
                  children: [
                    topViewShow(
                        ImageAssets.stapeIconDashboard,
                        mGetDashboardDetailsResponse.dashboardInfo?.calories ??
                            "0",
                        "Calories"),
                    topViewShow(
                        ImageAssets.stapeIconDashboard,
                        mGetDashboardDetailsResponse
                                .dashboardInfo?.stepscount ??
                            "0",
                        "Steps"),
                    topViewShow(
                        ImageAssets.stapeIconDashboard,
                        mGetDashboardDetailsResponse.dashboardInfo?.heartrate ??
                            "0",
                        "Heart Rate")
                  ],
                ),
              ),
        Container(
            margin: EdgeInsets.only(
              left: SizeConstants.s1 * 5,
              right: SizeConstants.s1 * 5,
              bottom: SizeConstants.s1 * 5,
            ),
            child: Row(
              children: [
                middleView(AppConstants.mWordConstants.wHealth, sSelectValue,
                    (String sValue) {
                  setState(() {
                    sSelectValue = sValue;
                  });
                }, ColorConstants.cWhite),
                middleView(AppConstants.mWordConstants.wFitness, sSelectValue,
                    (String sValue) {
                  setState(() {
                    sSelectValue = sValue;
                  });
                }, ColorConstants.cWhite),
                middleView(AppConstants.mWordConstants.wNutrition, sSelectValue,
                    (String sValue) {
                  setState(() {
                    sSelectValue = sValue;
                  });
                }, ColorConstants.cWhite),
              ],
            )),
        Expanded(
            child: RefreshIndicator(
                onRefresh: () async {
                  mPlayerDetailsModel.onRefresh();
                },
                child: SingleChildScrollView(
                    child: Container(
                  constraints: BoxConstraints(
                    minHeight: SizeConstants.height * 0.65,
                    minWidth: double.infinity,
                  ),
                  child: mGetDashboardDetailsResponse.dashboardInfo == null
                      ? emptyView(
                          SizeConstants.height * 0.55,
                          ImageAssets.noValueMyTeam,
                          AppConstants.mWordConstants.wMyTeamNoList)
                      : lastView(mGetDashboardDetailsResponse),
                ))))
      ],
    ));
  }

  lastView(GetDashboardDetailsResponse mGetDashboardDetailsResponse) {
    switch (sSelectValue) {
      case "Health":
        if (mPlayerDetailsModel.selectedValue != "Live") {
          return PlayerFitnessLineChartWidget(
              mPlayerModel: mPlayerDetailsModel,
              selectedValue: sSelectValue,
              mGetDashboardDetailsResponse: mGetDashboardDetailsResponse);
        } else {
          return PlayerHealthScreenWidget(
              mPlayerModel: mPlayerDetailsModel,
              health: mGetDashboardDetailsResponse.health!);
        }
      case "Fitness":
        if (mPlayerDetailsModel.selectedValue != "Live") {
          return PlayerFitnessLineChartWidget(
              mPlayerModel: mPlayerDetailsModel,
              selectedValue: sSelectValue,
              mGetDashboardDetailsResponse: mGetDashboardDetailsResponse);
        } else {
          return PlayerFitnessScreenWidget(
              mPlayerModel: mPlayerDetailsModel,
              fitness: mGetDashboardDetailsResponse.fitness!);
        }
      case "Nutrition":
        if (mPlayerDetailsModel.selectedValue != "Live") {
          return PlayerFitnessLineChartWidget(
              mPlayerModel: mPlayerDetailsModel,
              selectedValue: sSelectValue,
              mGetDashboardDetailsResponse: mGetDashboardDetailsResponse);
        } else {
          return PlayerNutritionScreenWidget(
              mPlayerModel: mPlayerDetailsModel,
              nutrition: mGetDashboardDetailsResponse.nutrition!);
        }
    }
  }
}
