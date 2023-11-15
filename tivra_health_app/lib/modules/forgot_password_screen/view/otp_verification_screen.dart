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
import 'package:tivra_health/data/all_bloc/verify_otp/bloc/tivra_health_register_screen_verify_otp_bloc.dart';
import 'package:tivra_health/data/all_bloc/verify_otp/bloc/tivra_health_register_screen_verify_otp_state.dart';
import 'package:tivra_health/modules/forgot_password_screen/model/forgot_password_screen_model.dart';
import 'package:tivra_health/routes/route_constants.dart';

class OTPScreenWidget extends StatefulWidget {
  final ForgotPasswordScreenModel forgotPasswordScreenModel;
  const OTPScreenWidget({super.key,required this.forgotPasswordScreenModel});

  @override
  State<OTPScreenWidget> createState() => _OTPScreenWidgetState();
}

class _OTPScreenWidgetState extends State<OTPScreenWidget> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBars.appNoBar(), body: MultiBlocListener(child: _buildLoginView(), listeners: [
      BlocListener<TivraHealthRegisterScreenVerifyOTPBloc, TivraHealthRegisterScreenVerifyOTPState>(
        bloc: widget.forgotPasswordScreenModel.getHealthRegisterScreenVerifyOTPBloc(),
        listener: (context, state) {
          blocTivraHealthRegisterScreenVerifyOTPListener(
              context, state);
        },
      ),
    ]));
  }

  bool _validateOTP() {
    setState(() {
      widget.forgotPasswordScreenModel.validateOTPField();
    });
    if (!widget.forgotPasswordScreenModel.otpValidator) {
      return true;
    }
    return false;
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

                          ///ForgotPasswordView
                          forgotPasswordView(),

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

  forgotPasswordView() {
    return Container(
      margin: EdgeInsets.all(SizeConstants.s1 * 18),
      padding: EdgeInsets.all(SizeConstants.s1 * 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(SizeConstants.s1 * 5),
          color: ColorConstants.cWhite),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: SizeConstants.s1 * 5,
          ),
          Text(
            AppConstants.mWordConstants.sOTPVerification,
            textAlign: TextAlign.center,
            style: getTextRegular(size: SizeConstants.s1 * 20,colors: ColorConstants.cBlack),
          ),
          SizedBox(
            height: SizeConstants.s1 * 16,
          ),
          editTextFiled(widget.forgotPasswordScreenModel.mOTPController,
              labelText: AppConstants.mWordConstants.sOTP,
              hintText: AppConstants.mWordConstants.sOTP,
              backGround: ColorConstants.cScaffoldBackgroundColor,
              mTextInputType: TextInputType.text,
              textInputAction: TextInputAction.done),
          if (widget.forgotPasswordScreenModel.otpValidator)
            setErrorMessage(AppConstants.mWordConstants.sOTPError),
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
                  AppConstants.mWordConstants.wVerifyOTP, () {
                    if(_validateOTP()) {
                      widget.forgotPasswordScreenModel.tivraHealthRegisterScreenVerifyOTP();
                    }
              })),
          SizedBox(
            height: SizeConstants.s1 * 16,
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
        Navigator.pushNamed(
            context, RouteConstants.rResetPasswordScreenWidget, arguments: widget.forgotPasswordScreenModel.mUserNameTextEditingController.text);
        break;
    }
  }
}
