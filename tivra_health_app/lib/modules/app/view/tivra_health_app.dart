import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tivra_health/common/app_constants.dart';
import 'package:tivra_health/common/color_constants.dart';
import 'package:tivra_health/common/utils/device_utils.dart';
import 'package:tivra_health/common/word_constants.dart';
import 'package:tivra_health/modules/app/ui/material_app.dart';

class TivraHealthApp extends StatefulWidget {
  const TivraHealthApp({Key? key}) : super(key: key);

  @override
  _TivraHealthAppState createState() => _TivraHealthAppState();
}

class _TivraHealthAppState extends State<TivraHealthApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    initCreateLanguages(context);
    // Needs to be called while registering google fit and samsung health for now calling in main
   // initTerra();
    if (DeviceUtils.getPlatform() == AppConstants.platformAndroid) {
      setPortraitOrientation();
    }
    return getMaterialApp(context);
  }

  Future<void> setPortraitOrientation() async {
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: ColorConstants.kPrimaryColor,
      statusBarBrightness: Brightness.light,
    ));
  }

  Future<void> initCreateLanguages(BuildContext context) async {
    AppConstants.mWordConstants = await WordConstants.of(context);
  }
}