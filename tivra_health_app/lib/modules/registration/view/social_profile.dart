import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tivra_health/common/alert/app_alert.dart';
import 'package:tivra_health/common/app_constants.dart';
import 'package:tivra_health/common/button_constants.dart';
import 'package:tivra_health/common/color_constants.dart';
import 'package:tivra_health/common/size_constants.dart';
import 'package:tivra_health/common/text_styles_constants.dart';
import 'package:tivra_health/common/widget/edit_text_field.dart';
import 'package:tivra_health/data/all_bloc/social_profile/bloc/tivra_health_social_profile_bloc.dart';
import 'package:tivra_health/data/all_bloc/social_profile/bloc/tivra_health_social_profile_state.dart';
import 'package:tivra_health/modules/registration/model/social_profile_model.dart';

class SocialProfile extends StatefulWidget {
  final Function(bool, int) refreshPage;
  final String role;
  final int corporateAffiliation;

  const SocialProfile(this.refreshPage, this.role, this.corporateAffiliation, {Key? key})
      : super(key: key);

  @override
  State<SocialProfile> createState() => _SocialProfile();
}

class _SocialProfile extends State<SocialProfile> {
  late SocialProfileModel mSocialProfileModel;
  int? healthCare;

  @override
  void initState() {
    super.initState();
    mSocialProfileModel = SocialProfileModel(context);
    mSocialProfileModel.setTivraHealthSocialProfileBloc();
  }

  bool _validate() {
    setState(() {
      mSocialProfileModel.validateAllFields();
    });
    if (!mSocialProfileModel.educationValidator &&
        !mSocialProfileModel.healthCareValidator &&
        !mSocialProfileModel.incomeRangeValidator) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(child: _buildUI(), listeners: [
      BlocListener<TivraHealthSocialProfileBloc, TivraHealthSocialProfileState>(
        bloc: mSocialProfileModel.getTivraHealthSocialProfileBloc(),
        listener: (context, state) {
          blocTivraHealthSocialProfileListener(
              context, state);
        },
      ),
    ]);
  }

  _buildUI() {
    return Container(
      margin: EdgeInsets.all(SizeConstants.s_10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: SizeConstants.width - 30,
              color: ColorConstants.cScaffoldBackgroundColor,
              child: DropdownMenu<String>(
                dropdownMenuEntries: mSocialProfileModel.sMenuItems
                    .map<DropdownMenuEntry<String>>((String value) {
                  return DropdownMenuEntry<String>(value: value, label: value);
                }).toList(),
                width: SizeConstants.width - 30,
                hintText: AppConstants.mWordConstants.sHighestEducation,
                onSelected: (value) {
                  mSocialProfileModel.setEducation(value!);
                },
              ),
            ),
            if (mSocialProfileModel.educationValidator)
              setErrorMessage(AppConstants.mWordConstants.sEducationError),
            SizedBox(
              height: SizeConstants.s_20,
            ),
            Container(
              width: SizeConstants.width - 30,
              color: ColorConstants.cScaffoldBackgroundColor,
              child: DropdownMenu<String>(
                dropdownMenuEntries: mSocialProfileModel.sHouseHoldIncomeRange
                    .map<DropdownMenuEntry<String>>((String value) {
                  return DropdownMenuEntry<String>(value: value, label: value);
                }).toList(),
                width: SizeConstants.width - 30,
                hintText: AppConstants.mWordConstants.sHouseholdIncome,
                onSelected: (value) {
                  mSocialProfileModel.setHouseHoldIncomeRange(value!);
                },
              ),
            ),
            if (mSocialProfileModel.incomeRangeValidator)
              setErrorMessage(AppConstants.mWordConstants.sIncomeRangeError),
            SizedBox(
              height: SizeConstants.s_20,
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.fromLTRB(
                  SizeConstants.s_10, 0, SizeConstants.s_10, 0),
              child: Text(
                AppConstants.mWordConstants.sAccessToHealthCare,
                style: getTextRegular(
                    colors: ColorConstants.cBlack, size: SizeConstants.s_14),
              ),
            ),
            SizedBox(
              height: SizeConstants.s_10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Radio(
                          value: 1,
                          groupValue: healthCare,
                          onChanged: (index) {
                            /*mSocialProfileModel.setHealthCare(
                                AppConstants.mWordConstants.sYes);*/
                            mSocialProfileModel.setHealthCare(true);
                            setState(() {
                              healthCare = 1;
                            });
                          }),
                      Expanded(
                        child: Text(AppConstants.mWordConstants.sYes),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Radio(
                          value: 2,
                          groupValue: healthCare,
                          onChanged: (index) {
                            /*mSocialProfileModel
                                .setHealthCare(AppConstants.mWordConstants.sNo);*/
                            mSocialProfileModel.setHealthCare(false);
                            setState(() {
                              healthCare = 2;
                            });
                          }),
                      Expanded(child: Text(AppConstants.mWordConstants.sNo))
                    ],
                  ),
                ),
              ],
            ),
            if (mSocialProfileModel.healthCareValidator)
              setErrorMessage(AppConstants.mWordConstants.sHealthcareError),
            SizedBox(
              height: SizeConstants.s_20,
            ),
            editTextFiled(mSocialProfileModel.mHospitalSystemController,
                labelText: AppConstants.mWordConstants.sHospitalSystem,
                hintText: AppConstants.mWordConstants.sHospitalSystem,
                backGround: ColorConstants.cScaffoldBackgroundColor,
                textInputAction : TextInputAction.done),
            SizedBox(
              height: SizeConstants.s_20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                    width: SizeConstants.width / 3,
                    height: SizeConstants.s1 * 43,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(
                      left: SizeConstants.s1 * 5,
                      right: SizeConstants.s1 * 5,
                    ),
                    padding: EdgeInsets.only(
                      left: SizeConstants.s1 * 10,
                      right: SizeConstants.s1 * 10,
                    ),
                    decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(SizeConstants.s1 * 5),
                        color: ColorConstants.cScaffoldBackgroundColor),
                    child: rectangleRoundedCornerGreyButton(
                        AppConstants.mWordConstants.sBack, () {
                      widget.corporateAffiliation == 1
                          ? widget.refreshPage(true, 1)
                          : widget.refreshPage(true, 0);
                    })),
                Container(
                    width: SizeConstants.width / 3,
                    height: SizeConstants.s1 * 43,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(
                      left: SizeConstants.s1 * 5,
                      right: SizeConstants.s1 * 5,
                    ),
                    padding: EdgeInsets.only(
                      left: SizeConstants.s1 * 10,
                      right: SizeConstants.s1 * 10,
                    ),
                    decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(SizeConstants.s1 * 5),
                        color: ColorConstants.cSideMenuSelectText),
                    child: rectangleRoundedCornerButton(
                        AppConstants.mWordConstants.sContinue, () {
                      if (_validate()) {
                        mSocialProfileModel.putSocialProfile();
                      }
                    })),
              ],
            ),
            SizedBox(
              height: SizeConstants.s_20,
            ),
          ],
        ),
      ),
    );
  }

  blocTivraHealthSocialProfileListener(
      BuildContext context, TivraHealthSocialProfileState state) {
    switch (state.status) {
      case TivraHealthSocialProfileStatus.loading:
        AppAlert.showProgressDialog(context);
        break;
      case TivraHealthSocialProfileStatus.failed:
        AppAlert.closeDialog(context);
        AppAlert.showSnackBar(
            context, state.webResponseFailed?.statusMessage ?? "");
        break;
      case TivraHealthSocialProfileStatus.success:
        AppAlert.closeDialog(context);
        widget.corporateAffiliation == 1
            ? widget.refreshPage(true, 3)
            : widget.refreshPage(true, 2);
        break;
    }
  }
}
