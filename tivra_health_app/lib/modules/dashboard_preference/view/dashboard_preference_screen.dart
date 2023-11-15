import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tivra_health/common/alert/app_alert.dart';
import 'package:tivra_health/common/app_constants.dart';
import 'package:tivra_health/common/appbars_constants.dart';
import 'package:tivra_health/common/color_constants.dart';
import 'package:tivra_health/common/dashboard_common_view.dart';
import 'package:tivra_health/common/image_assets.dart';
import 'package:tivra_health/common/size_constants.dart';
import 'package:tivra_health/common/text_styles_constants.dart';
import 'package:tivra_health/data/all_bloc/dashboard_config/bloc/get_dashboard_config_bloc.dart';
import 'package:tivra_health/data/all_bloc/dashboard_config/bloc/get_dashboard_config_state.dart';
import 'package:tivra_health/data/all_bloc/devices_list/bloc/devices_list_bloc.dart';
import 'package:tivra_health/data/all_bloc/devices_list/bloc/devices_list_state.dart';
import 'package:tivra_health/data/all_bloc/my_dashboard_preference/bloc/my_dashboard_preference_bloc.dart';
import 'package:tivra_health/data/all_bloc/my_dashboard_preference/bloc/my_dashboard_preference_state.dart';
import 'package:tivra_health/data/all_bloc/my_dashboard_preference/repo/my_dashboard_preference_response.dart';
import 'package:tivra_health/data/all_bloc/my_team_preference/bloc/my_team_preference_bloc.dart';
import 'package:tivra_health/data/all_bloc/my_team_preference/bloc/my_team_preference_state.dart';
import 'package:tivra_health/data/all_bloc/my_team_preference/repo/my_team_preference_response.dart';
import 'package:tivra_health/data/all_bloc/registered_device_list/bloc/registered_devices_bloc.dart';
import 'package:tivra_health/data/all_bloc/registered_device_list/bloc/registered_devices_state.dart';
import 'package:tivra_health/data/all_bloc/save_dashboard_config/bloc/save_dashboard_config_bloc.dart';
import 'package:tivra_health/data/all_bloc/save_dashboard_config/bloc/save_dashboard_config_state.dart';
import 'package:tivra_health/data/all_bloc/save_dashboard_preference/bloc/save_dashboard_bloc.dart';
import 'package:tivra_health/data/all_bloc/save_dashboard_preference/bloc/save_dashboard_state.dart';
import 'package:tivra_health/data/all_bloc/save_team_preference/bloc/save_team_bloc.dart';
import 'package:tivra_health/data/all_bloc/save_team_preference/bloc/save_team_state.dart';
import 'package:tivra_health/modules/dashboard_preference/model/dashboard_preference_model.dart';
import 'package:tivra_health/modules/menu/view/side_menu_drawer.dart';
import 'package:tivra_health/data/all_bloc/dashboard_config/repo/get_dashboard_config_response_new.dart' as config_dashboard;


class DashboardPreferenceScreenNew extends StatefulWidget {
  const DashboardPreferenceScreenNew({super.key});

  @override
  _DashboardPreferenceScreenNew createState() =>
      _DashboardPreferenceScreenNew();
}

class _DashboardPreferenceScreenNew
    extends State<DashboardPreferenceScreenNew> {
  late DashboardPreferenceModel mDashboardPreferenceModel;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  String sSelectValue = AppConstants.mWordConstants.wHealth;

  @override
  void initState() {
    super.initState();
    mDashboardPreferenceModel = DashboardPreferenceModel(context);
    mDashboardPreferenceModel.setTivraHealthDeviceListBloc();
    mDashboardPreferenceModel.apiCall();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(child: _buildUI(), listeners: [
      BlocListener<DevicesListBloc, DevicesListState>(
        bloc: mDashboardPreferenceModel.getTivraHealthDeviceListBloc(),
        listener: (context, state) {
          blocTivraHealthDevicesListListener(context, state);
        },
      ),
      BlocListener<MyDashboardPreferenceBloc, MyDashboardPreferenceState>(
        bloc: mDashboardPreferenceModel.getMyDashboardPreferenceBloc(),
        listener: (context, state) {
          blocMyDashboardPreferenceListener(context, state);
        },
      ),
      BlocListener<MyTeamPreferenceBloc, MyTeamPreferenceState>(
        bloc: mDashboardPreferenceModel.getMyTeamPreferenceBloc(),
        listener: (context, state) {
          blocMyTeamPreferenceListener(context, state);
        },
      ),
      BlocListener<RegisteredDevicesBloc, RegisteredDevicesState>(
        bloc: mDashboardPreferenceModel.getRegisteredDevicesBloc(),
        listener: (context, state) {
          blocRegisteredDevicesListener(context, state);
        },
      ),
      BlocListener<GetDashboardConfigBloc, GetDashboardConfigState>(
        bloc: mDashboardPreferenceModel.getDashboardConfigBoc(),
        listener: (context, state) {
          blocgetDashboardConfigListener(context, state);
        },
      ),
      BlocListener<SaveDashboardPreferenceBloc, SaveDashboardPreferenceState>(
        bloc: mDashboardPreferenceModel.getSaveDashboardPreferenceBloc(),
        listener: (context, state) {
          blocSaveDashboardPreferenceListener(context, state);
        },
      ),
      BlocListener<SaveTeamPreferenceBloc, SaveTeamPreferenceState>(
        bloc: mDashboardPreferenceModel.getSaveTeamPreferenceBloc(),
        listener: (context, state) {
          blocSaveTeamPreferenceListener(context, state);
        },
      ),
      BlocListener<SaveDashboardConfigBloc, SaveDashboardConfigState>(
        bloc: mDashboardPreferenceModel.getSaveDashboardConfigBloc(),
        listener: (context, state) {
          blocSaveDashboardConfigListener(context, state);
        },
      ),
    ]);
  }

  _buildUI() {
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBars.appBarDashboard((value) {}, scaffoldKey),
        drawer: SideMenuDrawer(
            sMenuType: AppConstants.mWordConstants.sConfigureDashboard),
        body: _buildPreferenceView());
  }

  _buildPreferenceView() {
    return SingleChildScrollView(
      child: Column(
        children: [
          registeredDevices(AppConstants.mWordConstants.sActiveDevices),
          _buildDeviceConfigurationUI(),
          _buildDashboardPreferenceUI(
              AppConstants.mWordConstants.sDashboardPreference),
          _buildTeamPreferenceUI(AppConstants.mWordConstants.sTeamPreference)
        ],
      ),
    );
  }

  registeredDevices(String title) {
    return Container(
      margin: EdgeInsets.only(
          bottom: SizeConstants.s1 * 15,
          left: SizeConstants.s1 * 15,
          right: SizeConstants.s1 * 15),
      padding: EdgeInsets.all(SizeConstants.s1 * 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(SizeConstants.s1 * 5),
          color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: getTextRegular(
              colors: ColorConstants.cBlack,
              size: SizeConstants.s1 * 17,
            ),
          ),
          SizedBox(
            height: SizeConstants.s_10,
          ),
          getRegisteredDevices(),
        ],
      ),
    );
  }

  getRegisteredDevices() {
    return StaggeredGridView.countBuilder(
      staggeredTileBuilder: (int index) => const StaggeredTile.fit(1),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: mDashboardPreferenceModel.sRegisteredDevices.length,
      crossAxisCount: 3,
      crossAxisSpacing: 3,
      mainAxisSpacing: 3,
      itemBuilder: (BuildContext context, int index) {
        return registeredDevicesRow(
            mDashboardPreferenceModel.sRegisteredDevices[index]);
      },
    );
  }

  registeredDevicesRow(String device) {
    return Container(
        height: SizeConstants.s1 * 50,
        margin: EdgeInsets.all(SizeConstants.s1 * 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(SizeConstants.s1 * 5),
          color: ColorConstants.cScaffoldBackgroundColor,
          border: Border.all(
              color: ColorConstants.cLightDashboardGreenTextColor,
              width: SizeConstants.s_05),
        ),
        child: SizedBox(
          height: 30,
          width: 30,
          child: FutureBuilder<String>(
              future: mDashboardPreferenceModel
                  .getImage(device),
              builder: (BuildContext context,
                  AsyncSnapshot<String> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data != null && snapshot.data!.isNotEmpty) {
                    final UriData? data =
                        Uri.parse(snapshot.data ?? "").data;
                    Uint8List myImage = data!.contentAsBytes();
                    if (snapshot.data!.contains("svg")) {
                      return SvgPicture.memory(myImage);
                    } else {
                      return Image.memory(myImage);
                    }
                  } else {
                    return Image.asset(
                      ImageAssets.heartDashboard,
                    );
                  }
                }
                return Image.asset(
                  ImageAssets.heartDashboard,
                );
              }),
        ),);
  }

  Widget _buildDeviceConfigurationUI() {
    return Container(
      margin: EdgeInsets.only(
          bottom: SizeConstants.s1 * 15,
          left: SizeConstants.s1 * 15,
          right: SizeConstants.s1 * 15),
      padding: EdgeInsets.all(SizeConstants.s1 * 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(SizeConstants.s1 * 5),
          color: Colors.white),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Set Devices",
                style: getTextRegular(
                  colors: ColorConstants.cBlack,
                  size: SizeConstants.s1 * 17,
                ),
              ),
            ],
          ),
          SizedBox(
            height: SizeConstants.s_10,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
                width: SizeConstants.width / 1.5,
                height: SizeConstants.s1 * 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    middleView(
                        AppConstants.mWordConstants.wHealth, sSelectValue,
                        (String sValue) {
                      setState(() {
                        sSelectValue = sValue;
                      });
                    }, ColorConstants.cGrey),
                    middleView(
                        AppConstants.mWordConstants.wFitness, sSelectValue,
                        (String sValue) {
                      setState(() {
                        sSelectValue = sValue;
                      });
                    }, ColorConstants.cItemBackground),
                    middleView(
                        AppConstants.mWordConstants.wNutrition, sSelectValue,
                            (String sValue) {
                          setState(() {
                            sSelectValue = sValue;
                          });
                        }, ColorConstants.cItemBackground),
                  ],
                )),
          ),
          SizedBox(
            height: SizeConstants.s_10,
          ),
          lastView(),
          SizedBox(
            height: SizeConstants.s_10,
          ),
        ],
      ),
    );
  }

  lastView() {
    switch (sSelectValue) {
      case "Health":
        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: mDashboardPreferenceModel.finalHealthValues.length,
          itemBuilder: (context, index) {
            return (mDashboardPreferenceModel.finalHealthValues.isNotEmpty)
                ? editDeviceConfigurationWidget(
                    mDashboardPreferenceModel.finalHealthValues[index], index)
                : Container();
          },
        );
      case "Fitness":
        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: mDashboardPreferenceModel.finalFitnessValues.length,
          itemBuilder: (context, index) {
            return (mDashboardPreferenceModel.finalFitnessValues.isNotEmpty)
                ? editDeviceConfigurationWidget(
                    mDashboardPreferenceModel.finalFitnessValues[index], index)
                : Container();
          },
        );
      case "Nutrition":
        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: mDashboardPreferenceModel.finalNutritionValues.length,
          itemBuilder: (context, index) {
            return (mDashboardPreferenceModel.finalNutritionValues.isNotEmpty)
                ? editDeviceConfigurationWidget(
                mDashboardPreferenceModel.finalNutritionValues[index], index)
                : Container();
          },
        );
    }
  }

  editDeviceConfigurationWidget(config_dashboard.Data data, int index) {
    return Row(
      children: [
        Container(
            width: SizeConstants.s1 * 90,
            height: SizeConstants.s1 * 80,
            padding: EdgeInsets.all(SizeConstants.s1 * 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(SizeConstants.s1 * 5),
                color: ColorConstants.cScaffoldBackgroundColor),
            margin: EdgeInsets.fromLTRB(SizeConstants.s1 * 5, 0,
                SizeConstants.s1 * 5, SizeConstants.s1 * 5),
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                  width: 30,
                  child: FutureBuilder<String>(
                      future: mDashboardPreferenceModel
                          .getImage(data.icon ?? ""),
                      builder: (BuildContext context,
                          AsyncSnapshot<String> snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data != null && snapshot.data!.isNotEmpty) {
                            final UriData? data =
                                Uri.parse(snapshot.data ?? "").data;
                            Uint8List myImage = data!.contentAsBytes();
                            if (snapshot.data!.contains("svg")) {
                              return SvgPicture.memory(myImage);
                            } else {
                              return Image.memory(myImage);
                            }
                          } else {
                            return Image.asset(
                              ImageAssets.heartDashboard,
                            );
                          }
                        }
                        return Image.asset(
                          ImageAssets.heartDashboard,
                        );
                      }),
                ),
                const SizedBox(height: 5),
                Text(
                  data.item ?? "",
                  style: getTextRegular(
                    colors: ColorConstants.cBlack,
                    size: SizeConstants.s1 * 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            )),
        Container(
            alignment: Alignment.center,
            width: SizeConstants.s1 * 200,
            height: SizeConstants.s1 * 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(SizeConstants.s1 * 5),
                color: ColorConstants.cScaffoldBackgroundColor),
            margin: EdgeInsets.fromLTRB(SizeConstants.s1 * 5, 0,
                SizeConstants.s1 * 5, SizeConstants.s1 * 5),
            child: DropdownMenu<String>(
              dropdownMenuEntries: mDashboardPreferenceModel.sRegisteredDevices
                  .map<DropdownMenuEntry<String>>((String value) {
                return DropdownMenuEntry<String>(value: value, label: value);
              }).toList(),
              width: SizeConstants.s1 * 200,
              onSelected: (value) {
                if(sSelectValue == "Health") {
                  data.userDeviceId = value;
                  mDashboardPreferenceModel.saveDashboardConfig(data);
                  mDashboardPreferenceModel.finalHealthValues[index].userDeviceId = value;
                  setState(() {
                    mDashboardPreferenceModel.finalHealthValues;
                  });
                }
                if(sSelectValue == "Fitness") {
                  data.userDeviceId = value;
                  mDashboardPreferenceModel.saveDashboardConfig(data);
                  mDashboardPreferenceModel.finalFitnessValues[index].userDeviceId = value;
                  setState(() {
                    mDashboardPreferenceModel.finalFitnessValues;
                  });
                }
                if(sSelectValue == "Nutrition") {
                  data.userDeviceId = value;
                  mDashboardPreferenceModel.saveDashboardConfig(data);
                  mDashboardPreferenceModel.finalNutritionValues[index].userDeviceId = value;
                  setState(() {
                    mDashboardPreferenceModel.finalNutritionValues;
                  });
                }
              },
              hintText: data.userDeviceId!.isNotEmpty ? data.userDeviceId : AppConstants.mWordConstants.sSelectDevice,
            )),
      ],
    );
  }

  _buildDashboardPreferenceUI(String title) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(
              bottom: SizeConstants.s1 * 15,
              left: SizeConstants.s1 * 15,
              right: SizeConstants.s1 * 15),
          padding: EdgeInsets.all(SizeConstants.s1 * 15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(SizeConstants.s1 * 5),
              color: Colors.white),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///RegisteredDevices
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: getTextRegular(
                      colors: ColorConstants.cBlack,
                      size: SizeConstants.s1 * 17,
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          mDashboardPreferenceModel
                                  .isMyDashboardPreferenceSave =
                              !mDashboardPreferenceModel
                                  .isMyDashboardPreferenceSave;
                          if (mDashboardPreferenceModel
                                  .isMyDashboardPreferenceSave ==
                              false) {
                            mDashboardPreferenceModel.saveDashboardPreference();
                          }
                        });
                      },
                      child: Text(
                        mDashboardPreferenceModel.isMyDashboardPreferenceSave
                            ? AppConstants.mWordConstants.sSave
                            : AppConstants.mWordConstants.sEdit,
                        style: getTextRegular(
                          colors: ColorConstants.cSideMenuSelectText,
                          size: SizeConstants.s1 * 17,
                        ),
                      )),
                ],
              ),
              SizedBox(
                height: SizeConstants.s1 * 15,
              ),
              SizedBox(
                child: mDashboardPreferenceModel
                        .sMyDashBoardSelectedListItems.isEmpty
                    ? SizedBox(
                        height: SizeConstants.s1 * 30,
                      )
                    : getSelectedDashboardPreference(),
              ),

              ///AllRegisteredDevices
              if (mDashboardPreferenceModel.isMyDashboardPreferenceSave)
                SizedBox(
                  child: mDashboardPreferenceModel.sMyDashBoardListItems.isEmpty
                      ? SizedBox(
                          height: SizeConstants.s1 * 30,
                        )
                      : getAllDashboardPreference(),
                ),
            ],
          ),
        ),
      ],
    );
  }

  getSelectedDashboardPreference() {
    return StaggeredGridView.countBuilder(
      staggeredTileBuilder: (int index) => const StaggeredTile.fit(1),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: mDashboardPreferenceModel.sMyDashBoardSelectedListItems.isNotEmpty ? mDashboardPreferenceModel.sMyDashBoardSelectedListItems.length : 0,
      crossAxisCount: 3,
      crossAxisSpacing: 3,
      mainAxisSpacing: 3,
      itemBuilder: (BuildContext context, int index) {
        return selectedDashboardPreferencesRow(
            mDashboardPreferenceModel.sMyDashBoardSelectedListItems[index],
            index);
      },
    );
  }

  selectedDashboardPreferencesRow(
      DashboardPreference sMyDashBoardSelectedListItem, int index) {
    return Container(
        height: SizeConstants.s1 * 70,
        margin: EdgeInsets.all(SizeConstants.s1 * 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(SizeConstants.s1 * 5),
          color: ColorConstants.cScaffoldBackgroundColor,
          border: Border.all(
              color: ColorConstants.cLightDashboardGreenTextColor,
              width: SizeConstants.s_05),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
                margin: EdgeInsets.all(SizeConstants.s1 * 10),
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                      width: 30,
                      child: FutureBuilder<String>(
                          future: mDashboardPreferenceModel
                              .getImage(sMyDashBoardSelectedListItem.icon!),
                          builder: (BuildContext context,
                              AsyncSnapshot<String> snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data != null && snapshot.data!.isNotEmpty) {
                                final UriData? data =
                                    Uri.parse(snapshot.data ?? "").data;
                                Uint8List myImage = data!.contentAsBytes();
                                if (snapshot.data!.contains("svg")) {
                                  return SvgPicture.memory(myImage);
                                } else {
                                  return Image.memory(myImage);
                                }
                              } else {
                                return Image.asset(
                                  ImageAssets.heartDashboard,
                                );
                              }
                            }
                            return Image.asset(
                              ImageAssets.heartDashboard,
                            );
                          }),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      sMyDashBoardSelectedListItem.item!,
                      style: getTextRegular(
                        colors: ColorConstants.cBlack,
                        size: SizeConstants.s1 * 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                )
            ),
            if (mDashboardPreferenceModel.isMyDashboardPreferenceSave)
              Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        mDashboardPreferenceModel.sMyDashBoardListItems
                            .add(sMyDashBoardSelectedListItem);
                        mDashboardPreferenceModel.sMyDashBoardSelectedListItems
                            .removeAt(index);
                        mDashboardPreferenceModel.isMyDashboardPreferenceSave;
                      });
                    },
                    child: Image.asset(
                      'assets/images/delete.png',
                      height: SizeConstants.s1 * 20,
                      width: SizeConstants.s1 * 20,
                    ),
                  ))
          ],
        ));
  }

  getAllDashboardPreference() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        height: SizeConstants.s1 * 90,
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: mDashboardPreferenceModel.sMyDashBoardListItems.isNotEmpty ? mDashboardPreferenceModel.sMyDashBoardListItems.length : 0,
          itemBuilder: (context, index) {
            return allDashboardPreferenceRow(
                mDashboardPreferenceModel.sMyDashBoardListItems[index], index);
          },
        ),
      ),
    );
  }

  allDashboardPreferenceRow(
      DashboardPreference sMyDashBoardListItem, int index) {
    return Container(
      width: SizeConstants.s1 * 100,
      height: SizeConstants.s1 * 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SizeConstants.s1 * 5),
        color: ColorConstants.cScaffoldBackgroundColor,
      ),
      margin:
          EdgeInsets.fromLTRB(SizeConstants.s1 * 5, 0, SizeConstants.s1 * 5, 0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
              margin: EdgeInsets.all(SizeConstants.s1 * 10),
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                    width: 30,
                    child: FutureBuilder<String>(
                        future: mDashboardPreferenceModel
                            .getImage(sMyDashBoardListItem.icon!),
                        builder: (BuildContext context,
                            AsyncSnapshot<String> snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data != null && snapshot.data!.isNotEmpty) {
                              final UriData? data =
                                  Uri.parse(snapshot.data ?? "").data;
                              Uint8List myImage = data!.contentAsBytes();
                              if (snapshot.data!.contains("svg")) {
                                return SvgPicture.memory(myImage);
                              } else {
                                return Image.memory(myImage);
                              }
                            } else {
                              return Image.asset(
                                ImageAssets.heartDashboard,
                              );
                            }
                          }
                          return Image.asset(
                            ImageAssets.heartDashboard,
                          );
                        }),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    sMyDashBoardListItem.item!,
                    style: getTextRegular(
                      colors: ColorConstants.cBlack,
                      size: SizeConstants.s1 * 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              )),
          Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    mDashboardPreferenceModel.sMyDashBoardSelectedListItems.add(sMyDashBoardListItem);
                    mDashboardPreferenceModel.sMyDashBoardListItems.removeAt(index);
                  });
                },
                child: Icon(
                  Icons.add_circle_outline,
                  size: SizeConstants.s1 * 20,
                  color: ColorConstants.cLightDashboardGreenTextColor,
                ),
              ))
        ],
      ),
    );
  }

  _buildTeamPreferenceUI(String title) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(
              bottom: SizeConstants.s1 * 15,
              left: SizeConstants.s1 * 15,
              right: SizeConstants.s1 * 15),
          padding: EdgeInsets.all(SizeConstants.s1 * 15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(SizeConstants.s1 * 5),
              color: Colors.white),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///RegisteredDevices
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: getTextRegular(
                      colors: ColorConstants.cBlack,
                      size: SizeConstants.s1 * 17,
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          mDashboardPreferenceModel.isMyTeamPreferenceSave =
                              !mDashboardPreferenceModel.isMyTeamPreferenceSave;
                          if (mDashboardPreferenceModel
                              .isMyTeamPreferenceSave ==
                              false) {
                            mDashboardPreferenceModel.saveTeamPreference();
                          }
                        });
                      },
                      child: Text(
                        mDashboardPreferenceModel.isMyTeamPreferenceSave
                            ? AppConstants.mWordConstants.sSave
                            : AppConstants.mWordConstants.sEdit,
                        style: getTextRegular(
                          colors: ColorConstants.cSideMenuSelectText,
                          size: SizeConstants.s1 * 17,
                        ),
                      )),
                ],
              ),
              SizedBox(
                height: SizeConstants.s1 * 15,
              ),
              SizedBox(
                child:
                    mDashboardPreferenceModel.sMyTeamSelectedListItems.isEmpty
                        ? SizedBox(
                            height: SizeConstants.s1 * 30,
                          )
                        : getSelectedTeamPreference(),
              ),

              ///AllRegisteredDevices
              if (mDashboardPreferenceModel.isMyTeamPreferenceSave)
                SizedBox(
                  child:
                      mDashboardPreferenceModel.sMyTeamPreferenceItems.isEmpty
                          ? SizedBox(
                              height: SizeConstants.s1 * 30,
                            )
                          : getAllTeamPreference(),
                ),
            ],
          ),
        ),
      ],
    );
  }

  getSelectedTeamPreference() {
    return StaggeredGridView.countBuilder(
      staggeredTileBuilder: (int index) => const StaggeredTile.fit(1),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: mDashboardPreferenceModel.sMyTeamSelectedListItems.isNotEmpty ? mDashboardPreferenceModel.sMyTeamSelectedListItems.length : 0,
      crossAxisCount: 3,
      crossAxisSpacing: 3,
      mainAxisSpacing: 3,
      itemBuilder: (BuildContext context, int index) {
        return selectedTeamPreferencesRow(
            mDashboardPreferenceModel.sMyTeamSelectedListItems[index], index);
      },
    );
  }

  selectedTeamPreferencesRow(
      TeamPreference sMyTeamSelectedListItem, int index) {
    return Container(
        height: SizeConstants.s1 * 70,
        margin: EdgeInsets.all(SizeConstants.s1 * 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(SizeConstants.s1 * 5),
          color: ColorConstants.cScaffoldBackgroundColor,
          border: Border.all(
              color: ColorConstants.cLightDashboardGreenTextColor,
              width: SizeConstants.s_05),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
                margin: EdgeInsets.all(SizeConstants.s1 * 10),
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                      width: 30,
                      child: FutureBuilder<String>(
                          future: mDashboardPreferenceModel
                              .getImage(sMyTeamSelectedListItem.icon!),
                          builder: (BuildContext context,
                              AsyncSnapshot<String> snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data != null && snapshot.data!.isNotEmpty) {
                                final UriData? data =
                                    Uri.parse(snapshot.data ?? "").data;
                                Uint8List myImage = data!.contentAsBytes();
                                if (snapshot.data!.contains("svg")) {
                                  return SvgPicture.memory(myImage);
                                } else {
                                  return Image.memory(myImage);
                                }
                              } else {
                                return Image.asset(
                                  ImageAssets.heartDashboard,
                                );
                              }
                            }
                            return Image.asset(
                              ImageAssets.heartDashboard,
                            );
                          }),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      sMyTeamSelectedListItem.item!,
                      style: getTextRegular(
                        colors: ColorConstants.cBlack,
                        size: SizeConstants.s1 * 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                )),
            if (mDashboardPreferenceModel.isMyTeamPreferenceSave)
              Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        mDashboardPreferenceModel.sMyTeamPreferenceItems
                            .add(sMyTeamSelectedListItem);
                        mDashboardPreferenceModel.sMyTeamSelectedListItems
                            .removeAt(index);
                        mDashboardPreferenceModel.isMyTeamPreferenceSave;
                      });
                    },
                    child: Image.asset(
                      'assets/images/delete.png',
                      height: SizeConstants.s1 * 20,
                      width: SizeConstants.s1 * 20,
                    ),
                  ))
          ],
        ));
  }

  getAllTeamPreference() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        height: SizeConstants.s1 * 90,
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: mDashboardPreferenceModel.sMyTeamPreferenceItems.isNotEmpty ? mDashboardPreferenceModel.sMyTeamPreferenceItems.length : 0,
          itemBuilder: (context, index) {
            return allTeamPreferenceRow(
                mDashboardPreferenceModel.sMyTeamPreferenceItems[index], index);
          },
        ),
      ),
    );
  }

  allTeamPreferenceRow(TeamPreference sMyDashBoardListItem, int index) {
    return Container(
      width: SizeConstants.s1 * 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SizeConstants.s1 * 5),
        color: ColorConstants.cScaffoldBackgroundColor,
      ),
      margin:
          EdgeInsets.fromLTRB(SizeConstants.s1 * 5, 0, SizeConstants.s1 * 5, 0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
              margin: EdgeInsets.all(SizeConstants.s1 * 10),
              alignment: Alignment.center,
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                    width: 30,
                    child: FutureBuilder<String>(
                        future: mDashboardPreferenceModel
                            .getImage(sMyDashBoardListItem.icon!),
                        builder: (BuildContext context,
                            AsyncSnapshot<String> snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data != null && snapshot.data!.isNotEmpty) {
                              final UriData? data =
                                  Uri.parse(snapshot.data ?? "").data;
                              Uint8List myImage = data!.contentAsBytes();
                              if (snapshot.data!.contains("svg")) {
                                return SvgPicture.memory(myImage);
                              } else {
                                return Image.memory(myImage);
                              }
                            } else {
                              return Image.asset(
                                ImageAssets.heartDashboard,
                              );
                            }
                          }
                          return Image.asset(
                            ImageAssets.heartDashboard,
                          );
                        }),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    sMyDashBoardListItem.item!,
                    style: getTextRegular(
                      colors: ColorConstants.cBlack,
                      size: SizeConstants.s1 * 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              )),
          Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    mDashboardPreferenceModel.sMyTeamSelectedListItems
                        .add(sMyDashBoardListItem);
                    mDashboardPreferenceModel.sMyTeamPreferenceItems
                        .removeAt(index);
                  });
                },
                child: Icon(
                  Icons.add_circle_outline,
                  size: SizeConstants.s1 * 20,
                  color: ColorConstants.cLightDashboardGreenTextColor,
                ),
              ))
        ],
      ),
    );
  }

  blocTivraHealthDevicesListListener(
      BuildContext context, DevicesListState state) {
    switch (state.status) {
      case DevicesListStatus.loading:
        AppAlert.showProgressDialog(context);
        break;
      case DevicesListStatus.failed:
        AppAlert.closeDialog(context);
        AppAlert.showSnackBar(
            context, state.webResponseFailed?.statusMessage ?? "");
        break;
      case DevicesListStatus.success:
        AppAlert.closeDialog(context);
        mDashboardPreferenceModel.getActiveDevices();
        setState(() {
          mDashboardPreferenceModel.sDevicesItems;
        });
        break;
    }
  }

  blocMyDashboardPreferenceListener(
      BuildContext context, MyDashboardPreferenceState state) {
    switch (state.status) {
      case MyDashboardPreferenceStatus.loading:
        AppAlert.showProgressDialog(context);
        break;
      case MyDashboardPreferenceStatus.failed:
        AppAlert.closeDialog(context);
        AppAlert.showSnackBar(
            context, state.webResponseFailed?.statusMessage ?? "");
        break;
      case MyDashboardPreferenceStatus.success:
        AppAlert.closeDialog(context);
        mDashboardPreferenceModel.getDashboardPreferenceList();
        setState(() {
          mDashboardPreferenceModel.sMyDashBoardListItems;
          mDashboardPreferenceModel.sMyDashBoardSelectedListItems;
        });
        break;
    }
  }

  blocMyTeamPreferenceListener(
      BuildContext context, MyTeamPreferenceState state) {
    switch (state.status) {
      case MyTeamPreferenceStatus.loading:
        AppAlert.showProgressDialog(context);
        break;
      case MyTeamPreferenceStatus.failed:
        AppAlert.closeDialog(context);
        AppAlert.showSnackBar(
            context, state.webResponseFailed?.statusMessage ?? "");
        break;
      case MyTeamPreferenceStatus.success:
        AppAlert.closeDialog(context);
        mDashboardPreferenceModel.getTeamPreferenceList();
        setState(() {
          mDashboardPreferenceModel.sMyTeamPreferenceItems;
          mDashboardPreferenceModel.sMyTeamSelectedListItems;
        });
        break;
    }
  }

  blocRegisteredDevicesListener(
      BuildContext context, RegisteredDevicesState state) {
    switch (state.status) {
      case RegisteredDevicesStatus.loading:
        AppAlert.showProgressDialog(context);
        break;
      case RegisteredDevicesStatus.failed:
        AppAlert.closeDialog(context);
        AppAlert.showSnackBar(
            context, state.webResponseFailed?.statusMessage ?? "");
        break;
      case RegisteredDevicesStatus.success:
        AppAlert.closeDialog(context);
        mDashboardPreferenceModel.getSavedRegisteredDevices();
        setState(() {
          mDashboardPreferenceModel.sRegisteredDevices;
        });
        break;
    }
  }

  blocgetDashboardConfigListener(
      BuildContext context, GetDashboardConfigState state) {
    switch (state.status) {
      case GetDashboardConfigStatus.loading:
        AppAlert.showProgressDialog(context);
        break;
      case GetDashboardConfigStatus.failed:
        AppAlert.closeDialog(context);
        AppAlert.showSnackBar(
            context, state.webResponseFailed?.statusMessage ?? "");
        break;
      case GetDashboardConfigStatus.success:
        AppAlert.closeDialog(context);
        getDashboardConfigValues();
        break;
    }
  }

  getDashboardConfigValues() async {
    await mDashboardPreferenceModel.getDashboardConfigValues();
    setState(() {
      mDashboardPreferenceModel.finalFitnessValues;
      mDashboardPreferenceModel.finalHealthValues;
      mDashboardPreferenceModel.finalNutritionValues;
    });
  }

  blocSaveDashboardPreferenceListener(
      BuildContext context, SaveDashboardPreferenceState state) {
    switch (state.status) {
      case SaveDashboardPreferenceStatus.loading:
        AppAlert.showProgressDialog(context);
        break;
      case SaveDashboardPreferenceStatus.failed:
        AppAlert.closeDialog(context);
        AppAlert.showSnackBar(
            context, state.webResponseFailed?.statusMessage ?? "");
        break;
      case SaveDashboardPreferenceStatus.success:
        AppAlert.closeDialog(context);
        break;
    }
  }

  blocSaveTeamPreferenceListener(
      BuildContext context, SaveTeamPreferenceState state) {
    switch (state.status) {
      case SaveTeamPreferenceStatus.loading:
        AppAlert.showProgressDialog(context);
        break;
      case SaveTeamPreferenceStatus.failed:
        AppAlert.closeDialog(context);
        AppAlert.showSnackBar(
            context, state.webResponseFailed?.statusMessage ?? "");
        break;
      case SaveTeamPreferenceStatus.success:
        AppAlert.closeDialog(context);
        break;
    }
  }

  blocSaveDashboardConfigListener(
      BuildContext context, SaveDashboardConfigState state) {
    switch (state.status) {
      case SaveDashboardConfigStatus.loading:
        AppAlert.showProgressDialog(context);
        break;
      case SaveDashboardConfigStatus.failed:
        AppAlert.closeDialog(context);
        AppAlert.showSnackBar(
            context, state.webResponseFailed?.statusMessage ?? "");
        break;
      case SaveDashboardConfigStatus.success:
        AppAlert.closeDialog(context);
        break;
    }
  }
}
