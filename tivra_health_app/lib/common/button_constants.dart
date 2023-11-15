import 'package:flutter/material.dart';
import 'package:tivra_health/common/color_constants.dart';
import 'package:tivra_health/common/size_constants.dart';
import 'package:tivra_health/common/text_styles_constants.dart';

/// Button -> rectangle rounded corner
// rectangleRoundedCornerButton({
//   @required ValueChanged<String>? appbarActionInterface,
//   @required String? sButtonTitle,
//   double dButtonWidth = 0.0,
//   Color cButtonTextColor = ColorConstants.kPrimaryColor,
//   Color cButtonBackGroundColor = ColorConstants.cWhite,
//   Color cButtonBorderColor = Colors.transparent,
//   double dButtonTextSize = 0.0,
//   double dButtonRadius = 0.0,
// }) {
//   dButtonTextSize =
//       dButtonTextSize == 0.0 ? SizeConstants.s_16 : dButtonTextSize;
//   dButtonWidth = dButtonWidth == 0.0 ? SizeConstants.width * 0.4 : dButtonWidth;
//   dButtonRadius =
//       dButtonRadius == 0.0 ? SizeConstants.s_14 : dButtonRadius;
//   return GestureDetector(
//     onTap: () {
//       appbarActionInterface!(sButtonTitle);
//     },
//     child: Container(
//       alignment: Alignment.center,
//       width: dButtonWidth,
//       padding: EdgeInsets.only(
//         top: SizeConstants.s_12,
//         bottom: SizeConstants.s_12,
//       ),
//       decoration: BoxDecoration(
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.3),
//             spreadRadius: 1,
//             blurRadius: 3,
//             offset: const Offset(0, 1), // changes position of shadow
//           ),
//         ],
//         color: cButtonBackGroundColor,
//         borderRadius: BorderRadius.all(Radius.circular(dButtonRadius)),
//         border: Border.all(
//             color: cButtonBorderColor, width: SizeConstants.width * 0.023 / 8),
//       ),
//       child: Text(
//         sButtonTitle!,
//         style: getTextRegular(colors: cButtonTextColor, size: dButtonTextSize),
//       ),
//     ),
//   );
// }
//
// mediumRoundedCornerButton({
//   @required ValueChanged<String>? appbarActionInterface,
//   @required String? sButtonTitle,
//   double dButtonWidth = 0.0,
//   Color cButtonTextColor = ColorConstants.kPrimaryColor,
//   Color cButtonBackGroundColor = ColorConstants.cWhite,
//   Color cButtonBorderColor = Colors.transparent,
//   bool cBoxShadow = false,
//   double dButtonTextSize = 0.0,
//   double dButtonRadius = 0.0,
// }) {
//   dButtonTextSize =
//   dButtonTextSize == 0.0 ? SizeConstants.s_16 : dButtonTextSize;
//   dButtonWidth = dButtonWidth == 0.0 ? SizeConstants.width * 0.4 : dButtonWidth;
//   dButtonRadius =
//   dButtonRadius == 0.0 ? SizeConstants.width * 0.023 : dButtonRadius;
//   return GestureDetector(
//     onTap: () {
//       appbarActionInterface!(sButtonTitle);
//     },
//     child: Container(
//       alignment: Alignment.center,
//       width: dButtonWidth,
//       padding: EdgeInsets.only(
//         top: SizeConstants.s_10,
//         bottom: SizeConstants.s_10,
//       ),
//       decoration: BoxDecoration(
//         // boxShadow: [
//         //   BoxShadow(
//         //     color: cBoxShadow?Colors.transparent:Colors.grey.withOpacity(0.3),
//         //     spreadRadius: 1,
//         //     blurRadius: 3,
//         //     offset: const Offset(0, 1), // changes position of shadow
//         //   ),
//         // ],
//         color: cButtonBackGroundColor,
//         borderRadius: BorderRadius.all(Radius.circular(dButtonRadius)),
//         border: Border.all(
//             color: cButtonBorderColor, width: SizeConstants.width * 0.023 / 8),
//       ),
//       child: Text(
//         sButtonTitle!,
//         style: getTextMedium(colors: cButtonTextColor, size: dButtonTextSize),
//       ),
//     ),
//   );
//
//
// }

rectangleRoundedCornerButton(String sTitle,Function onClick,{
  Color bgColor = ColorConstants.cSideMenuSelectText,
  Color textColor = ColorConstants.cWhite,
}){
  return GestureDetector(
    onTap: (){
      onClick();
    },
    child: Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius:
          BorderRadius.circular(SizeConstants.s1 * 5),
          color: bgColor),
      child: Text(
        sTitle,
        style: getTextRegular(size: SizeConstants.s1 * 17,
        colors: textColor),
        textAlign: TextAlign.center,
      ),
    ),
  );
}

rectangleRoundedCornerMediumButton(String sTitle,Function onClick){
  return GestureDetector(
    onTap: (){
      onClick();
    },
    child: Container(
      // width: SizeConstants.width * 0.55,
      // height: SizeConstants.s1 *45,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius:
          BorderRadius.circular(SizeConstants.s1 * 5),
          color: ColorConstants.cSideMenuSelectText),
      child: Text(
        sTitle,
        style: getTextMedium(size: SizeConstants.s1 * 17),
        textAlign: TextAlign.center,
      ),
    ),
  );
}

rectangleRoundedCornerSemiBoldButton(String sTitle,Function onClick){
  return GestureDetector(
    onTap: (){
      onClick();
    },
    child: Container(
      // width: SizeConstants.width * 0.55,
      // height: SizeConstants.s1 *45,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius:
          BorderRadius.circular(SizeConstants.s1 * 5),
          color: ColorConstants.cSideMenuSelectText),
      child: Text(
        sTitle,
        style: getTextSemiBold(size: SizeConstants.s1 * 17),
        textAlign: TextAlign.center,
      ),
    ),
  );
}

rectangleRoundedCornerGreyButton(String sTitle,Function onClick){
  return GestureDetector(
    onTap: (){
      onClick();
    },
    child: Container(
      // width: SizeConstants.width * 0.55,
      // height: SizeConstants.s1 *45,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius:
          BorderRadius.circular(SizeConstants.s1 * 5),
          color: ColorConstants.cScaffoldBackgroundColor),
      child: Text(
        sTitle,
        style: getTextRegular(size: SizeConstants.s1 * 17, colors: ColorConstants.cRedColor),
        textAlign: TextAlign.center,
      ),
    ),
  );
}
