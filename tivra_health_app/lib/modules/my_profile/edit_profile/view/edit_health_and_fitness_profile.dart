import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tivra_health/common/alert/app_alert.dart';
import 'package:tivra_health/common/app_constants.dart';
import 'package:tivra_health/common/appbars_constants.dart';
import 'package:tivra_health/common/button_constants.dart';
import 'package:tivra_health/common/color_constants.dart';
import 'package:tivra_health/common/size_constants.dart';
import 'package:tivra_health/common/text_styles_constants.dart';
import 'package:tivra_health/common/widget/edit_text_field.dart';
import 'package:tivra_health/data/all_bloc/get_user_details/bloc/get_user_details_bloc.dart';
import 'package:tivra_health/data/all_bloc/get_user_details/bloc/get_user_details_state.dart';
import 'package:tivra_health/data/all_bloc/get_user_details/repo/get_user_details_response.dart';
import 'package:tivra_health/data/all_bloc/health_and_fitness_profile/bloc/tivra_health_health_and_fitness_bloc.dart';
import 'package:tivra_health/data/all_bloc/health_and_fitness_profile/bloc/tivra_health_health_and_fitness_state.dart';
import 'package:tivra_health/modules/registration/model/health_fitness_model.dart';

class EditHealthAndFitnessProfile extends StatefulWidget {
  const EditHealthAndFitnessProfile({Key? key}) : super(key: key);

  @override
  State<EditHealthAndFitnessProfile> createState() =>
      _EditHealthAndFitnessProfile();
}

class _EditHealthAndFitnessProfile extends State<EditHealthAndFitnessProfile> {
  late HealthAndFitnessModel mHealthAndFitnessModel;

  @override
  void initState() {
    super.initState();
    mHealthAndFitnessModel = HealthAndFitnessModel(context);
    mHealthAndFitnessModel.setTivraHealthHealthAndFitnessBloc();
    mHealthAndFitnessModel.setDashboardDetailsBloc();
    mHealthAndFitnessModel.getUserDetails();
  }

  bool _validate() {
    setState(() {
      mHealthAndFitnessModel.validateAllFields();
    });

    if (!mHealthAndFitnessModel.heightValidator &&
        !mHealthAndFitnessModel.weightValidator &&
        !mHealthAndFitnessModel.smokeValidator &&
        !mHealthAndFitnessModel.chronicConditionValidator) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        key: mHealthAndFitnessModel.scaffoldKey,
        appBar:
        AppBars.appBarBack((value) {}, mHealthAndFitnessModel.scaffoldKey),
        body: MultiBlocListener(child: getUserDetailsView(), listeners: [
          BlocListener<TivraHealthHealthAndFitnessBloc,
          TivraHealthHealthAndFitnessState > (
          bloc: mHealthAndFitnessModel.getTivraHealthHealthAndFitnessBloc(),
          listener: (context, state) {
            blocTivraHealthHealthAndFitnessProfileListener(context, state);
          },
          ),
          BlocListener<GetUserDetailsBloc,
              GetUserDetailsState>(
            bloc: mHealthAndFitnessModel.getUserDetailsBloc(),
            listener: (BuildContext context, GetUserDetailsState state) {
              mHealthAndFitnessModel.getUserDetailsListener(context,state);
            },),

        ]));
  }

  getUserDetailsView() {
    return StreamBuilder<GetUserDetailsResponse?>(
      stream: mHealthAndFitnessModel.responseSubject,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          GetUserDetailsResponse mGetUserDetailsResponse =
          snapshot.data as GetUserDetailsResponse;
          if (mGetUserDetailsResponse != null) {
            print("####getUserDetailsView#####");

            return _buildUI(mGetUserDetailsResponse);
          }
        }
        return _buildUI(GetUserDetailsResponse());
      },
    );
  }

  _buildUI(GetUserDetailsResponse getUserDetailsResponse) {
    return Container(
      margin: EdgeInsets.all(SizeConstants.s_10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            editTextFiled(mHealthAndFitnessModel.mWeightController,
                labelText: AppConstants.mWordConstants.sWeight,
                hintText: AppConstants.mWordConstants.sWeight,
                backGround: ColorConstants.cScaffoldBackgroundColor,
                mTextInputType: TextInputType.number,
                textInputAction: TextInputAction.done),
            if (mHealthAndFitnessModel.weightValidator)
              setErrorMessage(AppConstants.mWordConstants.sWeightError),
            SizedBox(
              height: SizeConstants.s_20,
            ),
            Container(
              width: SizeConstants.width - 30,
              color: ColorConstants.cScaffoldBackgroundColor,
              child: DropdownMenu<String>(
                dropdownMenuEntries: mHealthAndFitnessModel.sMenuItems
                    .map<DropdownMenuEntry<String>>((String value) {
                  return DropdownMenuEntry<String>(value: value, label: value);
                }).toList(),
                width: SizeConstants.width - 30,
                hintText: getUserDetailsResponse.healthFitness?.height ??
                    AppConstants.mWordConstants.sHeight,
                onSelected: (value) {
                  mHealthAndFitnessModel.setHeight(value!);
                },
              ),
            ),
            if (mHealthAndFitnessModel.heightValidator)
              setErrorMessage(AppConstants.mWordConstants.sHeightError),
            SizedBox(
              height: SizeConstants.s_20,
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.fromLTRB(
                  SizeConstants.s_10, 0, SizeConstants.s_10, 0),
              child: Text(
                AppConstants.mWordConstants.sSmoker,
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
                          groupValue: mHealthAndFitnessModel.smoker,
                          onChanged: (index) {
                            setState(() {
                              mHealthAndFitnessModel.smoker = 1;
                            });
                            mHealthAndFitnessModel
                                .setSmoke(AppConstants.mWordConstants.sYes);
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
                          groupValue: mHealthAndFitnessModel.smoker,
                          onChanged: (index) {
                            setState(() {
                              mHealthAndFitnessModel.smoker = 2;
                            });
                            mHealthAndFitnessModel
                                .setSmoke(AppConstants.mWordConstants.sNo);
                          }),
                      Expanded(child: Text(AppConstants.mWordConstants.sNo))
                    ],
                  ),
                ),
              ],
            ),
            if (mHealthAndFitnessModel.smokeValidator)
              setErrorMessage(AppConstants.mWordConstants.sSmokeError),
            SizedBox(
              height: SizeConstants.s_20,
            ),
            Container(
              width: SizeConstants.width - 30,
              color: ColorConstants.cScaffoldBackgroundColor,
              child: DropdownMenu<String>(
                dropdownMenuEntries: mHealthAndFitnessModel.chronicConditions
                    .map<DropdownMenuEntry<String>>((String value) {
                  return DropdownMenuEntry<String>(value: value, label: value);
                }).toList(),
                width: SizeConstants.width - 30,
                hintText:
                getUserDetailsResponse.healthFitness?.chronicCondition ??
                    AppConstants.mWordConstants.sChronicConditions,
                onSelected: (value) {
                  mHealthAndFitnessModel.setChronicCondition(value!);
                },
              ),
            ),
            if (mHealthAndFitnessModel.chronicConditionValidator)
              setErrorMessage(
                  AppConstants.mWordConstants.sChronicConditionError),
            SizedBox(
              height: SizeConstants.s_20,
            ),
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
                    AppConstants.mWordConstants.sUpdate, () {
                  if (_validate()) {
                    mHealthAndFitnessModel.putHealthAndFitnessProfile();
                  }
                })),
            SizedBox(
              height: SizeConstants.s_20,
            ),
          ],
        ),
      ),
    );
  }

  blocTivraHealthHealthAndFitnessProfileListener(BuildContext context,
      TivraHealthHealthAndFitnessState state) {
    switch (state.status) {
      case TivraHealthHealthAndFitnessStatus.loading:
        AppAlert.showProgressDialog(context);
        break;
      case TivraHealthHealthAndFitnessStatus.failed:
        AppAlert.closeDialog(context);
        AppAlert.showSnackBar(
            context, state.webResponseFailed?.statusMessage ?? "");
        break;
      case TivraHealthHealthAndFitnessStatus.success:
        AppAlert.closeDialog(context);
        mHealthAndFitnessModel.initGetUserDetails();
        break;
    }
  }
}
