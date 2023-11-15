import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tivra_health/common/alert/app_alert.dart';
import 'package:tivra_health/common/app_constants.dart';
import 'package:tivra_health/common/image_assets.dart';
import 'package:tivra_health/common/message_constants.dart';
import 'package:tivra_health/common/utils/network_utils.dart';
import 'package:tivra_health/data/all_bloc/all_image/repo/all_image_data_response.dart';
import 'package:tivra_health/data/all_bloc/devices_list/bloc/devices_list_bloc.dart';
import 'package:tivra_health/data/all_bloc/devices_list/bloc/devices_list_event.dart';
import 'package:tivra_health/data/all_bloc/devices_list/bloc/devices_list_state.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tivra_health/data/all_bloc/devices_list/repo/devices_list_response.dart';
import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';

class DevicesListModel {

  final BuildContext mBuildContext;
  DevicesListModel(this.mBuildContext);

  List<String> sDevicesListItems = [
    ImageAssets.device1,
    ImageAssets.device2,
    ImageAssets.device3,
    ImageAssets.device4,
    ImageAssets.device5,
    ImageAssets.device6,
    ImageAssets.device7,
    ImageAssets.device8,
  ];


  /// DevicesList Api
  late DevicesListBloc _mDevicesListBloc;

  setDevicesListBloc() {
    _mDevicesListBloc = DevicesListBloc();
  }

  getDevicesListBloc() {
    return _mDevicesListBloc;
  }

  onRefresh() async {
    initDevicesList();
  }

  Future<void> initDevicesList() async {
    await NetworkUtils().checkInternetConnection().then((isInternetAvailable) {
      if (isInternetAvailable) {
        _mDevicesListBloc
            .add(const DevicesListClickEvent(mStringRequest: ""));
      } else {
        AppAlert.showSnackBar(
            mBuildContext, MessageConstants.noInternetConnection);
      }
    });
  }

  blocDevicesListListener(
      BuildContext context, DevicesListState state) {
    switch (state.status) {
      case DevicesListStatus.loading:
        AppAlert.showProgressDialog(context);
        break;
      case DevicesListStatus.failed:
        loadEnd();
        if (state.webResponseFailed != null) {
          AppAlert.showSnackBar(
              context, state.webResponseFailed!.statusMessage ?? "");
        } else {
          AppAlert.showSnackBar(
              mBuildContext, AppConstants.mWordConstants.wSomethingWentWrong);
        }
        break;
      case DevicesListStatus.success:
        print("##payment##${jsonEncode(state.mDevicesListResponse!)}");
        setList(state.mDevicesListResponse!);
        loadEnd();
        break;
    }
  }

  void loadEnd() {
    AppAlert.closeDialog(mBuildContext);
  }

  /// DevicesListState

  var responseSubject = PublishSubject<DevicesListResponse?>();

  Stream<DevicesListResponse?> get responseStream =>
      responseSubject.stream;

  void closeObservable() {
    responseSubject.close();
  }

  void setList(DevicesListResponse state) async {
    try {
      responseSubject.sink.add(state);
    } catch (e) {
      responseSubject.sink.addError(e);
    }
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
