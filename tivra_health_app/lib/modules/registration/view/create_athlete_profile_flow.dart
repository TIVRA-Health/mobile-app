import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tivra_health/common/app_constants.dart';
import 'package:tivra_health/common/color_constants.dart';
import 'package:tivra_health/common/size_constants.dart';
import 'package:tivra_health/common/text_styles_constants.dart';
import 'package:tivra_health/modules/registration/view/demographic_profile.dart';
import 'package:tivra_health/modules/registration/view/health_and_fitness_profile.dart';
import 'package:tivra_health/modules/registration/view/social_profile.dart';

import 'create_athlete_profile_screen.dart';

class CreateAthleteProfileFlow extends StatefulWidget {
  final Function(bool, int) refreshPage;
  final int currentStep;
  final String role;
  final int corporateAffiliation;

  const CreateAthleteProfileFlow(this.refreshPage, this.currentStep, this.role, this.corporateAffiliation,
      {super.key});

  @override
  State<CreateAthleteProfileFlow> createState() => _CreateAthleteProfileFlow();
}

class _CreateAthleteProfileFlow extends State<CreateAthleteProfileFlow> {
  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );
  int? currentStep;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: ColorConstants.cWhite,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            AppConstants.mWordConstants.sCreateYour + widget.role + AppConstants.mWordConstants.sProfile,
            textAlign: TextAlign.center,
            style: getTextMedium(
                colors: ColorConstants.cBlack, size: SizeConstants.s1 * 20),
          ),
          SizedBox(
            height: SizeConstants.s_20,
          ),
          CreateAthleteProfileScreen(currentStep ?? 0, widget.role),
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
        DemographicProfile(refreshPage, widget.role, widget.corporateAffiliation),
        SocialProfile(refreshPage, widget.role, widget.corporateAffiliation),
        HealthAndFitnessProfile(refreshPage, widget.role, widget.corporateAffiliation),
      ],
    );
  }

  void pageChanged(int index) {
    setState(() {});
  }

  refreshPage(isRefresh, int index) {
    if (isRefresh) {
      if (index == 3) {
        widget.refreshPage(true, 3);
        return;
      }
      setState(() {
        currentStep = index;
        pageController.animateToPage(index,
            duration: const Duration(milliseconds: 500), curve: Curves.ease);
      });
    }
  }
}
