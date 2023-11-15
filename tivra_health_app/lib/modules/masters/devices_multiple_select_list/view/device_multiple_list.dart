import 'package:flutter/material.dart';
import 'package:tivra_health/common/app_constants.dart';
import 'package:tivra_health/common/color_constants.dart';
import 'package:tivra_health/common/image_assets.dart';
import 'package:tivra_health/common/message_constants.dart';
import 'package:tivra_health/common/size_constants.dart';
import 'package:tivra_health/common/text_styles_constants.dart';

class MasterMultipleDevicesScreenList extends StatefulWidget {
  final List<String> sMultipleDevicesListItems;

  const MasterMultipleDevicesScreenList(
      {Key? key, required this.sMultipleDevicesListItems})
      : super(key: key);

  @override
  _MasterMultipleDevicesScreenListState createState() =>
      _MasterMultipleDevicesScreenListState();
}

class _MasterMultipleDevicesScreenListState
    extends State<MasterMultipleDevicesScreenList> {
  List<String> sDevicesListItems = [
    ImageAssets.device1,
    ImageAssets.device2,
    ImageAssets.device3,
    ImageAssets.device4,
    ImageAssets.device5,
    ImageAssets.device6,
    ImageAssets.device7,
    ImageAssets.device8
  ];
  List<String> sSelectDevicesListItems = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: _buildConditionBasedWidget()));
  }

  Widget _buildConditionBasedWidget() {
    if (sDevicesListItems.isEmpty) {
      return Expanded(
        child: Center(
          child: Text(
            MessageConstants.noDataFound,
            style:
                getTextRegular(colors: Colors.black, size: SizeConstants.s_16),
          ),
        ),
      );
    }
    return Container(
      // margin: EdgeInsets.only(top: 100),
      color: ColorConstants.cWhite,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: EdgeInsets.all(SizeConstants.s1 * 15),
                child: Row(
                  children: [
                    Expanded(
                        child: Text(
                      AppConstants.mWordConstants.sAddDevices,
                      style: getTextMedium(
                        colors: ColorConstants.cBlack,
                        size: SizeConstants.s1 * 20,
                      ),
                    )),
                    InkWell(
                      child: const Icon(
                        Icons.close,
                        color: Colors.black,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                )),
            Expanded(
              child: ListView.builder(
                  itemCount: sDevicesListItems.length,
                  itemBuilder: (BuildContext context, int index) {
                    bool value = widget.sMultipleDevicesListItems
                        .where((element) => element == sDevicesListItems[index])
                        .toList()
                        .isEmpty;
                    return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (value) {
                              widget.sMultipleDevicesListItems
                                  .add(sDevicesListItems[index]);
                            } else {
                              widget.sMultipleDevicesListItems
                                  .remove(sDevicesListItems[index]);
                            }
                            sSelectDevicesListItems.clear();
                            sSelectDevicesListItems.addAll(widget.sMultipleDevicesListItems);
                          });
                        },
                        child: Container(
                            color: Colors.transparent,
                            child: Column(
                              children: [
                                Divider(),
                                Row(
                                  children: [
                                    SizedBox(width: SizeConstants.s1*15,),
                                    value
                                        ? Container(
                                            child: Icon(
                                              Icons
                                                  .check_box_outline_blank_rounded,
                                              color:
                                                  ColorConstants.cBorderColor,
                                            ),
                                          )
                                        : Container(
                                            child: Icon(
                                              Icons.check_box,
                                              color: ColorConstants
                                                  .cLightDashboardGreenTextColor,
                                            ),
                                          ),
                                    Container(
                                      color: Colors.transparent,
                                      alignment: Alignment.centerLeft,
                                      padding:
                                          EdgeInsets.all(SizeConstants.s_16),
                                      child: Image.asset(
                                        sDevicesListItems[index],
                                        height: SizeConstants.s1 * 35,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            )));
                  }),
            ),
            Container(
                margin: EdgeInsets.all(SizeConstants.s1 * 15),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context, sSelectDevicesListItems);
                  },
                  child: Container(
                    height: SizeConstants.s1 * 55,
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(SizeConstants.s1 * 5),
                        color: ColorConstants.cLightDashboardGradientColor,
                        border: Border.all(
                            color: ColorConstants.cBorderColor,
                            width: SizeConstants.s_05)),
                    alignment: Alignment.center,
                    child: Text(
                      AppConstants.mWordConstants.sSave,
                      style: getTextMedium(
                        colors: ColorConstants.cWhite,
                        size: SizeConstants.s1 * 18,
                      ),
                    ),
                  ),
                )),
          ]),
    );
  }
}
