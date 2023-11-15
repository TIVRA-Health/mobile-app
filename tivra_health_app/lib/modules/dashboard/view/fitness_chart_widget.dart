import 'dart:typed_data';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tivra_health/common/color_constants.dart';
import 'package:tivra_health/common/image_assets.dart';
import 'package:tivra_health/common/size_constants.dart';
import 'package:tivra_health/common/text_styles_constants.dart';
import 'package:tivra_health/data/all_bloc/get_dashboard/repo/get_dashboard_details_response.dart';
import 'package:tivra_health/modules/dashboard/model/dashboard_model.dart';

class FitnessLineChartWidget extends StatefulWidget {
  final DashboardModel mDashboardModel;
  final String selectedValue;
  final GetDashboardDetailsResponse mGetDashboardDetailsResponse;

  const FitnessLineChartWidget(
      {Key? key,
      required this.mDashboardModel,
      required this.selectedValue,
      required this.mGetDashboardDetailsResponse})
      : super(key: key);

  @override
  State<FitnessLineChartWidget> createState() => _FitnessLineChartWidgetState();
}

class _FitnessLineChartWidgetState extends State<FitnessLineChartWidget> {
  List<DashboardData> data = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("FitnessLineChartWidget===${widget.selectedValue}");
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.only(bottom: SizeConstants.s1 * 5),
      itemCount: widget.selectedValue == "Health"
          ? (widget.mGetDashboardDetailsResponse.health??[]).length
          : widget.selectedValue == "Fitness"
              ? (widget.mGetDashboardDetailsResponse.fitness??[]).length
              : (widget.mGetDashboardDetailsResponse.nutrition??[]).length,
      itemBuilder: (BuildContext context, int index) {
        switch (widget.selectedValue) {
          case "Health":
            return viewItemHealth(
                index, widget.mGetDashboardDetailsResponse.health![index]);
          case "Fitness":
            return viewItemFitness(
                index, widget.mGetDashboardDetailsResponse.fitness![index]);
          case "Nutrition":
            return viewItemNutrition(
                index, widget.mGetDashboardDetailsResponse.nutrition![index]);
        }
      },
    );
  }

  viewItemHealth(int index, Health mHealth) {
    return Container(
        height: SizeConstants.s1 * 250,
        padding: EdgeInsets.all(SizeConstants.s1),
        margin: EdgeInsets.only(
            bottom: SizeConstants.s1 * 12,
            left: SizeConstants.s1 * 15,
            right: SizeConstants.s1 * 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(SizeConstants.s1 * 10),
            color: ColorConstants.cWhite),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                  left: SizeConstants.s_10, top: SizeConstants.s5),
              child: Row(
                children: [
                  SizedBox(
                    height: SizeConstants.s1 * 30,
                    width: SizeConstants.s1 * 30,
                    child: FutureBuilder<String>(
                        future: widget.mDashboardModel
                            .getImage(mHealth.icon ?? ""),
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
                        })
                  ),
                  Text(
                    " ${mHealth.label ?? "- -"}",
                    style: getTextMedium(
                        colors: ColorConstants.cBlack,
                        size: SizeConstants.s1 * 16),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: SizeConstants.s_10,
            ),
            Expanded(child: buildLineChart(context, mHealth.data ?? [])),
          ],
        ));
  }

  viewItemFitness(int index, Fitness mFitness) {
    return Container(
        height: SizeConstants.s1 * 250,
        padding: EdgeInsets.all(SizeConstants.s1),
        margin: EdgeInsets.only(
            bottom: SizeConstants.s1 * 12,
            left: SizeConstants.s1 * 15,
            right: SizeConstants.s1 * 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(SizeConstants.s1 * 10),
            color: ColorConstants.cWhite),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                  left: SizeConstants.s_10, top: SizeConstants.s5),
              child: Row(
                children: [
                  SizedBox(
                    height: SizeConstants.s1 * 30,
                    width: SizeConstants.s1 * 30,
                    child: FutureBuilder<String>(
                        future: widget.mDashboardModel
                            .getImage(mFitness.icon ?? ""),
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
                  Text(
                    " ${mFitness.label ?? "- -"}",
                    style: getTextMedium(
                        colors: ColorConstants.cBlack,
                        size: SizeConstants.s1 * 16),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: SizeConstants.s_10,
            ),
            Expanded(child: buildLineChart(context, mFitness.data ?? [])),
          ],
        ));
  }

  viewItemNutrition(int index, Nutrition mNutrition) {
    return Container(
        height: SizeConstants.s1 * 250,
        padding: EdgeInsets.all(SizeConstants.s1),
        margin: EdgeInsets.only(
            bottom: SizeConstants.s1 * 12,
            left: SizeConstants.s1 * 15,
            right: SizeConstants.s1 * 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(SizeConstants.s1 * 10),
            color: ColorConstants.cWhite),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                  left: SizeConstants.s_10, top: SizeConstants.s5),
              child: Row(
                children: [
                  SizedBox(
                    height: SizeConstants.s1 * 30,
                    width: SizeConstants.s1 * 30,
                    child: FutureBuilder<String>(
                        future: widget.mDashboardModel
                            .getImage(mNutrition.icon ?? ""),
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
                  Text(
                    " ${mNutrition.label ?? "- -"}",
                    style: getTextMedium(
                        colors: ColorConstants.cBlack,
                        size: SizeConstants.s1 * 16),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: SizeConstants.s_10,
            ),
            Expanded(child: buildLineChart(context, mNutrition.data ?? [])),
          ],
        ));
  }

  ///Build line chart with data
  Widget buildLineChart(BuildContext context, List<DashboardData> data) {
    return Container(
      padding: EdgeInsets.only(right: SizeConstants.s1 * 20),
      child: LineChart(
        LineChartData(
          borderData:
              FlBorderData(show: true, border: Border.all(color: Colors.grey)),
          titlesData: const FlTitlesData(
              bottomTitles: AxisTitles(
                  sideTitles: SideTitles(reservedSize: 30, showTitles: true)),
              rightTitles:
                  AxisTitles(sideTitles: SideTitles(showTitles: false)),
              leftTitles: AxisTitles(
                  sideTitles: SideTitles(reservedSize: 40, showTitles: true)),
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              show: true),
          lineBarsData: [
            LineChartBarData(
              color: Colors.pink,
              spots: [
                const FlSpot(0, -100),
                const FlSpot(1, -50),
                const FlSpot(2, -20),
                const FlSpot(3, -10),
                const FlSpot(4, 0),
                const FlSpot(5, 50),
                const FlSpot(6, 100),
              ],
              isCurved: false,
              dotData: const FlDotData(show: true),
              belowBarData: BarAreaData(show: false),
            ),
            LineChartBarData(
              color: Colors.blue,
              spots: [
                const FlSpot(0, 100),
                const FlSpot(1, 50),
                const FlSpot(2, 30),
                const FlSpot(3, 10),
                const FlSpot(4, 0),
                const FlSpot(5, -50),
                const FlSpot(6, -100),
              ],
              isCurved: false,
              // Use true for a dotted line
              dotData: const FlDotData(show: true),
              belowBarData: BarAreaData(show: false),
            ),
          ],
        ),
      ),
    );
  }
}
