import 'package:flutter/material.dart';
import 'package:tivra_health/common/color_constants.dart';
import 'package:tivra_health/common/size_constants.dart';
import 'package:tivra_health/common/text_styles_constants.dart';

// ignore: must_be_immutable
class TextInputWidget extends StatelessWidget {
  String placeHolder = '';
  late TextEditingController controller;
  String? errorText = '';
  bool? hidePassword = false;
  bool? showFloatingLabel = true;
  bool? isReadOnly = false;
  String? suffixIconType = '';

  TextInputWidget(
      {super.key,
        this.isReadOnly,
        this.suffixIconType,
        required this.placeHolder,
        required this.controller,
        required this.errorText,
         this.hidePassword,
        this.showFloatingLabel});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: ColorConstants.cScaffoldBackgroundColor,
      padding: EdgeInsets.all(SizeConstants.s_05),
      alignment: Alignment.centerLeft,
      child: TextField(
        readOnly: isReadOnly ?? false,
        enableSuggestions: false,
        autocorrect: false,
        controller: controller,
        obscureText: hidePassword ?? false,
        decoration: InputDecoration(
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            labelText: (showFloatingLabel ?? true) ? placeHolder :null,
            hintText: (!(showFloatingLabel ?? true)) ? placeHolder : null,
            hintStyle: getTextRegular(colors: ColorConstants.primaryColor, size: 18.0),
            errorText: errorText,
            labelStyle:
            getTextRegular(colors: ColorConstants.primaryColor, size: 18.0),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(Radius.circular(10)))),
      ),
    );
  }
}

// ignore: must_be_immutable
class TextInputSelectionWidget extends StatelessWidget {
  String placeHolder = '';
  late TextEditingController controller;
  String? errorText = '';
  bool hidePassword = false;
  Function fSquarch;

  TextInputSelectionWidget(
    this.fSquarch, {
    super.key,
    required this.placeHolder,
    required this.controller,
    required this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: () {
        fSquarch();
      },
      enableSuggestions: false,
      readOnly: true,
      autocorrect: false,
      controller: controller,
      decoration: InputDecoration(
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          fillColor: Colors.transparent,
          hintText: placeHolder,
          errorText: errorText,
          hintStyle:
              getTextRegular(colors: ColorConstants.cBlack, size: 18.0),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: ColorConstants.cEditTextBorderLightColor),
              borderRadius: BorderRadius.all(Radius.circular(10)))),
    );
  }
}
