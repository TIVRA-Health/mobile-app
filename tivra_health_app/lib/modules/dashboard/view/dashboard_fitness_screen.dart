import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:tivra_health/common/app_constants.dart';
import 'package:tivra_health/common/appbars_constants.dart';
import 'package:tivra_health/common/color_constants.dart';
import 'package:tivra_health/common/dashboard_common_view.dart';
import 'package:tivra_health/common/image_assets.dart';
import 'package:tivra_health/common/size_constants.dart';
import 'package:tivra_health/common/text_styles_constants.dart';
import 'package:tivra_health/data/all_bloc/get_dashboard/repo/get_dashboard_details_response.dart';
import 'package:tivra_health/modules/dashboard/model/dashboard_model.dart';

class DashboardFitnessScreenWidget extends StatefulWidget {
  late DashboardModel mDashboardModel;
  late List<Fitness> fitness;

  DashboardFitnessScreenWidget(
      {super.key, required this.mDashboardModel, required this.fitness});

  @override
  State<DashboardFitnessScreenWidget> createState() =>
      _DashboardFitnessScreenWidgetState();
}

class _DashboardFitnessScreenWidgetState
    extends State<DashboardFitnessScreenWidget> {
  @override
  void initState() {
    print("_DashboardFitnessScreenWidgetState ${jsonEncode(widget.fitness)}");
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
          itemCount: widget.fitness.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemBuilder: (BuildContext context, int index) {
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
                                .getImage(widget.fitness[index].icon ?? ""),
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
                            }),
                      ),
                      SizedBox(
                        width: SizeConstants.s1 * 15,
                      ),
                      Expanded(
                          child: Text(
                        widget.fitness[index].label ?? "--",
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
                    child: ((widget.fitness[index].type ?? "") == "progress")
                        ? Text(
                            (widget.fitness[index].progressValue != "null" &&
                                    widget.fitness[index].progressValue !=
                                        "No Data Available" &&
                                widget.fitness[index].progressValue !=
                                        "NA" &&
                                    widget.fitness[index].progressValue!
                                        .isNotEmpty)
                                ? double.parse(
                                        widget.fitness[index].progressValue ??
                                            "0.00")
                                    .toStringAsFixed(2)
                                : "0.00",
                            style: getTextMedium(
                              colors: Colors.black,
                              size: SizeConstants.s1 * 33,
                            ),
                          )
                        : Text(
                            (widget.fitness[index].value != "null" &&
                                    widget.fitness[index].value != "No Data Available" &&
                                widget.fitness[index].value != "NA" &&
                                    widget.fitness[index].value!.isNotEmpty)
                                ? double.parse(
                                        widget.fitness[index].value ?? "0.00")
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

// _buildView() {
//   return Container(
//     margin: EdgeInsets.only(
//         left: SizeConstants.s1 * 5, right: SizeConstants.s1 * 5),
//     width: SizeConstants.width,
//     child: Column(
//       children: [
//         Row(
//           children: [
//             dashboardTextProgressView("Steps Count",
//                 ImageAssets.variabilityDashboard, "1", 1 / 500,
//                 subTest: "of 500"),
//             dashboardTextSideView("Running",
//                 ImageAssets.variabilityDashboard, "0",
//                 subTest: "km"),
//           ],
//         ),
//         Row(
//           children: [
//             dashboardTextView("Calories\nBurned", ImageAssets.heartDashboard, "0"),
//             dashboardTextProgressView("Body Battery",
//                 ImageAssets.variabilityDashboard, "90", 90 / 100),
//           ],
//         ),
//         Row(
//           children: [
//             dashboardTextView(
//                 "Training\nLoad", ImageAssets.heartDashboard,  "0"),
//             dashboardTextView("Activities",
//                 ImageAssets.variabilityDashboard,  "0"),
//           ],
//         ),
//       ],
//     ),
//   );
// }
}
