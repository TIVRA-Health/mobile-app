import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:terra_flutter_bridge/terra_flutter_bridge.dart';
import 'package:tivra_health/common/alert/app_alert.dart';
import 'package:tivra_health/common/app_constants.dart';
import 'package:tivra_health/common/appbars_constants.dart';
import 'package:tivra_health/common/color_constants.dart';
import 'package:tivra_health/common/image_assets.dart';
import 'package:tivra_health/common/message_constants.dart';
import 'package:tivra_health/common/size_constants.dart';
import 'package:tivra_health/common/text_styles_constants.dart';
import 'package:tivra_health/data/all_bloc/device_registration/bloc/device_registration_bloc.dart';
import 'package:tivra_health/data/all_bloc/device_registration/bloc/device_registration_state.dart';
import 'package:tivra_health/data/all_bloc/devices_list/repo/devices_list_response.dart';
import 'package:tivra_health/data/all_bloc/registered_device_list/bloc/registered_devices_bloc.dart';
import 'package:tivra_health/data/all_bloc/registered_device_list/bloc/registered_devices_state.dart';
import 'package:tivra_health/modules/devices/model/devices_screen_model.dart';
import 'package:tivra_health/modules/menu/view/side_menu_drawer.dart';
import 'package:tivra_health/routes/route_constants.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;

class DevicesScreenWidget extends StatefulWidget {
  const DevicesScreenWidget({super.key});

  @override
  State<DevicesScreenWidget> createState() => _DevicesScreenWidgetState();
}

class _DevicesScreenWidgetState extends State<DevicesScreenWidget> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
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
        key: scaffoldKey,
        appBar: AppBars.appBarDashboard((value) {}, scaffoldKey),
        drawer: SideMenuDrawer(sMenuType: AppConstants.mWordConstants.sDevices),
        body: MultiBlocListener(child: _buildDevicesScreenView(), listeners: [
          BlocListener<DeviceRegistrationBloc, DeviceRegistrationState>(
            bloc: mDevicesScreenModel.getDeviceRegistrationBloc(),
            listener: (context, state) {
              mDevicesScreenModel.blocDeviceRegistrationListener(
                  context, state);
            },
          ),
          BlocListener<RegisteredDevicesBloc, RegisteredDevicesState>(
            bloc: mDevicesScreenModel.getRegisteredDevicesBloc(),
            listener: (context, state) {
              blocRegisteredDevicesListener(context, state);
            },
          ),
          // BlocListener<PaymentMethodsBloc, PaymentMethodsState>(
          //   bloc: mPaymentMethodsModel.getPaymentMethodsBloc(),
          //   listener: (context, state) {
          //     mPaymentMethodsModel.blocPaymentMethodsListener(context, state);
          //   },
          // ),
        ]));
  }

  _buildDevicesScreenView() {
    return FocusDetector(
        child: SafeArea(
            child: Column(
      children: [
        Expanded(
            child: SingleChildScrollView(
                child: Container(
          constraints: BoxConstraints(
              minHeight: SizeConstants.height * 0.87,
              minWidth: double.infinity),
          child: Column(children: [
            ///add device
            addDevice(),

            ///RegisteredDevices
            registeredDevices(),
          ]),
        ))),
      ],
    )));
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
                            RouteConstants.rMasterDevicesListScreenWidget,arguments: mDevicesScreenModel.sRegisteredDevices);
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
                                              AppConstants.mWordConstants
                                                  .sSelectADevice,
                                              style: getTextRegular(
                                                colors: Colors.grey.shade700,
                                                size: SizeConstants.s1 * 15,
                                              ),
                                            ),
                                          )
                                        : Container(
                                            margin: EdgeInsets.only(
                                                left: SizeConstants.s1 * 10),
                                            child: Text(
                                              sSelectItem,
                                              style: getTextMedium(
                                                colors:
                                                    ColorConstants.cSideMenu,
                                                size: SizeConstants.s1 * 18,
                                              ),
                                            ),
                                          )
                                    // Container(
                                    //         margin: EdgeInsets.only(
                                    //             left: SizeConstants.s1 * 10,
                                    //             right: SizeConstants.s1 * 15,
                                    //             top: SizeConstants.s1 * 3,
                                    //             bottom: SizeConstants.s1 * 3),
                                    //         child: Image.asset(
                                    //           sSelectItem,
                                    //         ),
                                    //       ),
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

  registeredDevicesOld() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: EdgeInsets.all(SizeConstants.s1 * 15),
            child: Text(
              AppConstants.mWordConstants.sRegisteredDevices,
              style: getTextMedium(
                colors: ColorConstants.cBlack,
                size: SizeConstants.s1 * 20,
              ),
            )),
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
                    AppConstants.mWordConstants.sRegisteredDevices,
                    style: getTextRegular(
                      colors: ColorConstants.cBlack,
                      size: SizeConstants.s1 * 17,
                    ),
                  ),
                  GestureDetector(
                      onTap: () async {
                        var result = await Navigator.pushNamed(context,
                            RouteConstants.rMasterMultipleDevicesScreenList,
                            arguments:
                                mDevicesScreenModel.sSelectDevicesListItems);
                        if (result != null) {
                          setState(() {
                            mDevicesScreenModel.sSelectDevicesListItems.clear();
                            mDevicesScreenModel.sSelectDevicesListItems
                                .addAll(result as List<String>);
                          });
                        }
                        // setState(() {
                        //   mDevicesScreenModel.isSave =
                        //       !mDevicesScreenModel.isSave;
                        // });
                      },
                      child: Text(
                        mDevicesScreenModel.isSave
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
                child: mDevicesScreenModel.sSelectDevicesListItems.isEmpty
                    ? SizedBox(
                        height: SizeConstants.s1 * 30,
                      )
                    : getRegisteredDevicesOld(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  getRegisteredDevicesOld() {
    return StaggeredGridView.countBuilder(
      staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: mDevicesScreenModel.sSelectDevicesListItems.length,
      crossAxisCount: 3,
      crossAxisSpacing: 3,
      mainAxisSpacing: 3,
      itemBuilder: (BuildContext context, int index) {
        return registeredDevicesRowOld(
            mDevicesScreenModel.sSelectDevicesListItems[index], index);
      },
    );
  }

  registeredDevicesRowOld(String image, int index) {
    return Container(
        height: SizeConstants.s1 * 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(SizeConstants.s1 * 5),
          color: ColorConstants.cScaffoldBackgroundColor,
          border: Border.all(
              color: ColorConstants.cLightDashboardGreenTextColor,
              width: SizeConstants.s_05),
        ),
        child: Stack(alignment: Alignment.center, children: [
          Container(
            margin: EdgeInsets.all(SizeConstants.s1 * 10),
            child: Image.asset(
              image,
            ),
          ),
          mDevicesScreenModel.isSave
              ? Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        mDevicesScreenModel.sDevicesListItems.add(image);
                        mDevicesScreenModel.sSelectDevicesListItems
                            .removeAt(index);
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(SizeConstants.s1 * 2),
                      child: Icon(
                        Icons.cancel_outlined,
                        size: SizeConstants.s1 * 19,
                        color: ColorConstants.cLightDashboardRedTextColor,
                      ),
                    ),
                  ))
              : SizedBox()
        ]));
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
        mDevicesScreenModel.getSavedRegisteredDevices();
        setState(() {
          mDevicesScreenModel.sRegisteredDevices;
        });
        break;
    }
  }
}
