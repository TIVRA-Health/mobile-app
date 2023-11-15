import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tivra_health/common/alert/app_alert.dart';
import 'package:tivra_health/common/app_constants.dart';
import 'package:tivra_health/common/button_constants.dart';
import 'package:tivra_health/common/color_constants.dart';
import 'package:tivra_health/common/size_constants.dart';
import 'package:tivra_health/common/widget/edit_text_field.dart';
import 'package:tivra_health/data/all_bloc/address_validation/bloc/address_bloc.dart';
import 'package:tivra_health/data/all_bloc/address_validation/bloc/address_state.dart';
import 'package:tivra_health/data/all_bloc/corporate_affiliation/bloc/corporate_affiliation_bloc.dart';
import 'package:tivra_health/data/all_bloc/corporate_affiliation/bloc/corporate_affiliation_state.dart';
import 'package:tivra_health/data/all_bloc/npi_validation/bloc/npi_bloc.dart';
import 'package:tivra_health/data/all_bloc/npi_validation/bloc/npi_state.dart';
import 'package:tivra_health/modules/registration/model/corporate_affiliation_model.dart';

class CorporateAffiliation extends StatefulWidget {
  final Function(bool, int) refreshPage;

  const CorporateAffiliation(this.refreshPage, {Key? key}) : super(key: key);

  @override
  State<CorporateAffiliation> createState() => _CorporateAffiliation();
}

class _CorporateAffiliation extends State<CorporateAffiliation> {
  late CorporateAffiliationModel mCorporateAffiliationModel;

  @override
  void initState() {
    super.initState();
    mCorporateAffiliationModel = CorporateAffiliationModel(context);
    mCorporateAffiliationModel.setTivraHealthLoginScreenBloc();
  }

  bool _validate() {
    setState(() {
      mCorporateAffiliationModel.validateAllFields();
    });
    if (!mCorporateAffiliationModel.organizationValidator &&
        !mCorporateAffiliationModel.typeOfEngagementValidator &&
        !mCorporateAffiliationModel.yearsOfCoachingValidator &&
        !mCorporateAffiliationModel.corporateAdd1Validator &&
        !mCorporateAffiliationModel.cityValidator &&
        !mCorporateAffiliationModel.stateValidator &&
        !mCorporateAffiliationModel.zipcodeValidator &&
        !mCorporateAffiliationModel.countryValidator) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(child: _buildUI(), listeners: [
      BlocListener<AddressBloc, AddressState>(
        bloc: mCorporateAffiliationModel.getAddressBloc(),
        listener: (context, state) {
         blocAddressListener(
              context, state);
        },
      ),
      BlocListener<CorporateAffiliationBloc, CorporateAffiliationState>(
        bloc: mCorporateAffiliationModel.getCorporateBloc(),
        listener: (context, state) {
          blocCorporateAffiliationListener(
              context, state);
        },
      ),
      BlocListener<NpiBloc, NpiState>(
        bloc: mCorporateAffiliationModel.getNpiBloc(),
        listener: (context, state) {
          blocNpiListener(
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
            editTextFiled(
                mCorporateAffiliationModel.mOrganizationNameController,
                labelText: AppConstants.mWordConstants.sOrganizationName,
                hintText: AppConstants.mWordConstants.sOrganizationName,
                backGround: ColorConstants.cScaffoldBackgroundColor),
            if (mCorporateAffiliationModel.organizationValidator)
              setErrorMessage(AppConstants.mWordConstants.sOrgError),
            SizedBox(
              height: SizeConstants.s_20,
            ),
            Container(
              width: SizeConstants.width - 30,
              color: ColorConstants.cScaffoldBackgroundColor,
              child: DropdownMenu<String>(
                dropdownMenuEntries: mCorporateAffiliationModel.sMenuItems
                    .map<DropdownMenuEntry<String>>((String value) {
                  return DropdownMenuEntry<String>(value: value, label: value);
                }).toList(),
                width: SizeConstants.width - 30,
                hintText: AppConstants.mWordConstants.sTypeOfEngagement,
                onSelected: (value) {
                  mCorporateAffiliationModel
                      .setSelectedTypeOfEngagement(value!);
                },
              ),
            ),
            if (mCorporateAffiliationModel.typeOfEngagementValidator)
              setErrorMessage(AppConstants.mWordConstants.sTypeEngagementError),
            SizedBox(
              height: SizeConstants.s_20,
            ),
            editTextFiled(mCorporateAffiliationModel.mYearsOfCoachingController,
                labelText: AppConstants.mWordConstants.sYearsOfCoaching,
                hintText: AppConstants.mWordConstants.sYearsOfCoaching,
                backGround: ColorConstants.cScaffoldBackgroundColor,
                mTextInputType: TextInputType.number),
            if (mCorporateAffiliationModel.yearsOfCoachingValidator)
              setErrorMessage(
                  AppConstants.mWordConstants.sYearsOfCoachingError),
            SizedBox(
              height: SizeConstants.s_20,
            ),
            editTextFiled(mCorporateAffiliationModel.mNpiController,
                labelText: AppConstants.mWordConstants.sNpi,
                hintText: AppConstants.mWordConstants.sNpi,
                backGround: ColorConstants.cScaffoldBackgroundColor),
            if (mCorporateAffiliationModel.npiValidator)
              setErrorMessage(AppConstants.mWordConstants.sNpiError),
            SizedBox(
              height: SizeConstants.s_20,
            ),
            editTextFiled(
                mCorporateAffiliationModel.mCorporateAddress1Controller,
                labelText: AppConstants.mWordConstants.sCorporateAddress1,
                hintText: AppConstants.mWordConstants.sCorporateAddress1,
                backGround: ColorConstants.cScaffoldBackgroundColor),
            if (mCorporateAffiliationModel.corporateAdd1Validator)
              setErrorMessage(AppConstants.mWordConstants.sCorporateAdd1Error),
            SizedBox(
              height: SizeConstants.s_20,
            ),
            editTextFiled(
                mCorporateAffiliationModel.mCorporateAddress2Controller,
                labelText: AppConstants.mWordConstants.sCorporateAddress2,
                hintText: AppConstants.mWordConstants.sCorporateAddress2,
                backGround: ColorConstants.cScaffoldBackgroundColor),
            SizedBox(
              height: SizeConstants.s_20,
            ),
            editTextFiled(mCorporateAffiliationModel.mCityController,
                labelText: AppConstants.mWordConstants.sCity,
                hintText: AppConstants.mWordConstants.sCity,
                backGround: ColorConstants.cScaffoldBackgroundColor),
            if (mCorporateAffiliationModel.cityValidator)
              setErrorMessage(AppConstants.mWordConstants.sCityError),
            SizedBox(
              height: SizeConstants.s_20,
            ),
            editTextFiled(mCorporateAffiliationModel.mStateController,
                labelText: AppConstants.mWordConstants.sState,
                hintText: AppConstants.mWordConstants.sState,
                backGround: ColorConstants.cScaffoldBackgroundColor),
            if (mCorporateAffiliationModel.stateValidator)
              setErrorMessage(AppConstants.mWordConstants.sStateError),
            SizedBox(
              height: SizeConstants.s_20,
            ),
            editTextFiled(mCorporateAffiliationModel.mZipcodeController,
                labelText: AppConstants.mWordConstants.sZipcode,
                hintText: AppConstants.mWordConstants.sZipcode,
                backGround: ColorConstants.cScaffoldBackgroundColor,
                mTextInputType: TextInputType.number),
            if (mCorporateAffiliationModel.zipcodeValidator)
              setErrorMessage(AppConstants.mWordConstants.sZipcodeError),
            SizedBox(
              height: SizeConstants.s_20,
            ),
            editTextFiled(mCorporateAffiliationModel.mCountryController,
                labelText: AppConstants.mWordConstants.sCountry,
                hintText: AppConstants.mWordConstants.sCountry,
                backGround: ColorConstants.cScaffoldBackgroundColor,
                textInputAction: TextInputAction.done),
            if (mCorporateAffiliationModel.countryValidator)
              setErrorMessage(AppConstants.mWordConstants.sCountryError),
            SizedBox(
              height: SizeConstants.s_20,
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
                child: rectangleRoundedCornerButton(
                    AppConstants.mWordConstants.sContinue, () {
                  if (_validate()) {
                    mCorporateAffiliationModel.putAddress();
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

  blocAddressListener(
      BuildContext context, AddressState state) {
    switch (state.status) {
      case AddressStatus.loading:
        AppAlert.showProgressDialog(context);
        break;
      case AddressStatus.failed:
        AppAlert.closeDialog(context);
        AppAlert.showSnackBar(
            context, state.webResponseFailed?.statusMessage ?? "");
        break;
      case AddressStatus.success:
        AppAlert.closeDialog(context);
        if(state.mAddressResponse?.success ?? false) {
          mCorporateAffiliationModel.getNpi();
        } else {
          AppAlert.showSnackBar(
              context, "Invalid Address");
        }
        break;
    }
  }

  blocNpiListener(
      BuildContext context, NpiState state) {
    switch (state.status) {
      case NpiStatus.loading:
        AppAlert.showProgressDialog(context);
        break;
      case NpiStatus.failed:
        AppAlert.closeDialog(context);
        AppAlert.showSnackBar(
            context, state.webResponseFailed?.statusMessage ?? "");
        break;
      case NpiStatus.success:
        AppAlert.closeDialog(context);
        if(state.mNpiResponse?.success ?? false) {
          mCorporateAffiliationModel.putCorporateAffiliation();
        } else {
          AppAlert.showSnackBar(
              context, "Invalid NPI");
        }
        break;
    }
  }

  blocCorporateAffiliationListener(
      BuildContext context, CorporateAffiliationState state) {
    switch (state.status) {
      case CorporateAffiliationStatus.loading:
        AppAlert.showProgressDialog(context);
        break;
      case CorporateAffiliationStatus.failed:
        AppAlert.closeDialog(context);
        AppAlert.showSnackBar(
            context, state.webResponseFailed?.statusMessage ?? "");
        break;
      case CorporateAffiliationStatus.success:
        widget.refreshPage(true, 1);
        AppAlert.closeDialog(context);
        break;
    }
  }
}
