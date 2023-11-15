import 'package:flutter/material.dart';
import 'package:tivra_health/common/color_constants.dart';
import 'package:tivra_health/common/size_constants.dart';
import 'package:tivra_health/common/text_styles_constants.dart';

topViewShow(String image, String title, String subTitle, {double sType = 0.0}) {
  return Expanded(
      child: Container(
    margin: EdgeInsets.all(SizeConstants.s1 * 5),
    padding: EdgeInsets.only(left: SizeConstants.s1 * 5),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SizeConstants.s1 * 5),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            ColorConstants.cDashboardGradientColor,
            ColorConstants.cLightDashboardGradientColor,
          ],
        )),
    child: Row(
      children: [
        SizedBox(
          height: SizeConstants.s1 * 70,
          width: SizeConstants.s1 * 3,
        ),
        SizedBox(
          height: SizeConstants.s1 * 33,
          width: SizeConstants.s1 * 33,
          child: Image.asset(image, fit: BoxFit.contain),
        ),
        SizedBox(
          height: SizeConstants.s1 * 70,
          width: SizeConstants.s1 * 8,
        ),
        Container(
          height: SizeConstants.s1 * 50,
          width: SizeConstants.s1 * 50,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                  color: (sType == 0.0) ? Colors.transparent : Colors.white,
                  width: SizeConstants.s1 * 2)),
          child: Stack(
            children: [
              Container(
                height: SizeConstants.s1 * 55,
                width: SizeConstants.s1 * 55,
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: getTextMedium(
                        colors: Colors.white,
                        size: sType == 0.0
                            ? SizeConstants.s1 * 15
                            : SizeConstants.s1 * 12,
                      ),
                    ),
                    Text(
                      subTitle,
                      textAlign: TextAlign.center,
                      style: getTextRegular(
                        colors: Colors.white,
                        size: sType == 0.0
                            ? SizeConstants.s1 * 11
                            : SizeConstants.s1 * 9,
                      ),
                    ),
                  ],
                ),
              ),
              (sType == 0.0)
                  ? SizedBox()
                  : SizedBox(
                      height: SizeConstants.s1 * 55,
                      width: SizeConstants.s1 * 55,
                      child: CircularProgressIndicator(
                        value: sType,
                        color: Colors.white,
                        strokeAlign: 1,
                        strokeWidth: SizeConstants.s1 * 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                            ColorConstants.cSideMenuSelectText),
                      ),
                    )
            ],
          ),
        ),
      ],
    ),
  ));
}

middleView(
    String title, String sSelectValue, Function returnValue, Color colorValue) {
  return Expanded(
      child: GestureDetector(
    onTap: () {
      returnValue(title);
    },
    child: Container(
      margin: EdgeInsets.all(SizeConstants.s1 * 6),
      padding: EdgeInsets.only(
          top: SizeConstants.s1 * 10, bottom: SizeConstants.s1 * 10),
      decoration: BoxDecoration(
          color: sSelectValue == title
              ? ColorConstants.cSideMenuSelectText
              : colorValue,
          borderRadius:
              BorderRadius.all(Radius.circular(SizeConstants.s1 * 20))),
      alignment: Alignment.center,
      child: Text(
        title,
        style: getTextMedium(
          colors:
              sSelectValue == title ? Colors.white : ColorConstants.cGrayText,
          size: SizeConstants.s1 * 16,
        ),
      ),
    ),
  ));
}

dashboardTextView(String title, String image, String sNumber,
    {String subTest = ""}) {
  return Expanded(
      child: Container(
    height: SizeConstants.width * 0.33,
    margin: EdgeInsets.all(SizeConstants.s1 * 6),
    padding: EdgeInsets.all(SizeConstants.s1 * 10),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SizeConstants.s1 * 5),
        color: Colors.white),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: SizeConstants.s1 * 35,
              width: SizeConstants.s1 * 35,
              child: Image.asset(
                image,
              ),
            ),
            SizedBox(
              width: SizeConstants.s1 * 15,
            ),
            Text(
              title,
              style: getTextRegular(
                colors: ColorConstants.cDashboardGradientColor,
                size: SizeConstants.s1 * 18,
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              sNumber,
              style: getTextMedium(
                colors: Colors.black,
                size: SizeConstants.s1 * 33,
              ),
            ),
            Text(
              subTest,
              style: getTextLight(
                colors: Colors.grey.shade500,
                size: SizeConstants.s1 * 18,
              ),
            ),
          ],
        )
      ],
    ),
  ));
}

dashboardTextSideView(String title, String image, String sNumber,
    {String subTest = ""}) {
  return Expanded(
      child: Container(
    height: SizeConstants.width * 0.33,
    margin: EdgeInsets.all(SizeConstants.s1 * 6),
    padding: EdgeInsets.all(SizeConstants.s1 * 10),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SizeConstants.s1 * 5),
        color: Colors.white),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: SizeConstants.s1 * 35,
              width: SizeConstants.s1 * 35,
              child: Image.asset(
                image,
              ),
            ),
            SizedBox(
              width: SizeConstants.s1 * 15,
            ),
            Text(
              title,
              style: getTextRegular(
                colors: ColorConstants.cDashboardGradientColor,
                size: SizeConstants.s1 * 18,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              sNumber,
              style: getTextMedium(
                colors: Colors.black,
                size: SizeConstants.s1 * 33,
              ),
            ),
            Text(
              " $subTest",
              style: getTextLight(
                colors: Colors.grey.shade600,
                size: SizeConstants.s1 * 18,
              ),
            ),
          ],
        ),
        SizedBox(
          height: SizeConstants.s1 * 5,
        )
      ],
    ),
  ));
}

dashboardTextCenterView(String title, String image, String sNumber) {
  return Expanded(
      child: Container(
    height: SizeConstants.width * 0.33,
    margin: EdgeInsets.all(SizeConstants.s1 * 6),
    padding: EdgeInsets.all(SizeConstants.s1 * 10),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SizeConstants.s1 * 5),
        color: Colors.white),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: SizeConstants.s1 * 35,
              width: SizeConstants.s1 * 35,
              child: Image.asset(
                image,
              ),
            ),
            SizedBox(
              width: SizeConstants.s1 * 15,
            ),
            Text(
              title,
              style: getTextRegular(
                colors: ColorConstants.cDashboardGradientColor,
                size: SizeConstants.s1 * 18,
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              sNumber,
              style: getTextMedium(
                colors: Colors.black,
                size: SizeConstants.s1 * 33,
              ),
            ),
            Text(
              "",
              style: getTextLight(
                colors: Colors.grey.shade500,
                size: SizeConstants.s1 * 5,
              ),
            ),
          ],
        )
      ],
    ),
  ));
}

dashboardTextProgressView(
    String title, String image, String sNumber, double value,
    {String subTest = ""}) {
  return Expanded(
      child: Container(
    height: SizeConstants.width * 0.33,
    margin: EdgeInsets.all(SizeConstants.s1 * 6),
    padding: EdgeInsets.all(SizeConstants.s1 * 10),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SizeConstants.s1 * 5),
        color: Colors.white),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: SizeConstants.s1 * 35,
              width: SizeConstants.s1 * 35,
              child: Image.asset(
                image,
              ),
            ),
            SizedBox(
              width: SizeConstants.s1 * 10,
            ),
            Text(
              title,
              style: getTextRegular(
                colors: ColorConstants.cDashboardGradientColor,
                size: SizeConstants.s1 * 18,
              ),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.only(bottom: SizeConstants.s1 * 5),
          height: SizeConstants.s1 * 50,
          width: SizeConstants.s1 * 50,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                  color: Colors.grey.shade400, width: SizeConstants.s1 * 2)),
          child: Stack(
            children: [
              Container(
                height: SizeConstants.s1 * 50,
                width: SizeConstants.s1 * 50,
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      sNumber,
                      style: getTextMedium(
                        colors: Colors.black,
                        size: SizeConstants.s1 * 16,
                      ),
                    ),
                    subTest.isEmpty
                        ? SizedBox()
                        : Text(
                            subTest,
                            style: getTextLight(
                              colors: Colors.grey.shade700,
                              size: SizeConstants.s1 * 11,
                            ),
                          ),
                  ],
                ),
              ),
              SizedBox(
                height: SizeConstants.s1 * 50,
                width: SizeConstants.s1 * 50,
                child: CircularProgressIndicator(
                  value: value,
                  color: Colors.white,
                  strokeAlign: 1,
                  strokeWidth: SizeConstants.s1 * 3,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                      ColorConstants.cSideMenuSelectText),
                ),
              )
            ],
          ),
        ),
      ],
    ),
  ));
}

dashboardGreenTextCenterView(String title, String image, String sNumber) {
  return Expanded(
      child: Container(
    height: SizeConstants.width * 0.33,
    margin: EdgeInsets.all(SizeConstants.s1 * 6),
    padding: EdgeInsets.all(SizeConstants.s1 * 10),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SizeConstants.s1 * 5),
        color: Colors.white),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: SizeConstants.s1 * 35,
              width: SizeConstants.s1 * 35,
              child: Image.asset(
                image,
              ),
            ),
            SizedBox(
              width: SizeConstants.s1 * 15,
            ),
            Text(
              title,
              style: getTextRegular(
                colors: ColorConstants.cDashboardGradientColor,
                size: SizeConstants.s1 * 18,
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              sNumber,
              style: getTextMedium(
                colors: ColorConstants.cLightDashboardGreenTextColor,
                size: SizeConstants.s1 * 22,
              ),
            ),
            Text(
              "",
              style: getTextLight(
                colors: Colors.grey.shade500,
                size: SizeConstants.s1 * 15,
              ),
            ),
          ],
        )
      ],
    ),
  ));
}

myConnectButtonView(
    String title, Color colorValue, Color colorBorder, Function returnValue) {
  return GestureDetector(
    onTap: () {
      returnValue(title);
    },
    child: Container(
      padding: EdgeInsets.only(
          top: SizeConstants.s1 * 6,
          bottom: SizeConstants.s1 * 6,
          left: SizeConstants.s1 * 18,
          right: SizeConstants.s1 * 18),
      decoration: BoxDecoration(
          color: colorValue,
          border: Border.all(width: SizeConstants.s1, color: colorBorder),
          borderRadius:
              BorderRadius.all(Radius.circular(SizeConstants.s1 * 20))),
      alignment: Alignment.center,
      child: Text(
        title,
        style: getTextRegular(
          colors: colorBorder,
          size: SizeConstants.s1 * 16,
        ),
      ),
    ),
  );
}
