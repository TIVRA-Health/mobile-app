import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:tivra_health/common/color_constants.dart';
import 'package:tivra_health/common/image_assets.dart';
import 'package:tivra_health/common/size_constants.dart';
import 'package:tivra_health/common/text_styles_constants.dart';
import 'package:tivra_health/data/all_bloc/get_dashboard/repo/get_dashboard_details_response.dart';
import 'package:tivra_health/modules/dashboard/model/dashboard_model.dart';

class DashboardHealthScreenWidget extends StatefulWidget {
  late DashboardModel mDashboardModel;
  late List<Health> health;

  DashboardHealthScreenWidget(
      {super.key, required this.mDashboardModel, required this.health});

  @override
  State<DashboardHealthScreenWidget> createState() =>
      _DashboardHealthScreenWidgetState();
}

class _DashboardHealthScreenWidgetState
    extends State<DashboardHealthScreenWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildView();
  }

  _buildView() {
    return Container(
        margin: EdgeInsets.only(
            left: SizeConstants.s1 * 5, right: SizeConstants.s1 * 5),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.health.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemBuilder: (BuildContext context, int index) {
            // String base64String = "";
            // if((widget.health[index].icon??"").isNotEmpty) {
            //   base64String =  widget.mDashboardModel.getImage(widget.health[index].icon??"");
            // }
            // print("##### $base64String");
            return Card(
                child: Container(
              margin: EdgeInsets.all(SizeConstants.s1 * 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                          height: SizeConstants.s1 * 35,
                          width: SizeConstants.s1 * 35,
                          child: FutureBuilder<String>(
                              future: widget.mDashboardModel
                                  .getImage(widget.health[index].icon ?? ""),
                              builder: (BuildContext context,
                                  AsyncSnapshot<String> snapshot) {
                                if (snapshot.hasData) {
                                  if (snapshot.data != null) {
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
                              })),
                      SizedBox(
                        width: SizeConstants.s1 * 15,
                      ),
                      Expanded(
                          child: Text(
                        widget.health[index].label ?? "--",
                        style: getTextRegular(
                          colors: ColorConstants.cDashboardGradientColor,
                          size: SizeConstants.s1 * 18,
                        ),
                      )),
                    ],
                  ),
                  Expanded(
                      child: Container(
                    alignment: Alignment.center,
                    child: ((widget.health[index].type ?? "") == "progress")
                        ? Text(
                            (widget.health[index].progressValue != "null" &&
                                    widget.health[index].progressValue !=
                                        "No Data Available" &&
                                    widget.health[index].progressValue !=
                                        "NA" &&
                                    widget.health[index].progressValue!
                                        .isNotEmpty)
                                ? double.parse(
                                        widget.health[index].progressValue ??
                                            "0.00")
                                    .toStringAsFixed(2)
                                : "0.00",
                            style: getTextMedium(
                              colors: Colors.black,
                              size: SizeConstants.s1 * 33,
                            ),
                          )
                        : Text(
                            (widget.health[index].value != "null" &&
                                    widget.health[index].value !=
                                        "No Data Available" &&
                                    widget.health[index].value != "NA" &&
                                    widget.health[index].value!.isNotEmpty)
                                ? double.parse(
                                        widget.health[index].value ?? "0.00")
                                    .toStringAsFixed(2)
                                : "0.00",
                            style: getTextMedium(
                              colors: Colors.black,
                              size: SizeConstants.s1 * 33,
                            ),
                          ),
                  )),
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.end,
                  //   children: [
                  //     Text(
                  //       sNumber,
                  //       style: getTextMedium(
                  //         colors: Colors.black,
                  //         size: SizeConstants.s1 * 33,
                  //       ),
                  //     ),
                  //     Text(
                  //       subTest,
                  //       style: getTextLight(
                  //         colors: Colors.grey.shade500,
                  //         size: SizeConstants.s1 * 18,
                  //       ),
                  //     ),
                  //   ],
                  // )
                ],
              ),
            ));
          },
        ));
  }

//   Container(
//   margin: EdgeInsets.only(
//       left: SizeConstants.s1 * 5, right: SizeConstants.s1 * 5),
//   width: SizeConstants.width,
//   child: Column(
//     children: [
//       Row(
//         children: [
//           dashboardTextView("Heart Rate", ImageAssets.heartDashboard, "72"),
//           dashboardTextView("Heart Rate\nvariability",
//               ImageAssets.variabilityDashboard, "40"),
//         ],
//       ),
//       Row(
//         children: [
//           dashboardTextView("Heart Rate", ImageAssets.heartDashboard, "72"),
//           dashboardTextView("Heart Rate\nvariability",
//               ImageAssets.variabilityDashboard, "40"),
//         ],
//       ),
//       Row(
//         children: [
//           dashboardTextView("Heart Rate", ImageAssets.heartDashboard, "72"),
//           dashboardTextProgressView("Heart Rate\nvariability",
//               ImageAssets.variabilityDashboard, "90", 90 / 100),
//         ],
//       ),
//       Row(
//         children: [
//           dashboardTextView("Heart Rate", ImageAssets.heartDashboard, "72",
//               subTest: "Pounds"),
//           dashboardTextCenterView("Heart Rate\nvariability",
//               ImageAssets.variabilityDashboard, "123/72"),
//         ],
//       ),
//       Row(
//         children: [
//           dashboardGreenTextCenterView(
//               "Heart Rate", ImageAssets.heartDashboard, "Not depressed"),
//           Expanded(child: Container())
//         ],
//       ),
//     ],
//   ),
// );
}
