import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tivra_health/common/alert/app_alert.dart';
import 'package:tivra_health/common/message_constants.dart';
import 'package:tivra_health/common/utils/network_utils.dart';
import 'package:tivra_health/data/all_bloc/all_image/repo/all_image_data_response.dart';
import 'package:tivra_health/data/all_bloc/dashboard_config/bloc/get_dashboard_config_bloc.dart';
import 'package:tivra_health/data/all_bloc/dashboard_config/bloc/get_dashboard_config_event.dart';
import 'package:tivra_health/data/all_bloc/dashboard_config/repo/get_dashboard_config_response_new.dart' as config_dashboard;
import 'package:tivra_health/data/all_bloc/devices_list/bloc/devices_list_bloc.dart';
import 'package:tivra_health/data/all_bloc/devices_list/bloc/devices_list_event.dart';
import 'package:tivra_health/data/all_bloc/devices_list/repo/devices_list_response.dart';
import 'package:tivra_health/data/all_bloc/my_dashboard_preference/bloc/my_dashboard_preference_bloc.dart';
import 'package:tivra_health/data/all_bloc/my_dashboard_preference/bloc/my_dashboard_preference_event.dart';
import 'package:tivra_health/data/all_bloc/my_dashboard_preference/repo/my_dashboard_preference_response.dart';
import 'package:tivra_health/data/all_bloc/my_team_preference/bloc/my_team_preference_bloc.dart';
import 'package:tivra_health/data/all_bloc/my_team_preference/bloc/my_team_preference_event.dart';
import 'package:tivra_health/data/all_bloc/my_team_preference/repo/my_team_preference_response.dart';
import 'package:tivra_health/data/all_bloc/registered_device_list/bloc/registered_devices_bloc.dart';
import 'package:tivra_health/data/all_bloc/registered_device_list/bloc/registered_devices_event.dart';
import 'package:tivra_health/data/all_bloc/registered_device_list/repo/registered_devices_response.dart';
import 'package:tivra_health/data/all_bloc/save_dashboard_config/bloc/save_dashboard_config_bloc.dart';
import 'package:tivra_health/data/all_bloc/save_dashboard_config/bloc/save_dashboard_config_event.dart';
import 'package:tivra_health/data/all_bloc/save_dashboard_config/repo/save_dashboard_config_request.dart';
import 'package:tivra_health/data/all_bloc/save_dashboard_preference/bloc/save_dashboard_bloc.dart';
import 'package:tivra_health/data/all_bloc/save_dashboard_preference/bloc/save_dashboard_event.dart';
import 'package:tivra_health/data/all_bloc/save_dashboard_preference/repo/save_dashboard_request.dart' as save_dashboard;
import 'package:tivra_health/data/all_bloc/save_team_preference/bloc/save_team_bloc.dart';
import 'package:tivra_health/data/all_bloc/save_team_preference/bloc/save_team_event.dart';
import 'package:tivra_health/data/all_bloc/save_team_preference/repo/save_team_request.dart' as save_team;
import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';

class DashboardPreferenceModel {
  final BuildContext cBuildContext;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  DashboardPreferenceModel(this.cBuildContext);

  bool isActiveDeviceSave = false;
  bool isConfigSave = false;
  bool isMyDashboardPreferenceSave = false;
  bool isMyTeamPreferenceSave = false;
  bool isSave = false;

  List<String> sDevicesItems = [];
  List<config_dashboard.Data> finalHealthValues = [];
  List<config_dashboard.Data> finalFitnessValues = [];
  List<config_dashboard.Data> finalNutritionValues = [];

  List<DashboardPreference> sMyDashBoardListItems = [];
  List<DashboardPreference> sMyDashBoardSelectedListItems = [];

  List<TeamPreference> sMyTeamPreferenceItems = [];
  List<TeamPreference> sMyTeamSelectedListItems = [];

  List<String> sSelectDevicesItems = [];
  List<String> sRegisteredDevices = [];

  /// device list bloc
  late DevicesListBloc _mDevicesListBloc;
  late MyDashboardPreferenceBloc _mMyDashboardPreferenceBloc;
  late MyTeamPreferenceBloc _mMyTeamPreferenceBloc;
  late GetDashboardConfigBloc _mGetDashboardConfigBloc;
  late RegisteredDevicesBloc _mRegisteredDevicesBloc;
  late SaveDashboardPreferenceBloc _mSaveDashboardPreferenceBloc;
  late SaveTeamPreferenceBloc _mSaveTeamPreferenceBloc;
  late SaveDashboardConfigBloc _mSaveDashboardConfigBloc;

  setTivraHealthDeviceListBloc() {
    _mDevicesListBloc = DevicesListBloc();
    _mMyDashboardPreferenceBloc = MyDashboardPreferenceBloc();
    _mMyTeamPreferenceBloc = MyTeamPreferenceBloc();
    _mGetDashboardConfigBloc = GetDashboardConfigBloc();
    _mRegisteredDevicesBloc = RegisteredDevicesBloc();
    _mSaveDashboardPreferenceBloc = SaveDashboardPreferenceBloc();
    _mSaveTeamPreferenceBloc = SaveTeamPreferenceBloc();
    _mSaveDashboardConfigBloc = SaveDashboardConfigBloc();
  }

  getTivraHealthDeviceListBloc() {
    return _mDevicesListBloc;
  }

  getMyDashboardPreferenceBloc() {
    return _mMyDashboardPreferenceBloc;
  }

  getMyTeamPreferenceBloc() {
    return _mMyTeamPreferenceBloc;
  }

  getDashboardConfigBoc() {
    return _mGetDashboardConfigBloc;
  }

  getRegisteredDevicesBloc() {
    return _mRegisteredDevicesBloc;
  }

  getSaveDashboardPreferenceBloc() {
    return _mSaveDashboardPreferenceBloc;
  }

  getSaveTeamPreferenceBloc() {
    return _mSaveTeamPreferenceBloc;
  }

  getSaveDashboardConfigBloc() {
    return _mSaveDashboardConfigBloc;
  }

  apiCall() async {
    await getDeviceList();
    await getDashboardConfig();
    await getMyDashboardPreference();
    await getMyTeamPreference();
    await getRegisteredDevices();
    await getAllImage();
  }

  Future<void> getActiveDevices() async {
    DevicesListResponse devicesListResponse;
    sDevicesItems.clear();
    await SharedPrefs().getDeviceList().then((value) => {
          devicesListResponse =
              DevicesListResponse.fromJson(json.decode(value)),
          if (devicesListResponse.data != null)
            {
              devicesListResponse.data?.forEach((element) {
                if (element.active!) {
                  sDevicesItems.add(element.name!);
                }
              })
            }
        });
  }

  Future<void> getDashboardPreferenceList() async {
    MyDashboardPreferenceResponse dashboardPreferenceResponse;
    sMyDashBoardSelectedListItems.clear();
    sMyDashBoardListItems.clear();
    await SharedPrefs().getMyDashboardPreference().then((value) => {
          dashboardPreferenceResponse =
              MyDashboardPreferenceResponse.fromJson(json.decode(value)),
          dashboardPreferenceResponse.preference?.forEach((element) {
            if (element.isPreferred!) {
              sMyDashBoardSelectedListItems.add(element);
            } else {
              sMyDashBoardListItems.add(element);
            }
          })
        });
  }

  Future<void> getTeamPreferenceList() async {
    MyTeamPreferenceResponse teamPreferenceResponse;
    sMyTeamSelectedListItems.clear();
    sMyTeamPreferenceItems.clear();
    await SharedPrefs().getMyTeamPreference().then((value) => {
          teamPreferenceResponse =
              MyTeamPreferenceResponse.fromJson(json.decode(value)),
          teamPreferenceResponse.preference?.forEach((element) {
            if (element.isPreferred!) {
              sMyTeamSelectedListItems.add(element);
            } else {
              sMyTeamPreferenceItems.add(element);
            }
          })
        });
  }

  Future<void> getMyDashboardPreference() async {
    String userId = await SharedPrefs().getUserId();
    await NetworkUtils().checkInternetConnection().then((isInternetAvailable) {
      if (isInternetAvailable) {
        _mMyDashboardPreferenceBloc
            .add(MyDashboardPreferenceClickEvent(mStringRequest: userId));
      } else {
        AppAlert.showSnackBar(
            cBuildContext, MessageConstants.noInternetConnection);
      }
    });
  }

  Future<void> saveDashboardPreference() async {
    String userId = await SharedPrefs().getUserId();
    List<save_dashboard.DashboardPreference> finalList = [];
    MyDashboardPreferenceResponse dashboardPreferenceResponse;
    await SharedPrefs().getMyDashboardPreference().then((value) async => {
          dashboardPreferenceResponse =
              MyDashboardPreferenceResponse.fromJson(json.decode(value)),
          dashboardPreferenceResponse.preference?.forEach((apiElement) {
            for (var element in sMyDashBoardSelectedListItems) {
              if (apiElement.item == element.item) {
                apiElement.isPreferred = true;
              }
            }
            for (var element in sMyDashBoardListItems) {
              if (apiElement.item == element.item) {
                apiElement.isPreferred = false;
              }
            }
            save_dashboard.DashboardPreference preference =
                save_dashboard.DashboardPreference(
                    item: apiElement.item,
                    active: apiElement.active,
                    icon: apiElement.icon,
                    isPreferred: apiElement.isPreferred,
                    label: apiElement.label);
            finalList.add(preference);
          }),
          await NetworkUtils()
              .checkInternetConnection()
              .then((isInternetAvailable) {
            if (isInternetAvailable) {
              _mSaveDashboardPreferenceBloc.add(
                  SaveDashboardPreferenceClickEvent(
                      mSaveDashboardPreferenceRequest:
                          save_dashboard.SaveDashboardPreferenceRequest(
                              userId: userId, preference: finalList)));
            } else {
              AppAlert.showSnackBar(
                  cBuildContext, MessageConstants.noInternetConnection);
            }
          }),
        });
  }

  Future<void> saveTeamPreference() async {
    String userId = await SharedPrefs().getUserId();
    List<save_team.Preference> finalList = [];
    MyTeamPreferenceResponse teamPreferenceResponse;
    await SharedPrefs().getMyDashboardPreference().then((value) async => {
          teamPreferenceResponse =
              MyTeamPreferenceResponse.fromJson(json.decode(value)),
          teamPreferenceResponse.preference?.forEach((apiElement) {
            for (var element in sMyTeamSelectedListItems) {
              if (apiElement.item == element.item) {
                apiElement.isPreferred = true;
              }
            }
            for (var element in sMyTeamPreferenceItems) {
              if (apiElement.item == element.item) {
                apiElement.isPreferred = false;
              }
            }
            save_team.Preference preference = save_team.Preference(
                item: apiElement.item,
                active: apiElement.active,
                icon: apiElement.icon,
                isPreferred: apiElement.isPreferred,
                label: apiElement.label);
            finalList.add(preference);
          }),
          await NetworkUtils()
              .checkInternetConnection()
              .then((isInternetAvailable) {
            if (isInternetAvailable) {
              _mSaveTeamPreferenceBloc.add(SaveTeamPreferenceClickEvent(
                  mSaveTeamPreferenceRequest:
                      save_team.SaveTeamPreferenceRequest(
                          userId: userId, preference: finalList)));
            } else {
              AppAlert.showSnackBar(
                  cBuildContext, MessageConstants.noInternetConnection);
            }
          }),
        });
  }

  Future<void> getMyTeamPreference() async {
    String userId = await SharedPrefs().getUserId();
    await NetworkUtils().checkInternetConnection().then((isInternetAvailable) {
      if (isInternetAvailable) {
        _mMyTeamPreferenceBloc
            .add(MyTeamPreferenceClickEvent(mStringRequest: userId));
      } else {
        AppAlert.showSnackBar(
            cBuildContext, MessageConstants.noInternetConnection);
      }
    });
  }

  Future<void> getDeviceList() async {
    await NetworkUtils().checkInternetConnection().then((isInternetAvailable) {
      if (isInternetAvailable) {
        _mDevicesListBloc.add(const DevicesListClickEvent(mStringRequest: ""));
      } else {
        AppAlert.showSnackBar(
            cBuildContext, MessageConstants.noInternetConnection);
      }
    });
  }

  Future<void> getDashboardConfig() async {
    String userId = await SharedPrefs().getUserId();
    await NetworkUtils().checkInternetConnection().then((isInternetAvailable) {
      if (isInternetAvailable) {
        _mGetDashboardConfigBloc
            .add(GetDashboardConfigClickEvent(mStringRequest: userId));
      } else {
        AppAlert.showSnackBar(
            cBuildContext, MessageConstants.noInternetConnection);
      }
    });
  }

  Future<void> getDashboardConfigValues() async {
    config_dashboard.GetDashboardConfigResponseNew dashboardConfigResponse;
    await SharedPrefs().getDashboardConfig().then((value) => {
          dashboardConfigResponse =
              config_dashboard.GetDashboardConfigResponseNew.fromJson(
                  json.decode(value)),
          dashboardConfigResponse.data?.forEach((element) {
            if (element.category == "health") {
              finalHealthValues.add(element);
            }
            if (element.category == "fitness") {
              finalFitnessValues.add(element);
            }
            if (element.category == "nutrition") {
              finalNutritionValues.add(element);
            }
          })
        });
  }

  Future<void> getRegisteredDevices() async {
    String userId = await SharedPrefs().getUserId();
    await NetworkUtils().checkInternetConnection().then((isInternetAvailable) {
      if (isInternetAvailable) {
        _mRegisteredDevicesBloc
            .add(RegisteredDevicesClickEvent(mStringRequest: userId));
      } else {
        AppAlert.showSnackBar(
            cBuildContext, MessageConstants.noInternetConnection);
      }
    });
  }

  Future<void> saveDashboardConfig(config_dashboard.Data data) async {
    String userId = await SharedPrefs().getUserId();
    List<ConfigData> configData = [];
    configData.add(ConfigData(userDeviceId: data.userDeviceId,category: data.category,item: data.item,icon: data.icon,label: data.label));
    await NetworkUtils().checkInternetConnection().then((isInternetAvailable) {
      if (isInternetAvailable) {
        _mSaveDashboardConfigBloc.add(SaveDashboardConfigClickEvent(
            mSaveDashboardConfigRequest: SaveDashboardConfigRequest(
                userId: userId, configData: configData)));
      } else {
        AppAlert.showSnackBar(
            cBuildContext, MessageConstants.noInternetConnection);
      }
    });
  }

  Future<void> getSavedRegisteredDevices() async {
    RegisteredDevicesResponse registeredDevicesResponse;
    await SharedPrefs().getRegisteredDevices().then((value) => {
          registeredDevicesResponse =
              RegisteredDevicesResponse.fromJson(json.decode(value)),
          registeredDevicesResponse.data?.forEach((element) {
            if (element.active ?? false) {
              sRegisteredDevices.add(element.name.toString());
            }
          })
        });
  }

  Future<String>? getImage(String name) async {
    if (mAllImageResponse != null) {
      for (AllImageData mAllImageData in mAllImageResponse.data ?? []) {
        if (mAllImageData.imageName!.toLowerCase() == name.toLowerCase()) {
          return mAllImageData.imageData ?? "";
        }
      }
      return "";
    } else {
      return "";
    }
  }

  late AllImageResponse mAllImageResponse;

  getAllImage() async {
    String sAllImage = await SharedPrefs().getAllImage();
    print("###sAllImage### ${sAllImage}");
    if (sAllImage.isNotEmpty) {
      mAllImageResponse = AllImageResponse.fromJson(jsonDecode(sAllImage));
    }
  }
}
