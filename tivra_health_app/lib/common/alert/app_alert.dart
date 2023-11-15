import 'dart:ui';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:tivra_health/common/alert/alert_action.dart';
import 'package:tivra_health/common/color_constants.dart';
import 'package:tivra_health/common/dotted_border/dotted_border.dart';
import 'package:tivra_health/common/image_assets.dart';
import 'package:tivra_health/common/size_constants.dart';
import 'package:tivra_health/common/text_styles_constants.dart';
import 'package:tivra_health/common/utils/date_utils.dart';

class AppAlert {
  AppAlert._();

  static showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 3),
    ));
  }

  ///all Dialog close
  static closeDialog(BuildContext context, {String sText = ""}) {
    if (sText.isEmpty) {
      Navigator.of(context).pop();
    } else {
      Navigator.of(context).pop(sText);
    }
  }

  /// The device is registered successfully
  static showDialogDeviceSuccessfully(BuildContext context, String sDevice,
      String sImageSuccessfully, String sMassage) {
    showDialog(
        context: context,
        barrierDismissible: true,
        barrierColor: Color(0xbb000000),
        builder: (BuildContext context) {
          return BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
              child: Material(
                  type: MaterialType.transparency,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(SizeConstants.s1 * 6),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(SizeConstants.s1 * 5),
                            color: Colors.white),
                        height: SizeConstants.width * 0.75,
                        width: SizeConstants.width * 0.9,
                        child: Column(
                          children: [
                            Expanded(
                                child: Container(
                              margin: EdgeInsets.only(
                                  top: SizeConstants.s1 * 25,
                                  left: SizeConstants.s1 * 45,
                                  right: SizeConstants.s1 * 45),
                              child: Stack(
                                children: [
                                  Expanded(
                                      child: Container(
                                    margin: EdgeInsets.only(
                                        bottom: SizeConstants.s1 * 25),
                                    padding:
                                        EdgeInsets.all(SizeConstants.s1 * 15),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            SizeConstants.s1 * 5),
                                        color: ColorConstants
                                            .cScaffoldBackgroundColor),
                                    alignment: Alignment.center,
                                    child: Image.asset(
                                      sDevice,
                                    ),
                                  )),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: SizedBox(
                                      height: SizeConstants.s1 * 50,
                                      width: SizeConstants.s1 * 50,
                                      child: Image.asset(
                                        sImageSuccessfully,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )),
                            Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.all(SizeConstants.s1 * 15),
                              child: Text(
                                sMassage,
                                textAlign: TextAlign.center,
                                style: getTextRegular(
                                  colors: ColorConstants.cBlack,
                                  size: SizeConstants.s1 * 18,
                                  letterSpacing: -0.5,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  )));
        });
  }

  ///Show calendar dialog
  static Future<List<String>> buildCalendarDialog(
      BuildContext context,
      List<DateTime?> dialogCalendarPickerValue,
      CalendarDatePicker2WithActionButtonsConfig mConfig) async {
    final values = await showCalendarDatePicker2Dialog(
      context: context,
      config: mConfig,
      dialogSize: Size(SizeConstants.width - 60,
          SizeConstants.height - (SizeConstants.height) / 1.5),
      borderRadius: BorderRadius.circular(15),
      value: dialogCalendarPickerValue,
      dialogBackgroundColor: Colors.white,
    );

    final selectedDate =
    (((values?.isNotEmpty ?? false) && (values != null)) ? values[0] : "")
        .toString();
    return [
      getDateFromDate(selectedDate,
          fromDateFormat: DateFormats.yMdFormat,
          toDateString: DateFormats.mDYFormat) ??
          ""
    ];
  }

  /// Vouchers redeemed
  // static showDialogVouchersRedeemed(
  //     BuildContext context, double width, Vouchers mVouchers) {
  //   showDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       barrierColor: Color(0xbb000000),
  //       builder: (BuildContext context) {
  //         String sAmount =
  //             "RM${mVouchers.flatAmount.toString() == "null" ? "0.0" : mVouchers.flatAmount.toString()} OFF";
  //         if (mVouchers.flatAmount.toString() == "null") {
  //           sAmount =
  //               "${mVouchers.percentage.toString() == "null" ? "0.0" : mVouchers.percentage.toString()}% OFF";
  //         }
  //         return BackdropFilter(
  //           filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Container(
  //                 margin: EdgeInsets.all(SizeConstants.s_30),
  //                 child: Row(
  //                   children: [
  //                     GestureDetector(
  //                       onTap: () {
  //                         closeDialog(context);
  //                       },
  //                       child: Container(
  //                         padding: EdgeInsets.all(SizeConstants.s_12),
  //                         decoration: BoxDecoration(
  //                             boxShadow: [
  //                               BoxShadow(
  //                                 color: Colors.grey.withOpacity(0.3),
  //                                 spreadRadius: 1,
  //                                 blurRadius: 3,
  //                                 offset: const Offset(
  //                                     0, 1), // changes position of shadow
  //                               ),
  //                             ],
  //                             color: Colors.white,
  //                             borderRadius:
  //                                 const BorderRadius.all(Radius.circular(8))),
  //                         height: SizeConstants.s1 * 41,
  //                         width: SizeConstants.s1 * 41,
  //                         child: Image.asset(ImageAssets.imageCloseCross),
  //                       ),
  //                     ),
  //                     SizedBox(
  //                       width: SizeConstants.s_15,
  //                     ),
  //                     Text(sAmount,
  //                         style: getTextSemiBold(
  //                             colors: ColorConstants.cWhite,
  //                             size: SizeConstants.s_22,
  //                             letterSpacing: 0.1)),
  //                   ],
  //                 ),
  //               ),
  //               Container(
  //                 margin: EdgeInsets.all(SizeConstants.s_20),
  //                 height: width * 0.5,
  //                 decoration: BoxDecoration(
  //                     boxShadow: [
  //                       BoxShadow(
  //                         color: Colors.grey.withOpacity(0.3),
  //                         spreadRadius: 1,
  //                         blurRadius: 3,
  //                         offset:
  //                             const Offset(0, 1), // changes position of shadow
  //                       ),
  //                     ],
  //                     gradient: const LinearGradient(
  //                       begin: Alignment.topLeft,
  //                       end: Alignment.bottomRight,
  //                       colors: [
  //                         Color(0xffD3D0D0),
  //                         Color(0xff454545),
  //                       ],
  //                     ),
  //                     borderRadius: const BorderRadius.all(Radius.circular(8))),
  //                 child: Column(
  //                   children: [
  //                     Expanded(
  //                         flex: 7,
  //                         child: Container(
  //                             padding: EdgeInsets.only(
  //                               left: SizeConstants.s_26,
  //                               right: SizeConstants.s_26,
  //                             ),
  //                             alignment: Alignment.center,
  //                             child: Column(
  //                               crossAxisAlignment: CrossAxisAlignment.center,
  //                               mainAxisAlignment: MainAxisAlignment.center,
  //                               children: [
  //                                 Container(
  //                                   padding: EdgeInsets.all(SizeConstants.s_15),
  //                                   decoration: BoxDecoration(
  //                                       boxShadow: [
  //                                         BoxShadow(
  //                                           color: Colors.grey.withOpacity(0.3),
  //                                           spreadRadius: 1,
  //                                           blurRadius: 3,
  //                                           offset: const Offset(0,
  //                                               1), // changes position of shadow
  //                                         ),
  //                                       ],
  //                                       color: Colors.white,
  //                                       borderRadius: const BorderRadius.all(
  //                                           Radius.circular(8))),
  //                                   height: SizeConstants.s_72,
  //                                   width: SizeConstants.s_72,
  //                                   child: Image.asset(
  //                                       ImageAssets.imageVouchersListRedeemed),
  //                                 ),
  //                                 SizedBox(
  //                                   height: SizeConstants.s_20,
  //                                 ),
  //                                 Text(sAmount,
  //                                     style: getTextSemiBold(
  //                                         colors: ColorConstants.cWhite,
  //                                         size: SizeConstants.s_20,
  //                                         letterSpacing: 0.5)),
  //                                 SizedBox(
  //                                   height: SizeConstants.s_18,
  //                                 ),
  //                                 Text("Minimum Spend",
  //                                     style: getTextLight(
  //                                         colors: ColorConstants.cWhite,
  //                                         size: SizeConstants.s_16,
  //                                         letterSpacing: 0.5)),
  //                                 Text("RM${mVouchers.minimumSpendAmount}",
  //                                     style: getTextSemiBold(
  //                                         colors: ColorConstants.cWhite,
  //                                         size: SizeConstants.s_18)),
  //                               ],
  //                             ))),
  //                     Padding(
  //                       padding: EdgeInsets.only(
  //                         left: SizeConstants.s_8,
  //                         right: SizeConstants.s_8,
  //                       ),
  //                       child: DottedBorder(
  //                         dashPattern: const [3, 5],
  //                         strokeWidth: 1,
  //                         color: ColorConstants.cDividerLightColor,
  //                         padding: EdgeInsets.all(0.0),
  //                         child: Container(),
  //                       ),
  //                     ),
  //                     Expanded(
  //                         flex: 2,
  //                         child: Center(
  //                           child: Text(
  //                               'Redeemed on ${mVouchers.usedAt.toString()}',
  //                               style: getTextLight(
  //                                   colors: ColorConstants.cWhite,
  //                                   size: SizeConstants.s_14,
  //                                   letterSpacing: 0.3)),
  //                         ))
  //                   ],
  //                 ),
  //               ),
  //             ],
  //           ),
  //         );
  //       });
  // }

  /// show Progress Dialog loading
  static showProgressDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        barrierColor: Colors.black54,
        builder: (BuildContext context) {
          return BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
              child: WillPopScope(
                onWillPop: () {
                  return Future.value(false);
                },
                child: Center(
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    padding: EdgeInsets.all(SizeConstants.s_16),
                    height: 80,
                    width: 80,
                    child: const CircularProgressIndicator(
                      strokeWidth: 6.0,
                      color: ColorConstants.kPrimaryColor,
                    ),
                  ),
                ),
              ));
        });
  }

  /// show NoYes
  static Future<AlertAction> showCustomDialogYesNo(
    BuildContext context,
    String sTitle,
    String message, {
    String buttonOneText = "No",
    String buttonTwoText = "Yes",
  }) async {
    final action = await showDialog(
        context: context,
        barrierDismissible: false,
        barrierColor: const Color(0xbb000000),
        builder: (BuildContext context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.all(SizeConstants.s_30),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          closeDialog(context);
                        },
                        child: Container(
                          padding: EdgeInsets.all(SizeConstants.s_12),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 3,
                                  offset: const Offset(
                                      0, 1), // changes position of shadow
                                ),
                              ],
                              color: Colors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8))),
                          height: SizeConstants.s1 * 41,
                          width: SizeConstants.s1 * 41,
                          child: Image.asset(ImageAssets.imageCloseCross),
                        ),
                      ),
                      SizedBox(
                        width: SizeConstants.s_15,
                      ),
                      Text(sTitle,
                          style: getTextSemiBold(
                              colors: ColorConstants.cWhite,
                              size: SizeConstants.s_20,
                              letterSpacing: 0.1)),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: SizeConstants.s_26, right: SizeConstants.s_26),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(SizeConstants.s_8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: SizeConstants.s_26,
                            bottom: SizeConstants.s_12),
                        child: Text(message,
                            style: getTextSemiBold(
                              colors: Colors.black87,
                              size: SizeConstants.s_18,
                            )),
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(
                              SizeConstants.width * 0.08,
                              SizeConstants.width * 0.06,
                              SizeConstants.width * 0.08,
                              SizeConstants.width * 0.08),
                          child: Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                    height: SizeConstants.width * 0.12,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          closeDialog(context,
                                              sText: AlertAction.cancel
                                                  .toString());
                                        },
                                        style: ElevatedButton.styleFrom(
                                            elevation: 0.0,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(
                                                        SizeConstants.s_15))),
                                            backgroundColor: Colors.black,
                                            side: const BorderSide(
                                                width: 1.5,
                                                color: ColorConstants.cBlack)),
                                        child: Text(
                                          buttonOneText,
                                          style: getTextMedium(
                                            colors: ColorConstants.cWhite,
                                            size: SizeConstants.width * 0.04,
                                          ),
                                        ))),
                              ),
                              SizedBox(
                                width: SizeConstants.s_14,
                              ),
                              Expanded(
                                child: SizedBox(
                                    height: SizeConstants.width * 0.12,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            elevation: 0.0,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(
                                                        SizeConstants.s_15))),
                                            backgroundColor:
                                                ColorConstants.kPrimaryColor),
                                        onPressed: () {
                                          closeDialog(context,
                                              sText:
                                                  AlertAction.yes.toString());
                                        },
                                        child: Text(
                                          buttonTwoText,
                                          style: getTextMedium(
                                            colors: Colors.white,
                                            size: SizeConstants.width * 0.04,
                                          ),
                                        ))),
                              ),
                            ],
                          ))
                    ],
                  ),
                ),
              ],
            ),
          );
        });
    if (action.toString() != "null" ||
        action.toString() != "AlertAction.cancel") {
      if (action.toString() == "AlertAction.yes") {
        return AlertAction.yes;
      } else if (action.toString() == "AlertAction.no") {
        return AlertAction.no;
      } else if (action.toString() == "AlertAction.ok") {
        return AlertAction.ok;
      } else {
        return AlertAction.cancel;
      }
    } else {
      return AlertAction.cancel;
    }
  }

  /// show YesNo
  static Future<AlertAction> showCustomDialogNoYes(
    BuildContext context,
    String sTitle,
    String message, {
    String buttonOneText = "No",
    String buttonTwoText = "Yes",
  }) async {
    final action = await showDialog(
        context: context,
        barrierDismissible: false,
        barrierColor: const Color(0xbb000000),
        builder: (BuildContext context) {
          return BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
              child: Material(
                type: MaterialType.transparency,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          left: SizeConstants.s_30,
                          right: SizeConstants.s_30,
                          bottom: SizeConstants.s_15),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              closeDialog(context);
                            },
                            child: Container(
                              padding: EdgeInsets.all(SizeConstants.s_12),
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      spreadRadius: 1,
                                      blurRadius: 3,
                                      offset: const Offset(
                                          0, 1), // changes position of shadow
                                    ),
                                  ],
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8))),
                              height: SizeConstants.s1 * 41,
                              width: SizeConstants.s1 * 41,
                              child: Image.asset(ImageAssets.imageCloseCross),
                            ),
                          ),
                          SizedBox(
                            width: SizeConstants.s_15,
                          ),
                          Text(sTitle,
                              style: getTextSemiBold(
                                  colors: ColorConstants.cWhite,
                                  size: SizeConstants.s_20,
                                  letterSpacing: 0.1)),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: SizeConstants.s_26, right: SizeConstants.s_26),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(SizeConstants.s_8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: SizeConstants.s_12,
                                right: SizeConstants.s_12,
                                top: SizeConstants.s_26,
                                bottom: SizeConstants.s_12),
                            child: Text(message,
                                textAlign: TextAlign.center,
                                style: getTextSemiBold(
                                  colors: ColorConstants.cDashboardGradientColor,
                                  size: SizeConstants.s_18,
                                )),
                          ),
                          Padding(
                              padding: EdgeInsets.fromLTRB(
                                  SizeConstants.width * 0.08,
                                  SizeConstants.width * 0.06,
                                  SizeConstants.width * 0.08,
                                  SizeConstants.width * 0.08),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                        height: SizeConstants.width * 0.12,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                elevation: 0.0,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                SizeConstants
                                                                    .s1*5))),
                                                backgroundColor: ColorConstants
                                                    .cSideMenuSelectText),
                                            onPressed: () {
                                              closeDialog(context,
                                                  sText: AlertAction.yes
                                                      .toString());
                                            },
                                            child: Text(
                                              buttonTwoText,
                                              style: getTextMedium(
                                                colors: Colors.white,
                                                size:
                                                    SizeConstants.width * 0.04,
                                              ),
                                            ))),
                                  ),
                                  SizedBox(
                                    width: SizeConstants.s_14,
                                  ),
                                  Expanded(
                                    child: SizedBox(
                                        height: SizeConstants.width * 0.12,
                                        child: ElevatedButton(
                                            onPressed: () {
                                              closeDialog(context,
                                                  sText: AlertAction.cancel
                                                      .toString());
                                            },
                                            style: ElevatedButton.styleFrom(
                                                elevation: 0.0,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                SizeConstants
                                                                    .s1*5))),
                                                backgroundColor: ColorConstants.cDashboardGradientColor,
                                                side: const BorderSide(
                                                    width: 1.5,
                                                    color:
                                                        ColorConstants.cBlack)),
                                            child: Text(
                                              buttonOneText,
                                              style: getTextMedium(
                                                colors: ColorConstants.cWhite,
                                                size:
                                                    SizeConstants.width * 0.04,
                                              ),
                                            ))),
                                  ),
                                ],
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              ));
        });
    if (action.toString() != "null" ||
        action.toString() != "AlertAction.cancel") {
      if (action.toString() == "AlertAction.yes") {
        return AlertAction.yes;
      } else if (action.toString() == "AlertAction.no") {
        return AlertAction.no;
      } else if (action.toString() == "AlertAction.ok") {
        return AlertAction.ok;
      } else {
        return AlertAction.cancel;
      }
    } else {
      return AlertAction.cancel;
    }
  }

  ///Success
  // static Future<AlertAction> showSuccess(
  static Future<void> showSuccess(BuildContext context, String message) async {
    AppAlert.showSnackBar(context, message);
  }

  ///Error
  // static Future<AlertAction> showError(
  static Future<void> showError(BuildContext context, String message) async {
    AppAlert.showSnackBar(context, message);
  }
}
