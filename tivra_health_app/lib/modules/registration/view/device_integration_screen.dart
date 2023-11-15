import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:terra_flutter_bridge/terra_flutter_bridge.dart';
import 'package:tivra_health/common/alert/app_alert.dart';
import 'package:tivra_health/common/app_constants.dart';
import 'package:tivra_health/common/button_constants.dart';
import 'package:tivra_health/common/color_constants.dart';
import 'package:tivra_health/common/image_assets.dart';
import 'package:tivra_health/common/message_constants.dart';
import 'package:tivra_health/common/size_constants.dart';
import 'package:tivra_health/common/text_styles_constants.dart';
import 'package:tivra_health/common/widget/custom_image.dart';
import 'package:tivra_health/data/all_bloc/device_registration/bloc/device_registration_bloc.dart';
import 'package:tivra_health/data/all_bloc/device_registration/bloc/device_registration_state.dart';
import 'package:tivra_health/data/all_bloc/devices_list/repo/devices_list_response.dart';
import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';
import 'package:tivra_health/modules/devices/model/devices_screen_model.dart';
import 'package:tivra_health/routes/route_constants.dart';
import 'package:http/http.dart' as http;

class DeviceIntegrationScreen extends StatefulWidget {
  final Function(bool, int) refreshPage;
  const DeviceIntegrationScreen(this.refreshPage, {Key? key}) : super(key: key);

  @override
  State<DeviceIntegrationScreen> createState() => _DeviceIntegrationScreen();

}

class _DeviceIntegrationScreen extends State<DeviceIntegrationScreen>  {
  String sSelectItem = "";
  late DevicesListData mSelectDevicesListData;
  late DevicesScreenModel mDevicesScreenModel;
  var sdkToken = '';

  @override
  void initState() {
    mDevicesScreenModel = DevicesScreenModel(context);
    mDevicesScreenModel.setDashboardDetailsBloc();
    initTerra();
    mDevicesScreenModel.getRegisteredDevices();
    mDevicesScreenModel.getAllImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: MultiBlocListener(listeners: [
          BlocListener<DeviceRegistrationBloc, DeviceRegistrationState>(
            bloc: mDevicesScreenModel.getDeviceRegistrationBloc(),
            listener: (context, state) {
              mDevicesScreenModel.blocDeviceRegistrationListener(context, state);
            },
          ),
          // BlocListener<PaymentMethodsBloc, PaymentMethodsState>(
          //   bloc: mPaymentMethodsModel.getPaymentMethodsBloc(),
          //   listener: (context, state) {
          //     mPaymentMethodsModel.blocPaymentMethodsListener(context, state);
          //   },
          // ),
        ], child: buildView()));
  }

  Widget buildView() {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              AppConstants.mWordConstants.sDeviceRegistration,
              style: getTextMedium(
                  colors: ColorConstants.cBlack, size: SizeConstants.s1 * 20),
            ),
            SizedBox(
              height: SizeConstants.s_20,
            ),
            ///add device
            addDevice(),
            SizedBox(
              height: SizeConstants.s_20,
            ),
            /// registered devices
            registeredDevices(),
            SizedBox(
              height: SizeConstants.s_20,
            ),
            Container(
                height: SizeConstants.s1 * 43,
                alignment: Alignment.center,
                margin: EdgeInsets.only(
                  left: SizeConstants.s1 * 5,
                  right: SizeConstants.s1 * 5,
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(SizeConstants.s1 * 5),
                    color: ColorConstants.cSideMenuSelectText),
                child: rectangleRoundedCornerButton(
                    AppConstants.mWordConstants.sContinue, () {
                      clearSharedPrefs();
                })),
          ],
        )
      )
    );
  }

  clearSharedPrefs() async {
    await SharedPrefs().clearSharedPreferences();
    await SharedPrefs().setUserId("");
    await imageCacheClear();
    Navigator.pushNamedAndRemoveUntil(
        context, RouteConstants.rSplashScreenWidget, (route) => false);
  }

  addDevice() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: EdgeInsets.all(SizeConstants.s1 * 15),
              child: Text(
                AppConstants.mWordConstants.sAddDevices,
                style: getTextMedium(
                  colors: ColorConstants.cBlack,
                  size: SizeConstants.s1 * 20,
                ),
              )),
          Container(
            margin: EdgeInsets.only(
                bottom: SizeConstants.s1 * 5,
                left: SizeConstants.s1 * 15,
                right: SizeConstants.s1 * 15),
            padding: EdgeInsets.all(SizeConstants.s1 * 6),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(SizeConstants.s1 * 5),
                color: Colors.white),
            child: Row(
              children: [
                Expanded(
                  flex: 9,
                  child: GestureDetector(
                      onTap: () async {
                        var result = await Navigator.pushNamed(context,
                            RouteConstants.rMasterDevicesListScreenWidget, arguments: mDevicesScreenModel.sRegisteredDevices);
                        if (result != null) {
                          setState(() {
                            mSelectDevicesListData =
                            (result as DevicesListData);
                            sSelectItem = mSelectDevicesListData.name ?? "";
                          });
                        }
                      },
                      child: Container(
                        height: SizeConstants.s1 * 55,
                        decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.circular(SizeConstants.s1 * 5),
                            color: ColorConstants.cScaffoldBackgroundColor,
                            border: Border.all(
                                color: ColorConstants.cBorderColor,
                                width: SizeConstants.s1)),
                        child: Row(
                          children: [
                            Expanded(
                                child: Container(
                                  color: Colors.transparent,
                                  child: sSelectItem.isEmpty
                                      ? Container(
                                    margin: EdgeInsets.only(
                                        left: SizeConstants.s1 * 10),
                                    child: Text(
                                      AppConstants
                                          .mWordConstants.sSelectADevice,
                                      style: getTextRegular(
                                        colors: Colors.grey.shade700,
                                        size: SizeConstants.s1 * 15,
                                      ),
                                    ),
                                  )
                                      : Container(
                                    margin: EdgeInsets.only(
                                        left: SizeConstants.s1 * 10,
                                        right: SizeConstants.s1 * 15,
                                        top: SizeConstants.s1 * 3,
                                        bottom: SizeConstants.s1 * 3),
                                    child: Image.asset(
                                      sSelectItem,
                                    ),
                                  ),
                                )),
                            Container(
                              margin: EdgeInsets.only(
                                  left: SizeConstants.s1 * 5,
                                  right: SizeConstants.s1 * 5),
                              child: Icon(
                                Icons.arrow_drop_down,
                                size: SizeConstants.s1 * 30,
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                      )),
                ),
                SizedBox(
                  width: SizeConstants.s1 * 10,
                ),
                Expanded(
                    flex: 5,
                    child: GestureDetector(
                      onTap: () {
                        if (sSelectItem.isNotEmpty) {
                          if (sSelectItem == "Google Fit") {
                            connectGoogleFit();
                          } else if (sSelectItem == "Samsung Health") {
                            connectSamsungHealth();
                          } else {
                            mDevicesScreenModel.apiCallById(sSelectItem);
                          }

                          // AppAlert.showDialogDeviceSuccessfully(
                          //     context,
                          //     sSelectItem,
                          //     ImageAssets.successIcon,
                          //     MessageConstants
                          //         .sTheDeviceIsRegisteredSuccessfully);
                          //
                          // AppAlert.showDialogDeviceSuccessfully(
                          //     context,
                          //     sSelectItem,
                          //     ImageAssets.unsuccessIcon,
                          //     MessageConstants
                          //         .sDeviceRegistrationFailed);
                        } else {
                          AppAlert.showSnackBar(
                              context, MessageConstants.sPleaseSelectTheDevice);
                        }
                      },
                      child: Container(
                        height: SizeConstants.s1 * 55,
                        decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.circular(SizeConstants.s1 * 5),
                            color: ColorConstants.cScaffoldBackgroundColor,
                            border: Border.all(
                                color: ColorConstants.cBorderColor,
                                width: SizeConstants.s_05)),
                        alignment: Alignment.center,
                        child: Text(
                          AppConstants.mWordConstants.sRegister,
                          style: getTextMedium(
                            colors: ColorConstants.cSideMenuSelectText,
                            size: SizeConstants.s1 * 18,
                          ),
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ]);
  }

  registeredDevices() {
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
            AppConstants.mWordConstants.sRegisteredDevices,
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
      itemCount: mDevicesScreenModel.sRegisteredDevices.length,
      crossAxisCount: 3,
      crossAxisSpacing: 3,
      mainAxisSpacing: 3,
      itemBuilder: (BuildContext context, int index) {
        return registeredDevicesRow(
            mDevicesScreenModel.sRegisteredDevices[index].toLowerCase());
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
            future: mDevicesScreenModel.getImage(device),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data != null && snapshot.data!.isNotEmpty) {
                  final UriData? data = Uri.parse(snapshot.data ?? "").data;
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
    );
  }

  initTerra() async {
    await TerraFlutter.initTerra("tivra-health-dev-NFTedoL0hI",
        "a3cfd7883e8e5f6c3991e5515ad27bcd96c9b24b71b6559b3edd15f2bd951d91")
        .then((value) => {initSDKToken()});
  }

  initSDKToken() async {
    var sdkRequest = http.Request(
        'POST', Uri.parse('https://api.tryterra.co/v2/auth/generateAuthToken'));
    var headers = {
      'x-api-key':
      "a3cfd7883e8e5f6c3991e5515ad27bcd96c9b24b71b6559b3edd15f2bd951d91",
      'dev-id': "tivra-health-dev-NFTedoL0hI"
    };
    sdkRequest.headers.addAll(headers);
    http.StreamedResponse sdkResponse = await sdkRequest.send();
    if (sdkResponse.statusCode == 200) {
      sdkToken = json.decode(await sdkResponse.stream.bytesToString())['token'];
    }
  }

  connectSamsungHealth() async {
    await TerraFlutter.initConnection(Connection.samsung, sdkToken, true, [])
        .then((value) => {
      getUserId(),
    });
  }

  connectGoogleFit() async {
    await TerraFlutter.initConnection(Connection.googleFit, sdkToken, true, [])
        .then((value) => {
      getUserId(),
    });
  }

  getUserId() async {
    TerraFlutter.getUserId(Connection.googleFit)
        .then((value) => {debugPrint("userID == $value")});
  }
}