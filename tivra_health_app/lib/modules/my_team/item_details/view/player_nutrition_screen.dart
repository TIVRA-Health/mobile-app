import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tivra_health/common/color_constants.dart';
import 'package:tivra_health/common/image_assets.dart';
import 'package:tivra_health/common/size_constants.dart';
import 'package:tivra_health/common/text_styles_constants.dart';
import 'package:tivra_health/modules/my_team/item_details/model/player_view_model.dart';
import 'package:tivra_health/data/all_bloc/get_dashboard/repo/get_dashboard_details_response.dart';

class PlayerNutritionScreenWidget extends StatefulWidget {
  late PlayerDetailsModel mPlayerModel;
  final List<Nutrition> nutrition;
  PlayerNutritionScreenWidget({super.key, required this.mPlayerModel, required this.nutrition});

  @override
  State<PlayerNutritionScreenWidget> createState() =>
      _PlayerNutritionScreenWidgetState();
}

class _PlayerNutritionScreenWidgetState
    extends State<PlayerNutritionScreenWidget> {

  @override
  void initState() {
    print("_PlayerNutritionScreenWidgetState");
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
          itemCount: widget.nutrition.length,
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
                                future: widget.mPlayerModel
                                    .getImage(widget.nutrition[index].icon ?? ""),
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
                                widget.nutrition[index].label ?? "--",
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
                            child: ((widget.nutrition[index].type ?? "") == "progress")
                                ? Text(
                              (widget.nutrition[index].progressValue != "null" &&
                                  widget.nutrition[index].progressValue !=
                                      "No Data Available" &&
                                  widget.nutrition[index].progressValue !=
                                      "NA" &&
                                  widget.nutrition[index].progressValue!
                                      .isNotEmpty)
                                  ? double.parse(
                                  widget.nutrition[index].progressValue ??
                                      "0.00")
                                  .toStringAsFixed(2)
                                  : "0.00",
                              style: getTextMedium(
                                colors: Colors.black,
                                size: SizeConstants.s1 * 33,
                              ),
                            )
                                : Text(
                              (widget.nutrition[index].value != "null" &&
                                  widget.nutrition[index].value != "No Data Available" &&
                                  widget.nutrition[index].value != "NA" &&
                                  widget.nutrition[index].value!.isNotEmpty)
                                  ? double.parse(
                                  widget.nutrition[index].value ?? "0.00")
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
}
