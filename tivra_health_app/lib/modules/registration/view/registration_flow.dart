import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tivra_health/common/app_constants.dart';
import 'package:tivra_health/common/color_constants.dart';
import 'package:tivra_health/common/image_assets.dart';
import 'package:tivra_health/modules/registration/view/create_athlete_profile_flow.dart';
import 'package:tivra_health/modules/registration/view/create_athlete_coach_profile_flow.dart';
import 'package:tivra_health/modules/registration/view/create_your_account_screen.dart';
import 'package:tivra_health/modules/registration/view/create_athlete_coach_profile_screen.dart';
import 'package:tivra_health/modules/registration/view/device_integration_screen.dart';
import 'package:tivra_health/modules/registration/view/payment_details_screen.dart';
import 'package:tivra_health/modules/registration/view/registration_screen.dart';

import '../../../common/appbars_constants.dart';

class RegistrationFlow extends StatefulWidget {
  const RegistrationFlow({super.key});

  @override
  State<RegistrationFlow> createState() => _RegistrationFlow();
}

class _RegistrationFlow extends State<RegistrationFlow> {
  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );
  int? currentStep;
  String selectedRole = "";
  int corporateAffiliation = -1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
            icon: Icon(Icons.arrow_back_ios_outlined),
          ),
            backgroundColor: ColorConstants.cSideMenuSelect,
            title: Image.asset(
              ImageAssets.appBarIcon,
              fit: BoxFit.cover,
            ),
            automaticallyImplyLeading: false),
        body: Container(
          color: ColorConstants.cWhite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              RegistrationScreen(currentStep ?? 0),
              Container(
                margin: const EdgeInsets.fromLTRB(30,20,30,20),
                height: 1,
                color: ColorConstants.cBlack.withOpacity(0.3),
              ),
              Expanded(child: buildPageView())
            ],
          ),
        ));
  }

  Widget buildPageView() {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      pageSnapping: true,
      controller: pageController,
      onPageChanged: (index) {
        pageChanged(index);
      },
      children: <Widget>[
        CreateYourAccountScreen(refreshPage),
        PaymentDetailsScreen(refreshPage),
        if(corporateAffiliation == 1)
          CreateAthleteCoachProfileFlow(refreshPage, 0, selectedRole, 1),
        if(corporateAffiliation == 0)
          CreateAthleteProfileFlow(refreshPage, 0, selectedRole, 0),
        DeviceIntegrationScreen(
          refreshPage,
        ),
      ],
    );
  }

  void pageChanged(int index) {
    setState(() {});
  }

  refreshPage(isRefresh, int index,[int? corporateAffiliationValue, String? role]) {
    if (isRefresh) {
      setState(() {
        currentStep = index;
        if(currentStep == 2) {
          selectedRole = role.toString();
          corporateAffiliation = corporateAffiliationValue!;
        }
        pageController.animateToPage(index,
            duration: const Duration(milliseconds: 500), curve: Curves.ease);
      });
    }
  }
}
