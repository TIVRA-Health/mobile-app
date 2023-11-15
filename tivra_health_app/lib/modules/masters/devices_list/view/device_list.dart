import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tivra_health/common/app_constants.dart';
import 'package:tivra_health/common/color_constants.dart';
import 'package:tivra_health/common/image_assets.dart';
import 'package:tivra_health/common/message_constants.dart';
import 'package:tivra_health/common/size_constants.dart';
import 'package:tivra_health/common/text_styles_constants.dart';
import 'package:tivra_health/data/all_bloc/devices_list/bloc/devices_list_bloc.dart';
import 'package:tivra_health/data/all_bloc/devices_list/bloc/devices_list_state.dart';
import 'package:tivra_health/data/all_bloc/devices_list/repo/devices_list_response.dart';
import 'package:tivra_health/modules/masters/devices_list/model/devices_screen_model.dart';

class MasterDevicesScreenList extends StatefulWidget {
  final List<String> registeredDeviceList;
  const MasterDevicesScreenList({Key? key, required this.registeredDeviceList}) : super(key: key);

  @override
  _MasterDevicesScreenListState createState() =>
      _MasterDevicesScreenListState();
}

class _MasterDevicesScreenListState extends State<MasterDevicesScreenList> {
  late DevicesListModel mDevicesListModel;

  @override
  void initState() {
    super.initState();
    mDevicesListModel = DevicesListModel(context);
    mDevicesListModel.setDevicesListBloc();
    mDevicesListModel.getAllImage();
    mDevicesListModel.onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: MultiBlocListener(listeners: [
      BlocListener<DevicesListBloc, DevicesListState>(
        bloc: mDevicesListModel.getDevicesListBloc(),
        listener: (context, state) {
          mDevicesListModel.blocDevicesListListener(context, state);
        },
      ),
    ], child: _buildConditionBasedWidget())));
  }

  _buildConditionBasedWidget() {
    return StreamBuilder<DevicesListResponse?>(
      stream: mDevicesListModel.responseSubject,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          DevicesListResponse mDevicesListResponse =
              snapshot.data as DevicesListResponse;
          if (mDevicesListResponse.data != null &&
              mDevicesListResponse.data!.isNotEmpty) {
            return showDevicesList(mDevicesListResponse.data ?? []);
          } else {
            return Expanded(
              child: Center(
                child: Text(
                  MessageConstants.noDataFound,
                  style: getTextRegular(
                      colors: Colors.black, size: SizeConstants.s_16),
                ),
              ),
            );
          }
        }
        return Container();
      },
    );
  }

  showDevicesList(List<DevicesListData> data) {
    List<DevicesListData> newData = [];
    newData.addAll(data);
    for (var element in data) {
      for(var name in widget.registeredDeviceList) {
        if(name == element.name) {
          newData.remove(element);
          break;
        }
      }
    }
    return Container(
      // margin: EdgeInsets.only(top: 100),
      color: ColorConstants.cWhite,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                color: Colors.grey.shade200,
                padding: EdgeInsets.all(SizeConstants.s1 * 15),
                child: Row(
                  children: [
                    Expanded(
                        child: Text(
                      AppConstants.mWordConstants.sAddDevices,
                      style: getTextMedium(
                        colors: ColorConstants.cSideMenuSelect,
                        size: SizeConstants.s1 * 20,
                      ),
                    )),
                    InkWell(
                      child: const Icon(
                        Icons.close,
                        color: ColorConstants.cSideMenuSelectText,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                )),
            Expanded(
              child: ListView.builder(
                  itemCount: newData.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        onTap: () {
                            Navigator.pop(context, newData[index]);
                        },
                        child: Column(
                          children: [
                            Divider(
                              height: index == 0 ? 0 : SizeConstants.s1,
                            ),
                            Container(
                                color: Colors.transparent,
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.all(SizeConstants.s_16),
                                child: SizedBox(
                                  height: 60,
                                  width: SizeConstants.width / 2,
                                  child: FutureBuilder<String>(
                                      future: mDevicesListModel
                                          .getImage(newData[index].name ?? ""),
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
                                )
                              /*Text(
                                  newData[index].name ?? "_ _",
                                  style: getTextRegular(
                                    colors:  ColorConstants.cLightDashboardGreenTextColor,

                                    size: SizeConstants.s1 * 22,
                                  ),
                                )*/
                                // Image.asset(
                                //   sDevicesListItems[index],
                                //   height: SizeConstants.s1 * 35,
                                // ),
                                ),
                          ],
                        ));
                  }),
            )
          ]),
    );
  }
}
