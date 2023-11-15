import 'package:flutter/material.dart';
import 'package:tivra_health/common/alert/app_alert.dart';
import 'package:tivra_health/common/message_constants.dart';
import 'package:tivra_health/common/utils/network_utils.dart';
import 'package:tivra_health/data/all_bloc/address_validation/bloc/address_bloc.dart';
import 'package:tivra_health/data/all_bloc/address_validation/bloc/address_event.dart';
import 'package:tivra_health/data/all_bloc/address_validation/repo/address_request.dart';
import 'package:tivra_health/data/all_bloc/corporate_affiliation/bloc/corporate_affiliation_bloc.dart';
import 'package:tivra_health/data/all_bloc/corporate_affiliation/bloc/corporate_affiliation_event.dart';
import 'package:tivra_health/data/all_bloc/corporate_affiliation/repo/corporate_affiliation_request.dart';
import 'package:tivra_health/data/all_bloc/npi_validation/bloc/npi_bloc.dart';
import 'package:tivra_health/data/all_bloc/npi_validation/bloc/npi_event.dart';
import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';

class CorporateAffiliationModel {
  final BuildContext context;

  CorporateAffiliationModel(this.context);

  TextEditingController mOrganizationNameController = TextEditingController();
  TextEditingController mYearsOfCoachingController = TextEditingController();
  TextEditingController mNpiController = TextEditingController();
  TextEditingController mCorporateAddress1Controller = TextEditingController();
  TextEditingController mCorporateAddress2Controller = TextEditingController();
  TextEditingController mCityController = TextEditingController();
  TextEditingController mStateController = TextEditingController();
  TextEditingController mZipcodeController = TextEditingController();
  TextEditingController mCountryController = TextEditingController();
  String selectedTypeOfEngagement = "";

  bool organizationValidator = false;
  bool yearsOfCoachingValidator = false;
  bool corporateAdd1Validator = false;
  bool cityValidator = false;
  bool stateValidator = false;
  bool zipcodeValidator = false;
  bool countryValidator = false;
  bool typeOfEngagementValidator = false;
  bool npiValidator = false;

  List<String> sMenuItems = [
    "Engagement 1",
    "Engagement 2",
  ];

  setSelectedTypeOfEngagement(String value) {
    selectedTypeOfEngagement = value;
  }

  bool isValidOrgName() {
    return !mOrganizationNameController.text.isNotEmpty;
  }

  bool isValidNpi() {
    return !mNpiController.text.isNotEmpty;
  }

  bool isValidYearOfCoaching() {
    return !mYearsOfCoachingController.text.isNotEmpty;
  }

  bool isValidAdd1() {
    return !mCorporateAddress1Controller.text.isNotEmpty;
  }

  bool isValidCity() {
    return !mCityController.text.isNotEmpty;
  }

  bool isValidState() {
    return !mStateController.text.isNotEmpty;
  }

  bool isValidZipcode() {
    return !mZipcodeController.text.isNotEmpty;
  }

  bool isValidCountry() {
    return !mCountryController.text.isNotEmpty;
  }

  bool isValidTypeOfEngagement() {
    return !selectedTypeOfEngagement.isNotEmpty;
  }

  validateAllFields() {
    organizationValidator = isValidOrgName();
    typeOfEngagementValidator = isValidTypeOfEngagement();
    yearsOfCoachingValidator = isValidYearOfCoaching();
    corporateAdd1Validator = isValidAdd1();
    cityValidator = isValidCity();
    stateValidator = isValidState();
    zipcodeValidator = isValidZipcode();
    countryValidator = isValidCountry();
    npiValidator = isValidNpi();
  }

  late CorporateAffiliationBloc _mCorporateAffiliationBloc;
  late AddressBloc _mAddressBloc;
  late NpiBloc _mNpiBloc;

  setTivraHealthLoginScreenBloc() {
    _mCorporateAffiliationBloc = CorporateAffiliationBloc();
    _mAddressBloc = AddressBloc();
    _mNpiBloc = NpiBloc();
  }

  getCorporateBloc() {
    return _mCorporateAffiliationBloc;
  }

  getAddressBloc() {
    return _mAddressBloc;
  }

  getNpiBloc() {
    return _mNpiBloc;
  }

  Future<void> putCorporateAffiliation() async {
    String userId = await SharedPrefs().getUserId();
    await NetworkUtils().checkInternetConnection().then((isInternetAvailable) {
      if (isInternetAvailable) {
        _mCorporateAffiliationBloc.add(CorporateAffiliationClickEvent(
            mCorporateAffiliationListRequest: CorporateAffiliationRequest(
                formData: FormData(
                    userId: userId,
                    zip: mZipcodeController.text,
                    state: mStateController.text,
                    registrationId: 3,
                    country: mCountryController.text,
                    city: mCityController.text,
                    address1: mCorporateAddress1Controller.text,
                    address2: mCorporateAddress2Controller.text,
                    npiNumber: mNpiController.text,
                    organizationName: mOrganizationNameController.text,
                    trackHealth: "true",
                    typeOfEngagement: selectedTypeOfEngagement,
                    yearsOfCoaching:
                        int.parse(mYearsOfCoachingController.text)))));
      } else {
        AppAlert.showSnackBar(context, MessageConstants.noInternetConnection);
      }
    });
  }

  Future<void> putAddress() async {
    List<String> addressLines = [];
    addressLines.add(mCorporateAddress1Controller.text);
    await NetworkUtils().checkInternetConnection().then((isInternetAvailable) {
      if (isInternetAvailable) {
        _mAddressBloc.add(AddressClickEvent(
            mAddressListRequest:
                AddressRequest(address: Address(addressLines: addressLines))));
      } else {
        AppAlert.showSnackBar(context, MessageConstants.noInternetConnection);
      }
    });
  }

  Future<void> getNpi() async {
    await NetworkUtils().checkInternetConnection().then((isInternetAvailable) {
      if (isInternetAvailable) {
        _mNpiBloc.add(NpiClickEvent(mNpiListRequest: mNpiController.text));
      } else {
        AppAlert.showSnackBar(context, MessageConstants.noInternetConnection);
      }
    });
  }
}
