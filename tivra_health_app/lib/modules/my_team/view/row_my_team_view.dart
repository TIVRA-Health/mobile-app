import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tivra_health/common/app_constants.dart';
import 'package:tivra_health/common/appbars_constants.dart';
import 'package:tivra_health/common/color_constants.dart';
import 'package:tivra_health/common/image_assets.dart';
import 'package:tivra_health/common/size_constants.dart';
import 'package:tivra_health/common/text_styles_constants.dart';
import 'package:tivra_health/common/widget/dropdown_button_view/dropdown_button2.dart';
import 'package:tivra_health/common/widget/pull_to_refresh_header_widget.dart';
import 'package:tivra_health/data/all_bloc/my_team_list/repo/my_team_list_response.dart';
import 'package:tivra_health/modules/menu/view/side_menu_drawer.dart';
import 'package:tivra_health/modules/my_team/model/my_team_model.dart';
import 'package:tivra_health/routes/route_constants.dart';

class RowMyTeamViewWidget extends StatefulWidget {
  final int index;
  final MyTeamListData mMyTeamListData;

  const RowMyTeamViewWidget(
      {super.key, required this.index, required this.mMyTeamListData});

  @override
  State<RowMyTeamViewWidget> createState() => _RowMyTeamViewWidgetState();
}

class _RowMyTeamViewWidgetState extends State<RowMyTeamViewWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () async {
          Navigator.pushNamed(
              context, RouteConstants.rPlayerDetailsScreenWidget,
              arguments: widget.mMyTeamListData.mateId);
        },
        child: Padding(
          padding: EdgeInsets.all(SizeConstants.s_8),
          child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: Offset(0, 1), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                  padding: EdgeInsets.only(
                    left: SizeConstants.s_15,
                    right: SizeConstants.s_15,
                    top: SizeConstants.s_15,
                    bottom: SizeConstants.s_15,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: SizeConstants.s1 * 60,
                            width: SizeConstants.s1 * 60,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            width: SizeConstants.s1 * 10,
                          ),
                          Expanded(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.mMyTeamListData.player?.name ?? "",
                                style: getTextSemiBold(
                                    colors:
                                        ColorConstants.cDashboardGradientColor,
                                    size: SizeConstants.s_18),
                              ),
                              SizedBox(
                                height: SizeConstants.s1 * 3,
                              ),
                              Text(
                                widget.mMyTeamListData.player?.active ?? "",
                                style: getTextRegular(
                                    colors: Colors.black,
                                    size: SizeConstants.s_16),
                              ),
                            ],
                          ))
                        ],
                      ),
                      SizedBox(
                        height: SizeConstants.s1 * 15,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Heart rate",
                                style: getTextSemiBold(
                                    colors:
                                        ColorConstants.cDashboardGradientColor,
                                    size: SizeConstants.s_18),
                              ),
                              SizedBox(
                                height: SizeConstants.s1 * 3,
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    ImageAssets.heartDashboard,
                                    height: SizeConstants.s1 * 13,
                                  ),
                                  SizedBox(
                                    width: SizeConstants.s1 * 5,
                                  ),
                                  Text(
                                    "${widget.mMyTeamListData.heartRate?.value ?? "0"} ${widget.mMyTeamListData.heartRate?.unit ?? "bpm"}",
                                    style: getTextRegular(
                                        colors: Colors.black,
                                        size: SizeConstants.s_16),
                                  )
                                ],
                              ),
                            ],
                          )),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Running",
                                style: getTextSemiBold(
                                    colors:
                                        ColorConstants.cDashboardGradientColor,
                                    size: SizeConstants.s_18),
                              ),
                              SizedBox(
                                height: SizeConstants.s1 * 3,
                              ),
                              Row(children: [
                                Image.asset(
                                  ImageAssets.runningDashboard,
                                  height: SizeConstants.s1 * 13,
                                ),
                                SizedBox(
                                  width: SizeConstants.s1 * 5,
                                ),
                                Text(
                                  "${widget.mMyTeamListData.running?.value ?? "0"} ${widget.mMyTeamListData.running?.unit ?? "bpm"}",
                                  style: getTextRegular(
                                      colors: Colors.black,
                                      size: SizeConstants.s_16),
                                )
                              ]),
                            ],
                          ))
                        ],
                      ),
                      SizedBox(
                        height: SizeConstants.s1 * 10,
                      ),
                      Text(
                        "Heart rate variability",
                        style: getTextSemiBold(
                            colors: ColorConstants.cDashboardGradientColor,
                            size: SizeConstants.s_18),
                      ),
                      SizedBox(
                        height: SizeConstants.s1 * 3,
                      ),
                      Row(children: [
                        Image.asset(
                          ImageAssets.variabilityDashboard,
                          height: SizeConstants.s1 * 20,
                        ),
                        SizedBox(
                          width: SizeConstants.s1 * 5,
                        ),
                        Text(
                          "${widget.mMyTeamListData.heartRateVariability?.value ?? "0"}",
                          style: getTextRegular(
                              colors: Colors.black, size: SizeConstants.s_16),
                        )
                      ]),
                      SizedBox(
                        height: SizeConstants.s1 * 15,
                      ),
                    ],
                  ))),
        ));
  }
}
