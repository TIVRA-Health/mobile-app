import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:tivra_health/common/app_constants.dart';
import 'package:tivra_health/common/button_constants.dart';
import 'package:tivra_health/common/color_constants.dart';
import 'package:tivra_health/common/image_assets.dart';
import 'package:tivra_health/common/size_constants.dart';
import 'package:tivra_health/common/text_styles_constants.dart';
import 'package:tivra_health/data/all_bloc/all_image/bloc/all_image_data_bloc.dart';
import 'package:tivra_health/data/all_bloc/all_image/bloc/all_image_data_state.dart';
import 'package:tivra_health/modules/splash/model/splash_screen_model.dart';
import 'package:tivra_health/routes/route_constants.dart';

class SplashScreenWidget extends StatefulWidget {
  const SplashScreenWidget({super.key});

  @override
  State<SplashScreenWidget> createState() => _SplashScreenWidgetState();
}

class _SplashScreenWidgetState extends State<SplashScreenWidget> {
  bool isVisable = false;
  double _height = 0.0;
  late SplashScreenModel mSplashScreenModel;

  @override
  void initState() {
    // TODO: implement initState
    mSplashScreenModel = SplashScreenModel(context);
    mSplashScreenModel.initSharedPreferencesInstance();
    mSplashScreenModel.setAllImageBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: MultiBlocListener(listeners: [
      BlocListener<AllImageBloc, AllImageState>(
        bloc: mSplashScreenModel.getAllImageBloc(),
        listener: (context, state) {
          mSplashScreenModel.blocAllImageListener(context, state);
        },
      ),
    ], child: _buildSplashScreenWidgetView())));
  }

  _buildSplashScreenWidgetView() {
    SizeConstants(context);
    return FocusDetector(
        onVisibilityGained: () {
          Future.delayed(const Duration(microseconds: 500), () {
            setState(() {
              isVisable = true;
              _height = SizeConstants.height * 0.4;
            });
            // Future.delayed(const Duration(milliseconds: 1000), () {
            //   mSplashScreenModel.onRefresh();
            // });
          });
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
                  child: Image.asset(ImageAssets.splashBg1, fit: BoxFit.cover),
                )),
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: SizeConstants.s1 * 140,
                    child: Image.asset(ImageAssets.splashLogo,
                        fit: BoxFit.fitWidth),
                  ),
                  bottomView()
                ],
              ),
            )
          ],
        )));
  }

  bottomView() {
    return AnimatedSize(
      curve: Curves.easeIn,
      duration: const Duration(seconds: 1),
      child: Container(
          constraints:
              BoxConstraints(minHeight: _height, minWidth: double.infinity),
          child: isVisable
              ? Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: SizeConstants.s1 * 36),
                      child: Text(
                        AppConstants.mWordConstants.wSplashPageText,
                        style: getTextSemiBold(size: SizeConstants.s1 * 26),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                        width: SizeConstants.width * 0.55,
                        height: SizeConstants.s1 * 45,
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(
                          top: SizeConstants.s1 * 26,
                          bottom: SizeConstants.s1 * 52,
                        ),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(SizeConstants.s1 * 5),
                            color: ColorConstants.cSideMenuSelectText),
                        child: rectangleRoundedCornerButton(
                            AppConstants.mWordConstants.wStartYourJourney, () {
                          ///
                          mSplashScreenModel.onRefresh();
                        })),
                    Container(
                      width: SizeConstants.width * 0.85,
                      margin: EdgeInsets.only(top: SizeConstants.s1 * 20),
                      child: Text(
                        AppConstants.mWordConstants.wSplashPageBottomText,
                        style: getTextRegular(size: SizeConstants.s1 * 17),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                )
              : const SizedBox()),
    );
  }
}
