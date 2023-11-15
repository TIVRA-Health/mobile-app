import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tivra_health/common/color_constants.dart';
import 'package:tivra_health/common/size_constants.dart';
import 'package:tivra_health/common/text_styles_constants.dart';

editTextFiled(TextEditingController mTextEditingController,
    {bool readOnly = false,
    bool enableSuggestions = true,
    bool obscureText = false,
    int maxLines = 1,
    String labelText = "",
    String hintText = "",
    IconData mIcons = Icons.add,
    Color backGround = Colors.white,
    TextInputType mTextInputType = TextInputType.text, disableColor = ColorConstants.cBlack, textInputAction = TextInputAction.next}) {
  return Container(
      margin: EdgeInsets.only(left: SizeConstants.s3, right: SizeConstants.s3),
      padding: EdgeInsets.only(
          left: SizeConstants.s_15,
          right: SizeConstants.s_15,
          top: SizeConstants.s_10,
          bottom: SizeConstants.s1 * 13),
      decoration: BoxDecoration(
          borderRadius:
              BorderRadius.all(Radius.circular(SizeConstants.s1 * 10)),
          color: backGround,
          border: Border.all(
            color: ColorConstants.cEditTextBorderLightColor,
            width: SizeConstants.s_05,
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
              visible: labelText.isNotEmpty,
              child: Text(
                labelText,
                style: getTextRegular(
                    size: SizeConstants.s_14,
                    colors: Colors.grey.shade500,
                    letterSpacing: 1.0),
              )),
          SizedBox(
            height:
                labelText.isNotEmpty ? SizeConstants.s5 : SizeConstants.s1 * 2,
          ),
          TextField(
              controller: mTextEditingController,
              maxLines: maxLines,
              readOnly: readOnly,
              keyboardType: mTextInputType,
              //textCapitalization: TextCapitalization.words,
              textInputAction: textInputAction,
              textAlignVertical: TextAlignVertical.top,
              obscureText: obscureText,
              enableSuggestions: enableSuggestions,
              autocorrect: false,
              style: getTextMedium(
                  size: SizeConstants.s_16,
                  colors: disableColor,
                  letterSpacing: 0.5),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(0.0),
                filled: true,
                fillColor: Colors.transparent,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintText: hintText,
                alignLabelWithHint: true,
              )),
        ],
      ));
}

editTextMobileNumber(TextEditingController mTextEditingController,
    ValueChanged<String> mCallBackInterface,
    {bool readOnly = false,
    int maxLines = 1,
    String labelText = "",
    String hintText = "",
    IconData mIcons = Icons.add,
    TextInputType mTextInputType = TextInputType.text}) {
  return Container(
      margin: EdgeInsets.only(left: SizeConstants.s3, right: SizeConstants.s3),
      padding: EdgeInsets.only(
          left: SizeConstants.s_15,
          right: SizeConstants.s_15,
          top: SizeConstants.s_12,
          bottom: SizeConstants.s_16),
      decoration: BoxDecoration(
          borderRadius:
              BorderRadius.all(Radius.circular(SizeConstants.s1 * 15)),
          color: Colors.white,
          border: Border.all(
            color: ColorConstants.cEditTextBorderLightColor,
            width: SizeConstants.s_05,
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText,
            style: getTextRegular(
                size: SizeConstants.s_14,
                colors: ColorConstants.cDividerLightColor,
                letterSpacing: 1.0),
          ),
          SizedBox(
            height: SizeConstants.s5,
          ),
          TextField(
            controller: mTextEditingController,
            maxLines: maxLines,
            readOnly: readOnly,
            maxLength: 12,
            keyboardType: TextInputType.phone,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.next,
            textAlignVertical: TextAlignVertical.top,
            style: getTextMedium(
                size: SizeConstants.s_16,
                colors: ColorConstants.cBlack,
                letterSpacing: 0.5),
            autocorrect: false,
            decoration: InputDecoration(
              counter: Offstage(),
              contentPadding: EdgeInsets.all(0.0),
              filled: true,
              fillColor: Colors.transparent,
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              hintText: hintText,
              alignLabelWithHint: true,
              // suffixIcon: Icon(
              //   mIcons,
              //   color: ColorConstants.kPrimaryColor,
              //   size: SizeConstants.s_22,
              // ),
            ),
            onChanged: (text) {
              mCallBackInterface(text);
            },
          ),
        ],
      ));
}

editTextFiledNumber(TextEditingController mTextEditingController,
    ValueChanged<String> mCallBackInterface,
    {bool readOnly = false,
    int maxLines = 1,
    String labelText = "",
    String hintText = "",
    IconData mIcons = Icons.add,
    TextInputType mTextInputType = TextInputType.text}) {
  return Container(
      margin: EdgeInsets.only(left: SizeConstants.s3, right: SizeConstants.s3),
      padding: EdgeInsets.only(
          left: SizeConstants.s_15,
          right: SizeConstants.s_15,
          top: SizeConstants.s_12,
          bottom: SizeConstants.s_16),
      decoration: BoxDecoration(
          borderRadius:
              BorderRadius.all(Radius.circular(SizeConstants.s1 * 15)),
          color: Colors.white,
          border: Border.all(
            color: ColorConstants.cEditTextBorderLightColor,
            width: SizeConstants.s_05,
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText,
            style: getTextRegular(
                size: SizeConstants.s_14,
                colors: ColorConstants.cDividerLightColor,
                letterSpacing: 1.0),
          ),
          SizedBox(
            height: SizeConstants.s5,
          ),
          TextField(
            controller: mTextEditingController,
            maxLines: maxLines,
            readOnly: readOnly,
            keyboardType: TextInputType.phone,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.next,
            textAlignVertical: TextAlignVertical.top,
            style: getTextMedium(
                size: SizeConstants.s_16,
                colors: ColorConstants.cBlack,
                letterSpacing: 0.5),
            autocorrect: false,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(0.0),
              filled: true,
              fillColor: Colors.transparent,
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              hintText: hintText,
              alignLabelWithHint: true,
              // suffixIcon: Icon(
              //   mIcons,
              //   color: ColorConstants.kPrimaryColor,
              //   size: SizeConstants.s_22,
              // ),
            ),
            onChanged: (text) {
              mCallBackInterface(text);
            },
          ),
        ],
      ));
}

editTextFiledClickView(TextEditingController mTextEditingController,
    ValueChanged<String> mCallBackInterface,
    {bool readOnly = false,
    int maxLines = 1,
    String labelText = "",
    String hintText = "",
    IconData mIcons = Icons.add,
    bool suffixIcon = false,
    TextInputType mTextInputType = TextInputType.text}) {
  return GestureDetector(
    onTap: () {
      mCallBackInterface("click");
    },
    child: Container(
        margin:
            EdgeInsets.only(left: SizeConstants.s3, right: SizeConstants.s3),
        padding: EdgeInsets.only(
            left: SizeConstants.s_15,
            right: SizeConstants.s_15,
            top: SizeConstants.s_12,
            bottom: SizeConstants.s_16),
        decoration: BoxDecoration(
            borderRadius:
                BorderRadius.all(Radius.circular(SizeConstants.s1 * 15)),
            color: Colors.white,
            border: Border.all(
              color: ColorConstants.cEditTextBorderLightColor,
              width: SizeConstants.s_05,
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              labelText,
              style: getTextRegular(
                  size: SizeConstants.s_14,
                  colors: ColorConstants.cDividerLightColor,
                  letterSpacing: 1.0),
            ),
            SizedBox(
              height: SizeConstants.s5,
            ),
            TextField(
                onTap: () {
                  mCallBackInterface("click");
                },
                controller: mTextEditingController,
                maxLines: maxLines,
                readOnly: readOnly,
                keyboardType: mTextInputType,
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                textAlignVertical: TextAlignVertical.top,
                style: getTextMedium(
                    size: SizeConstants.s_16,
                    colors: ColorConstants.cBlack,
                    letterSpacing: 0.5),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0.0),
                  filled: true,
                  fillColor: Colors.transparent,
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: hintText,
                  alignLabelWithHint: true,
                )),
          ],
        )),
  );
}

editTextFiledGlobalKeyClickView(TextEditingController mTextEditingController,
    GlobalKey mGlobalKey, ValueChanged<String> mCallBackInterface,
    {bool readOnly = false,
    int maxLines = 1,
    String labelText = "",
    String hintText = "",
    IconData mIcons = Icons.add,
    bool suffixIcon = false,
    TextInputType mTextInputType = TextInputType.text}) {
  return GestureDetector(
      onTap: () {
        mCallBackInterface("click");
      },
      child: Container(
          margin:
              EdgeInsets.only(left: SizeConstants.s3, right: SizeConstants.s3),
          padding: EdgeInsets.only(
              left: SizeConstants.s_15,
              right: SizeConstants.s_15,
              top: SizeConstants.s_12,
              bottom: SizeConstants.s_16),
          decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.all(Radius.circular(SizeConstants.s1 * 15)),
              color: Colors.white,
              border: Border.all(
                color: ColorConstants.cEditTextBorderLightColor,
                width: SizeConstants.s_05,
              )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                labelText,
                style: getTextRegular(
                    size: SizeConstants.s_14,
                    colors: ColorConstants.cDividerLightColor,
                    letterSpacing: 1.0),
              ),
              SizedBox(
                height: SizeConstants.s5,
              ),
              TextField(
                  onTap: () {
                    mCallBackInterface("click");
                  },
                  key: mGlobalKey,
                  controller: mTextEditingController,
                  maxLines: maxLines,
                  readOnly: readOnly,
                  keyboardType: mTextInputType,
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.next,
                  textAlignVertical: TextAlignVertical.top,
                  style: getTextMedium(
                      size: SizeConstants.s_16,
                      colors: ColorConstants.cBlack,
                      letterSpacing: 0.5),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(0.0),
                    filled: true,
                    fillColor: Colors.transparent,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: hintText,
                    alignLabelWithHint: true,
                  )),
            ],
          )));
}

editTextFieldForRow(TextEditingController mTextEditingController,
    {bool readOnly = false,
      bool enableSuggestions = true,
      bool obscureText = false,
      int maxLines = 1,
      String labelText = "",
      String hintText = "",
      IconData mIcons = Icons.add,
      TextInputType mTextInputType = TextInputType.text, color = ColorConstants.cWhite}) {
  return Container(
     /* margin: EdgeInsets.only(left: SizeConstants.s3, right: SizeConstants.s3),
      padding: EdgeInsets.only(
          left: SizeConstants.s_15,
          right: SizeConstants.s_15,
          top: SizeConstants.s_10,
          bottom: SizeConstants.s1*13),*/
      decoration: BoxDecoration(
          borderRadius:
          BorderRadius.all(Radius.circular(SizeConstants.s1 * 10)),
          color: color,
          border: Border.all(
            color: ColorConstants.cEditTextBorderLightColor,
            width: SizeConstants.s_05,
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText,
            style: getTextRegular(
                size: SizeConstants.s_14,
                colors: Colors.grey.shade500,
                letterSpacing: 1.0),
          ),
          SizedBox(
            height: SizeConstants.s5,
          ),
          TextField(
              controller: mTextEditingController,
              maxLines: maxLines,
              readOnly: readOnly,
              keyboardType: mTextInputType,
              textCapitalization: TextCapitalization.words,
              textInputAction: TextInputAction.next,
              textAlignVertical: TextAlignVertical.top,
              obscureText: obscureText,
              enableSuggestions: enableSuggestions,
              autocorrect: false,
              style: getTextMedium(
                  size: SizeConstants.s_16,
                  colors: ColorConstants.cBlack,
                  letterSpacing: 0.5),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.transparent,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintText: hintText,
                alignLabelWithHint: true,
              )),
        ],
      ));
}

setErrorMessage(String errorMessage) {
  return Container(
    alignment: Alignment.centerLeft,
    padding: EdgeInsets.fromLTRB(
        SizeConstants.s_10, 0, SizeConstants.s_10, 0),
    child: Text(
      errorMessage,
      style: getTextRegular(colors: ColorConstants.cRedColor),
    ),
  );
}
