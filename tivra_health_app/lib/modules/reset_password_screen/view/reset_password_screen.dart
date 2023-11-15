import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:tivra_health/common/alert/app_alert.dart';
import 'package:tivra_health/common/app_constants.dart';
import 'package:tivra_health/common/appbars_constants.dart';
import 'package:tivra_health/common/button_constants.dart';
import 'package:tivra_health/common/color_constants.dart';
import 'package:tivra_health/common/image_assets.dart';
import 'package:tivra_health/common/size_constants.dart';
import 'package:tivra_health/common/text_styles_constants.dart';
import 'package:tivra_health/common/widget/edit_text_field.dart';
import 'package:tivra_health/data/all_bloc/reset_password/bloc/reset_password_bloc.dart';
import 'package:tivra_health/data/all_bloc/reset_password/bloc/reset_password_state.dart';
import 'package:tivra_health/modules/reset_password_screen/model/reset_password_screen_model.dart';

import '../../../routes/route_constants.dart';

class ResetPasswordScreenWidget extends StatefulWidget {
  final String email;
  const ResetPasswordScreenWidget({super.key, required this.email});

  @override
  State<ResetPasswordScreenWidget> createState() => _ResetPasswordScreenWidgetState();
}

class _ResetPasswordScreenWidgetState extends State<ResetPasswordScreenWidget> {
  late ResetPasswordScreenModel mResetPasswordScreenModel;

  @override
  void initState() {
    mResetPasswordScreenModel = ResetPasswordScreenModel(context);
    mResetPasswordScreenModel.setTivraHealthRegisterScreenBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBars.appNoBar(), body: MultiBlocListener(child: _buildLoginView(), listeners: [
      BlocListener<ResetPasswordBloc, ResetPasswordState>(
        bloc: mResetPasswordScreenModel.getResetPasswordBloc(),
        listener: (context, state) {
          blocResetPasswordListener(
              context, state);
        },
      ),
      ]));
  }

  _buildLoginView() {
    return FocusDetector(
        onVisibilityGained: () {},
        child: SafeArea(
            child: Stack(
          children: [
            Container(
                alignment: Alignment.center,
                child: SizedBox(
                  height: SizeConstants.height,
                  width: SizeConstants.width,
                  child: Image.asset(ImageAssets.splashBg, fit: BoxFit.cover),
                )),
            Container(
                alignment: Alignment.center,
                child: SizedBox(
                  height: SizeConstants.height,
                  width: SizeConstants.width,
                  child: Image.asset(ImageAssets.splashBg1, fit: BoxFit.cover),
                )),

            Align(
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: SizeConstants.s1 * 64,
                      ),
                      SizedBox(
                        height: SizeConstants.s1 * 110,
                        child: Image.asset(ImageAssets.splashLogo,
                            fit: BoxFit.fitWidth),
                      ),

                      ///resetPasswordView
                      resetPasswordView(),

                      ///bottomView
                      bottomView(),
                      SizedBox(
                        height: SizeConstants.s1 * 32,
                      ),
                    ],
                  ),
                )),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                  height: SizeConstants.s_64,
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                        color: Colors.transparent,
                        padding: EdgeInsets.only(
                            left: SizeConstants.s1 * 15,
                            right: SizeConstants.s1 * 15),
                        child: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        )),
                  )),
            )
          ],
        )));
  }

  bool _validatePassword() {
    setState(() {
      mResetPasswordScreenModel.validatePasswordFields();
    });
    if (!mResetPasswordScreenModel.pwdValidator &&
        !mResetPasswordScreenModel.confirmPwdValidator) {
      return true;
    }
    return false;
  }

  resetPasswordView() {
    return Container(
      margin: EdgeInsets.all(SizeConstants.s1 * 18),
      padding: EdgeInsets.all(SizeConstants.s1 * 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(SizeConstants.s1 * 5),
          color: ColorConstants.cWhite),
      child: Column(

        children: [
          SizedBox(
            height: SizeConstants.s1 * 5,
          ),
          Text(
            AppConstants.mWordConstants.sResetPasswordText,
            style: getTextRegular(size: SizeConstants.s1 * 20,colors: ColorConstants.cBlack),
          ),
          SizedBox(
            height: SizeConstants.s1 * 16,
          ),
          // editTextFiled(
          //   mResetPasswordScreenModel.mUserNameTextEditingController,
          //   labelText: AppConstants.mWordConstants.sEmailPhone,
          //   hintText: AppConstants.mWordConstants.sEnterTheUserEmailPhone,
          // ),
          // SizedBox(
          //   height: SizeConstants.s1 * 13,
          // ),
          editTextFiled(mResetPasswordScreenModel.mPasswordTextEditingController,
              labelText: AppConstants.mWordConstants.sNewPassword,
              hintText: AppConstants.mWordConstants.sEnterTheNewPassword,
              enableSuggestions: false,
              obscureText: true),
          if (mResetPasswordScreenModel.pwdValidator)
            setErrorMessage(AppConstants.mWordConstants.sPwdError),
          SizedBox(
            height: SizeConstants.s1 * 13,
          ),
          editTextFiled(mResetPasswordScreenModel.mConfirmPasswordTextEditingController,
              labelText: AppConstants.mWordConstants.sConfirmPassword,
              hintText: AppConstants.mWordConstants.sEnterTheConfirmPassword,
              enableSuggestions: false,
              obscureText: true),
          if (mResetPasswordScreenModel.confirmPwdValidator)
            setErrorMessage(AppConstants.mWordConstants.sConfirmPwdError),
          SizedBox(
            height: SizeConstants.s1 * 16,
          ),

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
              child: rectangleRoundedCornerSemiBoldButton(
                  AppConstants.mWordConstants.sResetPasswordText, () {
                    if(_validatePassword()) {
                      mResetPasswordScreenModel.tivraHealthResetPassword(widget.email);
                    }
              })),
          SizedBox(
            height: SizeConstants.s1 * 10,
          ),
        ],
      ),
    );
  }

  bottomView() {
    return Container(
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              SizedBox(
                height: SizeConstants.s1 * 120,
                width: SizeConstants.s1 * 120,
                child: Image.asset(
                  ImageAssets.loginLogo,
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: EdgeInsets.only(right: SizeConstants.s1 * 180),
                  alignment: Alignment.topLeft,
                  height: SizeConstants.s1 * 140,
                  width: SizeConstants.s1 * 120,
                  child: Stack(
                    children: [
                      Image.asset(
                        ImageAssets.loginLogo2,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: SizeConstants.s1 * 10,
                            left: SizeConstants.s1 * 15),
                        width: SizeConstants.s1 * 80,
                        child: Image.asset(
                          ImageAssets.loginLogo3,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          Text(
            AppConstants.mWordConstants.wSmartPlatform,
            style: getTextMedium(size: SizeConstants.s1 * 15),
          ),
          Text(
            AppConstants.mWordConstants.wToTrackYourFitness,
            style: getTextRegular(size: SizeConstants.s1 * 13),
          ),
          Text(
            AppConstants.mWordConstants.wSplashPageBottomText,
            style: getTextRegular(size: SizeConstants.s1 * 11),
          ),
          Container(
              width: SizeConstants.width * 0.55,
              height: SizeConstants.s1 * 35,
              alignment: Alignment.center,
              padding: EdgeInsets.zero,
              margin: EdgeInsets.only(
                top: SizeConstants.s1 * 10,
                bottom: SizeConstants.s1 * 10,
              ),
              child: rectangleRoundedCornerButton(
                  AppConstants.mWordConstants.wStartYourJourney, () {})),
        ],
      ),
    );
  }

  blocResetPasswordListener(
      BuildContext context, ResetPasswordState state) {
    switch (state.status) {
      case ResetPasswordStatus.loading:
        AppAlert.showProgressDialog(context);
        break;
      case ResetPasswordStatus.failed:
        AppAlert.closeDialog(context);
        AppAlert.showSnackBar(
            context, state.webResponseFailed?.statusMessage ?? "");
        break;
      case ResetPasswordStatus.success:
        AppAlert.closeDialog(context);
        Navigator.pushNamedAndRemoveUntil(
            context, RouteConstants.rSplashScreenWidget, (route) => false);
        break;
    }
  }
}
