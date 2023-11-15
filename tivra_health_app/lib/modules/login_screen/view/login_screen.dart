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
import 'package:tivra_health/common/utils/app_utils.dart';
import 'package:tivra_health/common/widget/app_bar_bottom_view.dart';
import 'package:tivra_health/common/widget/edit_text_field.dart';
import 'package:tivra_health/data/all_bloc/get_user_details/bloc/get_user_details_bloc.dart';
import 'package:tivra_health/data/all_bloc/get_user_details/bloc/get_user_details_state.dart';
import 'package:tivra_health/data/all_bloc/tivra_health_login/bloc/tivra_health_login_screen_bloc.dart';
import 'package:tivra_health/data/all_bloc/tivra_health_login/bloc/tivra_health_login_screen_state.dart';
import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';
import 'package:tivra_health/modules/common/skill_selection/model/web_model.dart';
import 'package:tivra_health/modules/login_screen/model/login_screen_model.dart';
import 'package:tivra_health/routes/route_constants.dart';

class LoginScreenWidget extends StatefulWidget {
  const LoginScreenWidget({super.key});

  @override
  State<LoginScreenWidget> createState() => _LoginScreenWidgetState();
}

class _LoginScreenWidgetState extends State<LoginScreenWidget> {
  late LoginScreenModel mLoginScreenModel;

  @override
  void initState() {
    mLoginScreenModel = LoginScreenModel(context);

    mLoginScreenModel.setTivraHealthLoginScreenBloc();
    mLoginScreenModel.setDashboardDetailsBloc();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBars.appNoBar(), body: _buildLoginView());
  }

  _buildLoginView() {
    return MultiBlocListener(child: _buildView(), listeners: [
      BlocListener<TivraHealthLoginScreenBloc, TivraHealthLoginScreenState>(
        bloc: mLoginScreenModel.getTivraHealthLoginScreenBloc(),
        listener: (context, state) {
          mLoginScreenModel.blocTivraHealthLoginScreenListener(
              context, state);
        },
      ),
      BlocListener<GetUserDetailsBloc, GetUserDetailsState>(
        bloc: mLoginScreenModel.getUserDetailsBloc(),
        listener: (context, state) {
          mLoginScreenModel.getUserDetailsListener(
              context, state);
        },
      ),
    ]);
  }


  _buildView() {
    return FocusDetector(
        onVisibilityGained: () {
          setState(() {
            mLoginScreenModel.getRemember();
          });
        },
        child: GestureDetector(
          onTap: () {
            AppUtils.hideKeyboard(context);
          },
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
                    child:
                        Image.asset(ImageAssets.splashBg1, fit: BoxFit.cover),
                  )),
              Align(
                  alignment: Alignment.center,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: SizeConstants.s1 * 40,
                        ),
                        SizedBox(
                          height: SizeConstants.s1 * 110,
                          child: Image.asset(ImageAssets.splashLogo,
                              fit: BoxFit.fitWidth),
                        ),

                        ///loginView
                        loginView(),

                        ///bottomView
                        bottomView(),
                        SizedBox(
                          height: SizeConstants.s1 * 32,
                        ),
                      ],
                    ),
                  )),
            ],
          )),
        ));
  }

  loginView() {
    return Container(
      margin: EdgeInsets.all(SizeConstants.s1 * 18),
      child: Column(
        children: [
          editTextFiled(
            mLoginScreenModel.mUserNameTextEditingController,
            labelText: AppConstants.mWordConstants.sUserName,
            hintText: AppConstants.mWordConstants.sEnterTheUserName,
              textInputAction: TextInputAction.next
          ),
          SizedBox(
            height: SizeConstants.s1 * 13,
          ),
          editTextFiled(mLoginScreenModel.mPasswordTextEditingController,
              labelText: AppConstants.mWordConstants.sPassword,
              hintText: AppConstants.mWordConstants.sEnterThePassword,
              enableSuggestions: false,
              obscureText: true,
              textInputAction: TextInputAction.done),
          SizedBox(
            height: SizeConstants.s1 * 13,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    mLoginScreenModel.isRemember  =!mLoginScreenModel.isRemember;
                  });
                },
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      SizedBox(
                        width: SizeConstants.s1 * 5,
                      ),
                      mLoginScreenModel.isRemember?Icon(
                        Icons.check_box_rounded,
                        color: Colors.white,
                        size: SizeConstants.s1 * 18,
                      ):
                      Icon(
                        Icons.check_box_outline_blank_rounded,
                        color: Colors.white,
                        size: SizeConstants.s1 * 18,
                      ),
                      SizedBox(
                        width: SizeConstants.s1 * 3,
                      ),
                      Text(
                        AppConstants.mWordConstants.sRememberPassword,
                        style: getTextRegular(size: SizeConstants.s1 * 15),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  ///RouteConstants.rResetPasswordScreenWidget
                  ///RouteConstants.rForgotPasswordScreenWidget
                  mLoginScreenModel.showNextPage(
                      RouteConstants.rForgotPasswordScreenWidget,
                      bRemove: false);
                },
                child: Text(
                  AppConstants.mWordConstants.sForgotPassword,
                  style: getTextRegular(size: SizeConstants.s1 * 15),
                ),
              )
            ],
          ),
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
                  AppConstants.mWordConstants.wSignIn, () {
                AppUtils.hideKeyboard(context);
                Future.delayed(const Duration(milliseconds: 200), () {
                  if (mLoginScreenModel
                      .mUserNameTextEditingController
                      .text
                      .isNotEmpty &&
                      mLoginScreenModel
                          .mPasswordTextEditingController
                          .text
                          .isNotEmpty) {
                    mLoginScreenModel
                        .fetchTivraHealthLoginScreenUrl();
                  } else if (mLoginScreenModel
                      .mUserNameTextEditingController.text.isEmpty) {
                    AppAlert.showSnackBar(
                        context,
                        AppConstants
                            .mWordConstants.wPleaseEnterUsernameText);
                  } else if (mLoginScreenModel
                      .mPasswordTextEditingController.text.isEmpty) {
                    AppAlert.showSnackBar(
                        context,
                        AppConstants
                            .mWordConstants.wPleaseEnterPasswordText);
                  }
                });
              })),
          SizedBox(
            height: SizeConstants.s1 * 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppConstants.mWordConstants.sDoNotHaveAnAccount,
                style: getTextRegular(size: SizeConstants.s1 * 18),
              ),
              SizedBox(
                width: SizeConstants.s1 * 12,
              ),
              Container(
                width: SizeConstants.s1 * 100,
                height: SizeConstants.s1 * 35,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(SizeConstants.s1 * 5),
                    color: ColorConstants.cWhite),
                child: rectangleRoundedCornerButton(
                  AppConstants.mWordConstants.wSignUp,
                  () {
                    mLoginScreenModel.showNextPage(
                        RouteConstants.rRegistrationFlow,
                        bRemove: false);
                  },
                  textColor: ColorConstants.cSideMenuSelectText,
                  bgColor: ColorConstants.cWhite,
                ),
              )
            ],
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
}
