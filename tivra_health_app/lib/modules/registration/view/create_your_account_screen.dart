import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tivra_health/common/alert/app_alert.dart';
import 'package:tivra_health/common/app_constants.dart';
import 'package:tivra_health/common/button_constants.dart';
import 'package:tivra_health/common/color_constants.dart';
import 'package:tivra_health/common/image_assets.dart';
import 'package:tivra_health/common/size_constants.dart';
import 'package:tivra_health/common/text_styles_constants.dart';
import 'package:tivra_health/common/widget/edit_text_field.dart';
import 'package:tivra_health/data/all_bloc/create_account/bloc/tivra_health_create_account_bloc.dart';
import 'package:tivra_health/data/all_bloc/create_account/bloc/tivra_health_create_account_state.dart';
import 'package:tivra_health/data/all_bloc/request_otp/bloc/tivra_health_register_screen_otp_bloc.dart';
import 'package:tivra_health/data/all_bloc/request_otp/bloc/tivra_health_register_screen_otp_state.dart';
import 'package:tivra_health/data/all_bloc/tivra_health_registration/bloc/tivra_health_register_screen_bloc.dart';
import 'package:tivra_health/data/all_bloc/tivra_health_registration/bloc/tivra_health_register_screen_state.dart';
import 'package:tivra_health/data/all_bloc/verify_otp/bloc/tivra_health_register_screen_verify_otp_bloc.dart';
import 'package:tivra_health/data/all_bloc/verify_otp/bloc/tivra_health_register_screen_verify_otp_state.dart';
import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';
import 'package:tivra_health/modules/registration/model/create_your_account_model.dart';

class CreateYourAccountScreen extends StatefulWidget {
  final Function(bool, int) refreshPage;

  const CreateYourAccountScreen(this.refreshPage, {Key? key}) : super(key: key);

  @override
  State<CreateYourAccountScreen> createState() => _CreateYourAccountScreen();
}

class _CreateYourAccountScreen extends State<CreateYourAccountScreen> {
  late CreateYourAccountModel mCreateYourAccountModel;
  String filePath = "";

  @override
  void initState() {
    super.initState();
    mCreateYourAccountModel = CreateYourAccountModel(context);
    mCreateYourAccountModel.setTivraHealthRegisterScreenBloc();
    setFirstLaunch();
  }

  setFirstLaunch() async {
    await SharedPrefs().setFirstLaunch("true");
  }

  bool _validateInitialFields() {
    setState(() {
      mCreateYourAccountModel.validateAllRequiredInitialFields();
    });
    if (!mCreateYourAccountModel.emailValidator &&
        !mCreateYourAccountModel.firstNameValidator &&
        !mCreateYourAccountModel.lastNameValidator &&
        !mCreateYourAccountModel.mobileNumberValidator) {
      return true;
    }
    return false;
  }

  bool _validateOTP() {
    setState(() {
      mCreateYourAccountModel.validateOTPField();
    });
    if (!mCreateYourAccountModel.otpValidator) {
      return true;
    }
    return false;
  }

  bool _validatePassword() {
    setState(() {
      mCreateYourAccountModel.validatePasswordFields();
    });
    if (!mCreateYourAccountModel.pwdValidator &&
        !mCreateYourAccountModel.confirmPwdValidator) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(child: _buildUI(), listeners: [
      BlocListener<TivraHealthRegisterScreenBloc, TivraHealthRegisterScreenState>(
        bloc: mCreateYourAccountModel.getTivraHealthRegisterScreenBloc(),
        listener: (context, state) {
          blocTivraHealthRegisterScreenListener(
              context, state);
        },
      ),
      BlocListener<TivraHealthRegisterScreenOTPBloc, TivraHealthRegisterScreenOTPState>(
        bloc: mCreateYourAccountModel.getTivraHealthRegisterScreenOTPBloc(),
        listener: (context, state) {
          blocTivraHealthRegisterScreenOTPListener(
              context, state);
        },
      ),
      BlocListener<TivraHealthRegisterScreenVerifyOTPBloc, TivraHealthRegisterScreenVerifyOTPState>(
        bloc: mCreateYourAccountModel.getHealthRegisterScreenVerifyOTPBloc(),
        listener: (context, state) {
          blocTivraHealthRegisterScreenVerifyOTPListener(
              context, state);
        },
      ),
      BlocListener<TivraHealthCreateAccountBloc, TivraHealthCreateAccountState>(
        bloc: mCreateYourAccountModel.getTivraHealthCreateAccountBloc(),
        listener: (context, state) {
          blocTivraHealthCreateAccountListener(
              context, state);
        },
      ),
    ]);
  }

  _buildUI() {
    return SingleChildScrollView(
      child: Container(
        padding:
        EdgeInsets.fromLTRB(SizeConstants.s_10, 0, SizeConstants.s_10, 0),
        child: Column(
          children: [
            Text(
              AppConstants.mWordConstants.sCreateYourAccount,
              style: getTextMedium(
                  colors: ColorConstants.cBlack, size: SizeConstants.s1 * 20),
            ),
            SizedBox(
              height: SizeConstants.s_20,
            ),
            GestureDetector(
              onTap: () {
                pickImage();
              },
              child: Container(
                height: 120,
                width: 120,
                color: ColorConstants.cWhite,
                child: CircleAvatar(
                  radius: 200,
                  backgroundColor: ColorConstants.cWhite,
                  backgroundImage: AssetImage(ImageAssets.profileIcon),
                  foregroundImage: FileImage(File(filePath)),
                ),
              ),
            ),
            SizedBox(
              height: SizeConstants.s_20,
            ),
            editTextFiled(
              mCreateYourAccountModel.mFirstNameController,
              labelText: AppConstants.mWordConstants.sFirstName,
              hintText: AppConstants.mWordConstants.sFirstName,
              backGround: ColorConstants.cScaffoldBackgroundColor,
            ),
            if (mCreateYourAccountModel.firstNameValidator)
              setErrorMessage(AppConstants.mWordConstants.sFirstNameError),
            SizedBox(
              height: SizeConstants.s_20,
            ),
            editTextFiled(mCreateYourAccountModel.mMiddleNameController,
                labelText: AppConstants.mWordConstants.sMiddleName,
                hintText: AppConstants.mWordConstants.sMiddleName,
                backGround: ColorConstants.cScaffoldBackgroundColor),
            SizedBox(
              height: SizeConstants.s_20,
            ),
            editTextFiled(mCreateYourAccountModel.mLastNameController,
                labelText: AppConstants.mWordConstants.sLastName,
                hintText: AppConstants.mWordConstants.sLastName,
                backGround: ColorConstants.cScaffoldBackgroundColor),
            if (mCreateYourAccountModel.lastNameValidator)
              setErrorMessage(AppConstants.mWordConstants.sLastNameError),
            SizedBox(
              height: SizeConstants.s_20,
            ),
            editTextFiled(mCreateYourAccountModel.mEmailController,
                labelText: AppConstants.mWordConstants.sEmailHint,
                hintText: AppConstants.mWordConstants.sEmailHint,
                backGround: ColorConstants.cScaffoldBackgroundColor,
                mTextInputType: TextInputType.emailAddress,
                readOnly: mCreateYourAccountModel.disableEmail,
                disableColor: mCreateYourAccountModel.disableEmail
                    ? ColorConstants.cBlack.withOpacity(0.3)
                    : ColorConstants.cBlack),
            if (mCreateYourAccountModel.emailValidator)
              setErrorMessage(AppConstants.mWordConstants.sEmailError),
            SizedBox(
              height: SizeConstants.s_20,
            ),
            editTextFiled(mCreateYourAccountModel.mPhoneNumberController,
                labelText: AppConstants.mWordConstants.sMobileNumberHint,
                hintText: AppConstants.mWordConstants.sMobileNumberHint,
                backGround: ColorConstants.cScaffoldBackgroundColor,
                mTextInputType: TextInputType.number,
                textInputAction: TextInputAction.done),
            if (mCreateYourAccountModel.mobileNumberValidator)
              setErrorMessage(AppConstants.mWordConstants.sMobileError),
            SizedBox(
              height: SizeConstants.s_20,
            ),
            if (mCreateYourAccountModel.initialFieldsContinue)
              Container(
                  height: SizeConstants.s1 * 43,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(
                    left: SizeConstants.s1 * 5,
                    right: SizeConstants.s1 * 5,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(SizeConstants.s1 * 5),
                      color: ColorConstants.cSideMenuSelectText),
                  child: rectangleRoundedCornerButton(
                      AppConstants.mWordConstants.sContinue, () {
                    if (_validateInitialFields()) {
                      mCreateYourAccountModel
                          .fetchTivraHealthRegisterScreenUrl();
                      setState(() {
                        mCreateYourAccountModel.initialFieldsContinue = false;
                        mCreateYourAccountModel.continueToOTP = true;
                        mCreateYourAccountModel.disableEmail = true;
                      });
                    }
                  })),
            if (mCreateYourAccountModel.initialFieldsContinue)
              SizedBox(
                height: SizeConstants.s_20,
              ),
            if (mCreateYourAccountModel.initialFieldsContinue)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppConstants.mWordConstants.sAlreadyHadAnAccount,
                    style: getTextRegular(
                        colors: ColorConstants.cBlack,
                        size: SizeConstants.s_16),
                  ),
                  SizedBox(
                    width: SizeConstants.s_10,
                  ),
                  Text(
                    AppConstants.mWordConstants.sSignIn,
                    style: getTextRegular(
                        colors: ColorConstants.cRedColor,
                        size: SizeConstants.s_16),
                  ),
                ],
              ),
            if (mCreateYourAccountModel.initialFieldsContinue)
              SizedBox(
                height: SizeConstants.s_20,
              ),
            if (mCreateYourAccountModel.continueToOTP)
              Container(
                padding: EdgeInsets.fromLTRB(
                    SizeConstants.s_10, 0, SizeConstants.s_10, 0),
                child: Text(
                  AppConstants.mWordConstants.sVerificationMessage,
                  style: getTextRegular(colors: ColorConstants.cBlack),
                ),
              ),
            if (mCreateYourAccountModel.continueToOTP)
              SizedBox(
                height: SizeConstants.s_20,
              ),
            if (mCreateYourAccountModel.continueToOTP)
              Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.fromLTRB(
                      SizeConstants.s_10, 0, SizeConstants.s_10, 0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        mCreateYourAccountModel.disableEmail = false;
                        mCreateYourAccountModel.continueToOTP = false;
                        mCreateYourAccountModel.initialFieldsContinue = true;
                      });
                    },
                    child: Text(
                      AppConstants.mWordConstants.sChangeEmail,
                      style: getTextRegular(colors: ColorConstants.cRedColor),
                    ),
                  )),
            if (mCreateYourAccountModel.continueToOTP)
              SizedBox(
                height: SizeConstants.s_20,
              ),
            if (mCreateYourAccountModel.continueToOTP)
              editTextFiled(mCreateYourAccountModel.mOTPController,
                  labelText: AppConstants.mWordConstants.sOTP,
                  hintText: AppConstants.mWordConstants.sOTP,
                  backGround: ColorConstants.cScaffoldBackgroundColor,
                  mTextInputType: TextInputType.text,
                  textInputAction: TextInputAction.done),
            if (mCreateYourAccountModel.otpValidator)
              setErrorMessage(AppConstants.mWordConstants.sOTPError),
            if (mCreateYourAccountModel.continueToOTP)
              SizedBox(
                height: SizeConstants.s_20,
              ),
            if (mCreateYourAccountModel.continueToOTP &&
                mCreateYourAccountModel.disableVerifyBtn)
              Container(
                  height: SizeConstants.s1 * 43,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(
                    left: SizeConstants.s1 * 5,
                    right: SizeConstants.s1 * 5,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(SizeConstants.s1 * 5),
                      color: ColorConstants.cSideMenuSelectText),
                  child: rectangleRoundedCornerButton(
                      AppConstants.mWordConstants.sVerify, () {
                    setState(() {
                      if (_validateOTP() && _validateInitialFields()) {
                        mCreateYourAccountModel.verifiedOTP = true;
                        mCreateYourAccountModel.disableVerifyBtn = false;
                        mCreateYourAccountModel
                            .tivraHealthRegisterScreenVerifyOTP();
                      }
                    });
                  })),
            if (mCreateYourAccountModel.continueToOTP &&
                mCreateYourAccountModel.disableVerifyBtn)
              SizedBox(
                height: SizeConstants.s_20,
              ),
            if (mCreateYourAccountModel.verifiedOTP)
              editTextFiled(mCreateYourAccountModel.mPasswordController,
                  labelText: AppConstants.mWordConstants.sPassword,
                  hintText: AppConstants.mWordConstants.sPassword,
                  backGround: ColorConstants.cScaffoldBackgroundColor,
                  obscureText: true),
            if (mCreateYourAccountModel.pwdValidator)
              setErrorMessage(AppConstants.mWordConstants.sPwdError),
            if (mCreateYourAccountModel.verifiedOTP)
              SizedBox(
                height: SizeConstants.s_20,
              ),
            if (mCreateYourAccountModel.verifiedOTP)
              editTextFiled(mCreateYourAccountModel.mConfirmPasswordController,
                  labelText: AppConstants.mWordConstants.sConfirmPassword,
                  hintText: AppConstants.mWordConstants.sConfirmPassword,
                  backGround: ColorConstants.cScaffoldBackgroundColor,
                  obscureText: true,
                  textInputAction: TextInputAction.done),
            if (mCreateYourAccountModel.confirmPwdValidator)
              setErrorMessage(AppConstants.mWordConstants.sConfirmPwdError),
            if (mCreateYourAccountModel.verifiedOTP)
              SizedBox(
                height: SizeConstants.s_20,
              ),
            if (mCreateYourAccountModel.verifiedOTP)
              Container(
                  height: SizeConstants.s1 * 43,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(
                    left: SizeConstants.s1 * 5,
                    right: SizeConstants.s1 * 5,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(SizeConstants.s1 * 5),
                      color: ColorConstants.cSideMenuSelectText),
                  child: rectangleRoundedCornerButton(
                      AppConstants.mWordConstants.sCreateYourAccount, () {
                    if (_validatePassword() &&
                        _validatePassword() &&
                        _validateInitialFields()) {
                      mCreateYourAccountModel.tivraHealthCreateAccount();
                    }
                  })),
            if (mCreateYourAccountModel.verifiedOTP)
              SizedBox(
                height: SizeConstants.s_20,
              ),
          ],
        ),
      ),
    );
  }

  pickImage() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(allowMultiple: false, type: FileType.image);
    //print("Image picker result == $result");
    setState(() {
      filePath = result?.files.single.path ?? "";
    });
  }

  blocTivraHealthCreateAccountListener(
      BuildContext context, TivraHealthCreateAccountState state) {
    switch (state.status) {
      case TivraHealthCreateAccountStatus.loading:
        AppAlert.showProgressDialog(context);
        break;
      case TivraHealthCreateAccountStatus.failed:
        AppAlert.closeDialog(context);
        AppAlert.showSnackBar(
            context, state.webResponseFailed?.statusMessage ?? "");
        break;
      case TivraHealthCreateAccountStatus.success:
        AppAlert.closeDialog(context);
        widget.refreshPage(true, 1);
        break;
    }
  }

  blocTivraHealthRegisterScreenListener(
      BuildContext context, TivraHealthRegisterScreenState state) {
    switch (state.status) {
      case TivraHealthRegisterScreenStatus.loading:
        AppAlert.showProgressDialog(context);
        break;
      case TivraHealthRegisterScreenStatus.failed:
        AppAlert.closeDialog(context);
        AppAlert.showSnackBar(
            context, state.webResponseFailed?.statusMessage ?? "");
        break;
      case TivraHealthRegisterScreenStatus.success:
        AppAlert.closeDialog(context);
        mCreateYourAccountModel
            .tivraHealthRegisterScreenSendOTP();
        // widget.refreshPage(true, 1);
        break;
    }
  }

  blocTivraHealthRegisterScreenOTPListener(
      BuildContext context, TivraHealthRegisterScreenOTPState state) {
    switch (state.status) {
      case TivraHealthRegisterScreenOTPStatus.loading:
        AppAlert.showProgressDialog(context);
        break;
      case TivraHealthRegisterScreenOTPStatus.failed:
        AppAlert.closeDialog(context);
        AppAlert.showSnackBar(
            context, state.webResponseFailed?.statusMessage ?? "");
        break;
      case TivraHealthRegisterScreenOTPStatus.success:
        AppAlert.closeDialog(context);
        // widget.refreshPage(true, 1);
        break;
    }
  }

  blocTivraHealthRegisterScreenVerifyOTPListener(
      BuildContext context, TivraHealthRegisterScreenVerifyOTPState state) {
    switch (state.status) {
      case TivraHealthRegisterScreenVerifyOTPStatus.loading:
        AppAlert.showProgressDialog(context);
        break;
      case TivraHealthRegisterScreenVerifyOTPStatus.failed:
        AppAlert.closeDialog(context);
        AppAlert.showSnackBar(
            context, state.webResponseFailed?.statusMessage ?? "");
        break;
      case TivraHealthRegisterScreenVerifyOTPStatus.success:
        AppAlert.closeDialog(context);
        // widget.refreshPage(true, 1);
        break;
    }
  }
}
