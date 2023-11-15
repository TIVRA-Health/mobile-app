import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tivra_health/common/alert/app_alert.dart';
import 'package:tivra_health/common/app_constants.dart';
import 'package:tivra_health/common/image_assets.dart';
import 'package:tivra_health/common/message_constants.dart';
import 'package:tivra_health/common/utils/network_utils.dart';
import 'package:tivra_health/data/all_bloc/all_image/repo/all_image_data_response.dart';
import 'package:tivra_health/data/all_bloc/device_registration/bloc/device_registration_bloc.dart';
import 'package:tivra_health/data/all_bloc/device_registration/bloc/device_registration_bloc.dart';
import 'package:tivra_health/data/all_bloc/device_registration/bloc/device_registration_event.dart';
import 'package:tivra_health/data/all_bloc/device_registration/bloc/device_registration_state.dart';
import 'package:tivra_health/data/all_bloc/device_registration/repo/device_registration_request.dart';
import 'package:tivra_health/data/all_bloc/registered_device_list/bloc/registered_devices_bloc.dart';
import 'package:tivra_health/data/all_bloc/registered_device_list/bloc/registered_devices_event.dart';
import 'package:tivra_health/data/all_bloc/registered_device_list/repo/registered_devices_response.dart';
import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';
import 'package:url_launcher/url_launcher.dart';

class DevicesScreenModel {
  final BuildContext mContext;

  DevicesScreenModel(this.mContext);

  bool isSave = false;

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

  List<String> sSelectDevicesListItems = [];
  List<String> sRegisteredDevices = [];

  /// DeviceRegistration Api
  late DeviceRegistrationBloc _mDeviceRegistrationBloc;
  late RegisteredDevicesBloc _mRegisteredDevicesBloc;

  setDashboardDetailsBloc() {
    _mDeviceRegistrationBloc = DeviceRegistrationBloc();
    _mRegisteredDevicesBloc = RegisteredDevicesBloc();
  }

  getDeviceRegistrationBloc() {
    return _mDeviceRegistrationBloc;
  }

  getRegisteredDevicesBloc() {
    return _mRegisteredDevicesBloc;
  }

  apiCallById(String sSelectItem) async {
    initDeviceRegistration(sSelectItem);
  }

  Future<void> initDeviceRegistration(String sUserId) async {
    await NetworkUtils().checkInternetConnection().then((isInternetAvailable) {
      if (isInternetAvailable) {
        _mDeviceRegistrationBloc.add(DeviceRegistrationClickEvent(
            mDeviceRegistrationListRequest:
                DeviceRegistrationRequest(deviceBrand: sUserId)));
      } else {
        AppAlert.showSnackBar(mContext, MessageConstants.noInternetConnection);
      }
    });
  }

  blocDeviceRegistrationListener(
      BuildContext context, DeviceRegistrationState state) {
    switch (state.status) {
      case DeviceRegistrationStatus.loading:
        AppAlert.showProgressDialog(context);
        break;
      case DeviceRegistrationStatus.failed:
        loadEnd();
        if (state.webResponseFailed != null) {
          AppAlert.showSnackBar(
              context, state.webResponseFailed!.statusMessage ?? "");
        } else {
          AppAlert.showSnackBar(
              context, AppConstants.mWordConstants.wSomethingWentWrong);
        }
        break;
      case DeviceRegistrationStatus.success:
        navigateToPaymentLink(
            state.mTivraHealthRegisterScreenResponse?.authUrl ?? "");
        loadEnd();

        break;
    }
  }

  void loadEnd() {
    AppAlert.closeDialog(mContext);
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

  late AllImageResponse mAllImageResponse;

  getAllImage() async {
    String sAllImage = await SharedPrefs().getAllImage();
    print("###sAllImage### ${sAllImage}");
    if (sAllImage.isNotEmpty) {
      mAllImageResponse = AllImageResponse.fromJson(jsonDecode(sAllImage));
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


  ///
  navigateToPaymentLink(String url) async {
    if (url.isNotEmpty) {
      final Uri urlLaunch = Uri.parse(url);
      if (!await launchUrl(urlLaunch)) {
        throw Exception('Could not launch $url');
      }
    }
  }

  Future<void> getRegisteredDevices() async {
    String userId = await SharedPrefs().getUserId();
    await NetworkUtils().checkInternetConnection().then((isInternetAvailable) {
      if (isInternetAvailable) {
        _mRegisteredDevicesBloc
            .add(RegisteredDevicesClickEvent(mStringRequest: userId));
      } else {
        AppAlert.showSnackBar(
            mContext, MessageConstants.noInternetConnection);
      }
    });
  }
}
