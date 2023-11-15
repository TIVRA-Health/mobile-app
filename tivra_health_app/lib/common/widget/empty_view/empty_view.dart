
import 'package:flutter/material.dart';
import 'package:tivra_health/common/size_constants.dart';
import 'package:tivra_health/common/text_styles_constants.dart';

emptyView(double minHeight ,String image,String title){
return Container(
  constraints: BoxConstraints(
    minHeight: minHeight,
  ),
  alignment: Alignment.center,
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Image.asset(
        image,
        height: SizeConstants.s1 * 110,
        fit: BoxFit.fitHeight,
      ),
      SizedBox(
        height: SizeConstants.s1 * 15,
      ),
      Text(
        title,
        textAlign: TextAlign.center,
        style: getTextRegular(
            size: SizeConstants.s1 * 16,
            colors: Colors.grey),
      ),
    ],
  ),
);
}