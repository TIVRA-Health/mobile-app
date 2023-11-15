import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tivra_health/common/alert/app_alert.dart';
import 'package:tivra_health/common/app_constants.dart';
import 'package:tivra_health/common/appbars_constants.dart';
import 'package:tivra_health/common/button_constants.dart';
import 'package:tivra_health/common/color_constants.dart';
import 'package:tivra_health/common/size_constants.dart';
import 'package:tivra_health/common/utils/calendar_utils.dart';
import 'package:tivra_health/common/widget/edit_text_field.dart';
import 'package:tivra_health/common/widget/text_input_widget.dart';
import 'package:tivra_health/data/all_bloc/demographic_profile/bloc/tivra_health_demographic_profile_bloc.dart';
import 'package:tivra_health/data/all_bloc/demographic_profile/bloc/tivra_health_demographic_profile_state.dart';
import 'package:tivra_health/data/all_bloc/get_user_details/bloc/get_user_details_bloc.dart';
import 'package:tivra_health/data/all_bloc/get_user_details/bloc/get_user_details_state.dart';
import 'package:tivra_health/data/all_bloc/get_user_details/repo/get_user_details_response.dart';
import 'package:tivra_health/modules/registration/model/demographic_profile_model.dart';

class EditDemographicProfile extends StatefulWidget {
  const EditDemographicProfile({Key? key}) : super(key: key);

  @override
  State<EditDemographicProfile> createState() => _EditDemographicProfile();
}

class _EditDemographicProfile extends State<EditDemographicProfile> {
  late DemographicProfileModel mDemographicProfileModel;

  @override
  void initState() {
    super.initState();
    mDemographicProfileModel = DemographicProfileModel(context);
    mDemographicProfileModel.setTivraHealthDemographicProfileBloc();
    mDemographicProfileModel.getUserDetails();
    mDemographicProfileModel.setDashboardDetailsBloc();
  }

  bool _validate() {
    setState(() {
      mDemographicProfileModel.validateAllFields();
    });
    if (!mDemographicProfileModel.genderValidator &&
        !mDemographicProfileModel.dobValidator &&
        !mDemographicProfileModel.streetAdd1Validator &&
        !mDemographicProfileModel.cityValidator &&
        !mDemographicProfileModel.stateValidator &&
        !mDemographicProfileModel.zipcodeValidator &&
        !mDemographicProfileModel.countryValidator) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        key: mDemographicProfileModel.scaffoldKey,
        appBar: AppBars.appBarBack(
            (value) {}, mDemographicProfileModel.scaffoldKey),
        body: MultiBlocListener(child: getUserDetailsView(), listeners: [
          BlocListener<TivraHealthDemographicProfileBloc,
              TivraHealthDemographicProfileState>(
            bloc:
                mDemographicProfileModel.getTivraHealthDemographicProfileBloc(),
            listener: (context, state) {
              blocTivraHealthDemographicProfileListener(context, state);
            },
          ),
          BlocListener<GetUserDetailsBloc, GetUserDetailsState>(
            bloc: mDemographicProfileModel.getUserDetailsBloc(),
            listener: (context, state) {
              mDemographicProfileModel.getUserDetailsListener(context, state);
            },
          ),
        ]));
  }

  getUserDetailsView() {
    return StreamBuilder<GetUserDetailsResponse?>(
      stream: mDemographicProfileModel.responseSubject,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          GetUserDetailsResponse mGetUserDetailsResponse =
              snapshot.data as GetUserDetailsResponse;
          if (mGetUserDetailsResponse != null) {
            return _buildUI(mGetUserDetailsResponse);
          }
        }
        return _buildUI(GetUserDetailsResponse());
      },
    );
  }

  _buildUI(GetUserDetailsResponse mGetUserDetailsResponse) {
    return Container(
      margin: EdgeInsets.all(SizeConstants.s_10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: SizeConstants.width - 30,
              color: ColorConstants.cScaffoldBackgroundColor,
              child: DropdownMenu<String>(
                dropdownMenuEntries: mDemographicProfileModel.sMenuItems
                    .map<DropdownMenuEntry<String>>((String value) {
                  return DropdownMenuEntry<String>(value: value, label: value);
                }).toList(),
                width: SizeConstants.width - 30,
                hintText: mGetUserDetailsResponse.demographic?.gender ??
                    AppConstants.mWordConstants.sGender,
                onSelected: (value) {
                  mDemographicProfileModel.setGender(value!);
                },
              ),
            ),
            if (mDemographicProfileModel.genderValidator)
              setErrorMessage(AppConstants.mWordConstants.sSelectGender),
            SizedBox(
              height: SizeConstants.s_20,
            ),
            Container(
              width: SizeConstants.width - 30,
              color: ColorConstants.cScaffoldBackgroundColor,
              child: TextInputSelectionWidget(
                () async {
                  var values = await AppAlert.buildCalendarDialog(
                      context,
                      mDemographicProfileModel.dialogCalendarPickerValue,
                      getCalendarDatePickerSingle(context));
                  mDemographicProfileModel.stringCalendarPickerValue.clear();
                  mDemographicProfileModel.stringCalendarPickerValue = values;
                  if (mDemographicProfileModel
                      .stringCalendarPickerValue.isNotEmpty) {
                    mDemographicProfileModel.mDateOfBirthController.text =
                        mDemographicProfileModel.stringCalendarPickerValue[0] ??
                            "";
                  }
                },
                controller: mDemographicProfileModel.mDateOfBirthController,
                placeHolder: AppConstants.mWordConstants.sDateOfBirth,
                errorText: null,
              ),
            ),
            if (mDemographicProfileModel.dobValidator)
              setErrorMessage(AppConstants.mWordConstants.sDobError),
            SizedBox(
              height: SizeConstants.s_20,
            ),
            editTextFiled(mDemographicProfileModel.mStreetAddress1Controller,
                labelText: AppConstants.mWordConstants.sStreetAddress1,
                hintText: AppConstants.mWordConstants.sStreetAddress1,
                backGround: ColorConstants.cScaffoldBackgroundColor),
            if (mDemographicProfileModel.streetAdd1Validator)
              setErrorMessage(AppConstants.mWordConstants.sStreetAdd1Error),
            SizedBox(
              height: SizeConstants.s_20,
            ),
            editTextFiled(mDemographicProfileModel.mStreetAddress2Controller,
                labelText: AppConstants.mWordConstants.sStreetAddress2,
                hintText: AppConstants.mWordConstants.sStreetAddress2,
                backGround: ColorConstants.cScaffoldBackgroundColor),
            SizedBox(
              height: SizeConstants.s_20,
            ),
            editTextFiled(mDemographicProfileModel.mCityController,
                labelText: AppConstants.mWordConstants.sCity,
                hintText: AppConstants.mWordConstants.sCity,
                backGround: ColorConstants.cScaffoldBackgroundColor),
            if (mDemographicProfileModel.cityValidator)
              setErrorMessage(AppConstants.mWordConstants.sCityError),
            SizedBox(
              height: SizeConstants.s_20,
            ),
            editTextFiled(mDemographicProfileModel.mStateController,
                labelText: AppConstants.mWordConstants.sState,
                hintText: AppConstants.mWordConstants.sState,
                backGround: ColorConstants.cScaffoldBackgroundColor),
            if (mDemographicProfileModel.stateValidator)
              setErrorMessage(AppConstants.mWordConstants.sStateError),
            SizedBox(
              height: SizeConstants.s_20,
            ),
            editTextFiled(mDemographicProfileModel.mZipcodeController,
                labelText: AppConstants.mWordConstants.sZipcode,
                hintText: AppConstants.mWordConstants.sZipcode,
                backGround: ColorConstants.cScaffoldBackgroundColor,
            mTextInputType: TextInputType.number),
            if (mDemographicProfileModel.zipcodeValidator)
              setErrorMessage(AppConstants.mWordConstants.sZipcodeError),
            SizedBox(
              height: SizeConstants.s_20,
            ),
            editTextFiled(mDemographicProfileModel.mCountryController,
                labelText: AppConstants.mWordConstants.sCountry,
                hintText: AppConstants.mWordConstants.sCountry,
                backGround: ColorConstants.cScaffoldBackgroundColor,
                textInputAction: TextInputAction.done),
            if (mDemographicProfileModel.countryValidator)
              setErrorMessage(AppConstants.mWordConstants.sCountryError),
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
                    borderRadius: BorderRadius.circular(SizeConstants.s1 * 5),
                    color: ColorConstants.cSideMenuSelectText),
                child: rectangleRoundedCornerButton(
                    AppConstants.mWordConstants.sUpdate, () {
                  if (_validate()) {
                    mDemographicProfileModel.putDemographicProfile();
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

  blocTivraHealthDemographicProfileListener(
      BuildContext context, TivraHealthDemographicProfileState state) {
    switch (state.status) {
      case TivraHealthDemographicProfileStatus.loading:
        AppAlert.showProgressDialog(context);
        break;
      case TivraHealthDemographicProfileStatus.failed:
        AppAlert.closeDialog(context);
        AppAlert.showSnackBar(
            context, state.webResponseFailed?.statusMessage ?? "");
        break;
      case TivraHealthDemographicProfileStatus.success:
        AppAlert.closeDialog(context);
        mDemographicProfileModel.initGetUserDetails();
        break;
    }
  }
}
