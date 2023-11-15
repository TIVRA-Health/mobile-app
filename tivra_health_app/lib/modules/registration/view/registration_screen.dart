import 'package:flutter/cupertino.dart';
import 'package:tivra_health/common/color_constants.dart';
import 'package:tivra_health/common/image_assets.dart';
import 'package:tivra_health/common/size_constants.dart';
import 'package:tivra_health/common/text_styles_constants.dart';

class RegistrationScreen extends StatefulWidget {
  final int currentStep;

  const RegistrationScreen(this.currentStep, {Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreen();
}

class _RegistrationScreen extends State<RegistrationScreen> {
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
            height: 90,
            child: Column(
              children: [
                SizedBox(height: SizeConstants.s_15,),
                Padding(
                  padding: const EdgeInsets.only(left: 27, right: 27),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorConstants.cDashboardGradientColor
                        ),
                        child: Center(
                          child: Text('1',
                            textAlign: TextAlign.center,
                            style: getTextBold(
                              colors: ColorConstants.cWhite,
                              size: SizeConstants.s_16,
                            ),
                          ),
                        ),
                      ),
                      Expanded(child: SizedBox(height: 6, child: Image.asset(ImageAssets.arrow))),
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: (widget.currentStep >= 1) ? ColorConstants.cDashboardGradientColor : ColorConstants.cDashboardGradientColor.withOpacity(0.3)
                        ),
                        child: Center(
                          child: Text('2',
                            textAlign: TextAlign.center,
                            style: getTextBold(
                              colors: (widget.currentStep >= 1) ? ColorConstants.cWhite : ColorConstants.cDashboardGradientColor,
                              size: SizeConstants.s_16,
                            ),
                          ),
                        ),
                      ),
                      Expanded(child: SizedBox(height: 6, child: Image.asset(ImageAssets.arrow))),
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: (widget.currentStep >= 2) ? ColorConstants.cDashboardGradientColor : ColorConstants.cDashboardGradientColor.withOpacity(0.3),
                        ),
                        child: Center(
                          child: Text('3',
                            textAlign: TextAlign.center,
                            style: getTextBold(
                              colors: (widget.currentStep >= 2) ? ColorConstants.cWhite : ColorConstants.cDashboardGradientColor,
                              size: SizeConstants.s_16,
                            ),
                          ),
                        ),
                      ),
                      Expanded(child: SizedBox(height: 6, child: Image.asset(ImageAssets.arrow))),
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: (widget.currentStep >= 3) ? ColorConstants.cDashboardGradientColor : ColorConstants.cDashboardGradientColor.withOpacity(0.3)
                        ),
                        child: Center(
                          child: Text('4',
                            textAlign: TextAlign.center,
                            style: getTextBold(
                              colors: (widget.currentStep >= 3) ? ColorConstants.cWhite : ColorConstants.cDashboardGradientColor,
                              size: SizeConstants.s_16,
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
                const SizedBox(height: 10,),
                Row(
                  children: [
                    SizedBox(
                      width: SizeConstants.s1*90,
                      child: Text("Create your \naccount",
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: getTextMedium(
                          colors: ColorConstants.cDashboardGradientColor,
                          size: SizeConstants.s_12,
                        ),
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: SizeConstants.s1*90,
                      child: Text("Payment \ndetails",
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: getTextMedium(
                          colors: (widget.currentStep >= 1) ? ColorConstants.cDashboardGradientColor : ColorConstants.cDashboardGradientColor.withOpacity(0.3),
                          size: SizeConstants.s_12,
                        ),
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: SizeConstants.s1*90,
                      child: Text("Create your \nprofile",
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: getTextMedium(
                          colors: (widget.currentStep >= 2) ? ColorConstants.cDashboardGradientColor : ColorConstants.cDashboardGradientColor.withOpacity(0.3),
                          size: SizeConstants.s_12,
                        ),
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: SizeConstants.s1*90,
                      child: Text("Device \nregistration",
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: getTextMedium(
                          colors: (widget.currentStep >= 3) ? ColorConstants.cDashboardGradientColor : ColorConstants.cDashboardGradientColor.withOpacity(0.3),
                          size: SizeConstants.s_12,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ),
        ],
      ),
    );
  }
}
