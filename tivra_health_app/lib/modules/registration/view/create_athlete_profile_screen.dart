import 'package:flutter/cupertino.dart';
import 'package:tivra_health/common/app_constants.dart';
import 'package:tivra_health/common/color_constants.dart';
import 'package:tivra_health/common/image_assets.dart';
import 'package:tivra_health/common/size_constants.dart';
import 'package:tivra_health/common/text_styles_constants.dart';

class CreateAthleteProfileScreen extends StatefulWidget {
  final int currentStep;
  final String role;

  const CreateAthleteProfileScreen(this.currentStep, this.role, {Key? key})
      : super(key: key);

  @override
  State<CreateAthleteProfileScreen> createState() =>
      _CreateAthleteProfileScreen();
}

class _CreateAthleteProfileScreen extends State<CreateAthleteProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return pagerHeaderView();
  }

  Widget pagerHeaderView() {

    return Container(
      color: ColorConstants.cWhite,
      child: Column(
        children: [
          SizedBox(
            height: SizeConstants.s1 * 50,
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: SizeConstants.s1 * 120,
                      child: Text(
                        AppConstants.mWordConstants.sDemographicProfile,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: getTextMedium(
                          colors: ColorConstants.cSuccess,
                          size: SizeConstants.s_12,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                        child: SizedBox(
                            child: Image.asset(ImageAssets.backArrow,
                                color: (widget.currentStep >= 1)
                                    ? ColorConstants.cSuccess
                                    : ColorConstants.cDashboardGradientColor
                                    .withOpacity(0.3)))),
                    SizedBox(
                      width: SizeConstants.s1 * 120,
                      child: Text(
                        AppConstants.mWordConstants.sSocialProfile,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: getTextMedium(
                          colors: (widget.currentStep >= 1)
                              ? ColorConstants.cSuccess
                              : ColorConstants.cDashboardGradientColor
                              .withOpacity(0.3),
                          size: SizeConstants.s_12,
                        ),
                      ),
                    ),
                    Expanded(
                        child: SizedBox(
                            child: Image.asset(ImageAssets.backArrow,
                                color: (widget.currentStep >= 2)
                                    ? ColorConstants.cSuccess
                                    : ColorConstants.cDashboardGradientColor
                                    .withOpacity(0.3)))),
                    SizedBox(
                      width: SizeConstants.s1 * 120,
                      child: Text(
                        AppConstants.mWordConstants.sHealthAndFitnessProfile,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: getTextMedium(
                          colors: (widget.currentStep >= 2)
                              ? ColorConstants.cSuccess
                              : ColorConstants.cDashboardGradientColor
                              .withOpacity(0.3),
                          size: SizeConstants.s_12,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )
          )
        ],
      ),
    );
  }
}
