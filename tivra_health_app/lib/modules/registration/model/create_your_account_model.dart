import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:tivra_health/common/alert/app_alert.dart';
import 'package:tivra_health/common/message_constants.dart';
import 'package:tivra_health/common/utils/network_utils.dart';
import 'package:tivra_health/common/utils/utils.dart';
import 'package:tivra_health/data/all_bloc/create_account/bloc/tivra_health_create_account_event.dart';
import 'package:tivra_health/data/all_bloc/create_account/repo/tivra_health_create_account_request.dart';
import 'package:tivra_health/data/all_bloc/payment_methods/bloc/payment_methods_bloc.dart';
import 'package:tivra_health/data/all_bloc/payment_methods/bloc/payment_methods_event.dart';
import 'package:tivra_health/data/all_bloc/request_otp/bloc/tivra_health_register_screen_otp_event.dart';
import 'package:tivra_health/data/all_bloc/tivra_health_registration/bloc/tivra_health_register_screen_bloc.dart';
import 'package:tivra_health/data/all_bloc/tivra_health_registration/bloc/tivra_health_register_screen_event.dart';
import 'package:tivra_health/data/all_bloc/request_otp/bloc/tivra_health_register_screen_otp_bloc.dart';
import 'package:tivra_health/data/all_bloc/tivra_health_registration/bloc/tivra_health_register_screen_state.dart';
import 'package:tivra_health/data/all_bloc/request_otp/repo/tivra_health_register_screen_otp_request.dart';
import 'package:tivra_health/data/all_bloc/tivra_health_registration/repo/tivra_health_register_screen_request.dart';
import 'package:tivra_health/data/all_bloc/verify_otp/bloc/tivra_health_register_screen_verify_otp_bloc.dart';
import 'package:tivra_health/data/all_bloc/verify_otp/bloc/tivra_health_register_screen_verify_otp_event.dart';
import 'package:tivra_health/data/all_bloc/verify_otp/repo/tivra_health_register_screen_verify_otp_request.dart';
import 'package:tivra_health/data/all_bloc/create_account/bloc/tivra_health_create_account_bloc.dart';
import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';

class CreateYourAccountModel {
  final BuildContext cBuildContext;

  CreateYourAccountModel(this.cBuildContext);

  TextEditingController mFirstNameController = TextEditingController();
  TextEditingController mLastNameController = TextEditingController();
  TextEditingController mMiddleNameController = TextEditingController();
  TextEditingController mEmailController = TextEditingController();
  TextEditingController mPhoneNumberController = TextEditingController();
  TextEditingController mOTPController = TextEditingController();
  TextEditingController mPasswordController = TextEditingController();
  TextEditingController mConfirmPasswordController = TextEditingController();

  bool continueToOTP = false;
  bool verifiedOTP = false;
  bool initialFieldsContinue = true;
  bool disableVerifyBtn = true;
  bool disableEmail = false;

  bool emailValidator = false;
  bool firstNameValidator = false;
  bool lastNameValidator = false;
  bool mobileNumberValidator = false;
  bool otpValidator = false;
  bool pwdValidator = false;
  bool confirmPwdValidator = false;

  bool validateEmail() {
    return !isValidEmail(mEmailController.text);
  }

  bool validateFirstName() {
    return !mFirstNameController.text.isNotEmpty;
  }

  bool validateLastName() {
    return !mLastNameController.text.isNotEmpty;
  }

  bool validateMobileNumber() {
    return !mPhoneNumberController.text.isNotEmpty;
  }

  bool validateOTP() {
    return !isValidOTP(mOTPController.text);
  }

  bool validatePassword() {
    return !isValidPassword(mPasswordController.text);
  }

  bool validateConfirmPassword() {
    return !isValidConfirmPassword(
        mPasswordController.text, mConfirmPasswordController.text);
  }

  validateAllRequiredInitialFields() {
    emailValidator = validateEmail();
    firstNameValidator = validateFirstName();
    lastNameValidator = validateLastName();
    mobileNumberValidator = validateMobileNumber();
  }

  validateOTPField() {
    otpValidator = validateOTP();
  }

  validatePasswordFields() {
    pwdValidator = validatePassword();
    confirmPwdValidator = validateConfirmPassword();
  }

  ///TivraHealthRegisterScreen
  late TivraHealthRegisterScreenBloc _mTivraHealthRegisterScreenBloc;
  late TivraHealthRegisterScreenOTPBloc _mTivraHealthRegisterScreenOTPBloc;
  late TivraHealthRegisterScreenVerifyOTPBloc _mTivraHealthRegisterScreenVerifyOTPBloc;
  late TivraHealthCreateAccountBloc _mTivraHealthCreateAccountBloc;

  setTivraHealthRegisterScreenBloc() {
    _mTivraHealthRegisterScreenBloc = TivraHealthRegisterScreenBloc();
    _mTivraHealthRegisterScreenOTPBloc = TivraHealthRegisterScreenOTPBloc();
    _mTivraHealthRegisterScreenVerifyOTPBloc = TivraHealthRegisterScreenVerifyOTPBloc();
    _mTivraHealthCreateAccountBloc = TivraHealthCreateAccountBloc();
  }

  getTivraHealthRegisterScreenBloc() {
    return _mTivraHealthRegisterScreenBloc;
  }

  getTivraHealthRegisterScreenOTPBloc() {
    return _mTivraHealthRegisterScreenOTPBloc;
  }

  getHealthRegisterScreenVerifyOTPBloc() {
    return _mTivraHealthRegisterScreenVerifyOTPBloc;
  }

  getTivraHealthCreateAccountBloc() {
    return _mTivraHealthCreateAccountBloc;
  }

  Future<void> fetchTivraHealthRegisterScreenUrl() async {
    await NetworkUtils().checkInternetConnection().then((isInternetAvailable) {
      if (isInternetAvailable) {
        _mTivraHealthRegisterScreenBloc.add(TivraHealthRegisterScreenClickEvent(
            mTivraHealthRegisterScreenListRequest:
                TivraHealthRegisterScreenRequest(
                    firstName: mFirstNameController.text.toString(),
                    middleName: mMiddleNameController.text.toString(),
                    lastName: mLastNameController.text.toString(),
                    email: mEmailController.text.toString(),
                    phoneNumber: mPhoneNumberController.text.toString())));
      } else {
        AppAlert.showSnackBar(
            cBuildContext, MessageConstants.noInternetConnection);
      }
    });
  }

  Future<void> tivraHealthRegisterScreenSendOTP() async {
    await NetworkUtils().checkInternetConnection().then((isInternetAvailable) {
      if (isInternetAvailable) {
        _mTivraHealthRegisterScreenOTPBloc.add(
            TivraHealthRegisterScreenClickOTPEvent(
                mTivraHealthRegisterScreenOTPListRequest:
                    TivraHealthRegisterScreenOTPRequest(
                        emailId: mEmailController.text.toString(), flow: "otp-generate")));
      } else {
        AppAlert.showSnackBar(
            cBuildContext, MessageConstants.noInternetConnection);
      }
    });
  }

  Future<void> tivraHealthRegisterScreenVerifyOTP() async {
    await NetworkUtils().checkInternetConnection().then((isInternetAvailable) {
      if (isInternetAvailable) {
        _mTivraHealthRegisterScreenVerifyOTPBloc.add(
            TivraHealthRegisterScreenClickVerifyOTPEvent(
                mTivraHealthRegisterScreenVerifyOTPListRequest:
                TivraHealthRegisterScreenVerifyOTPRequest(
                    emailId: mEmailController.text.toString(), otp: mOTPController.text.toString())));
      } else {
        AppAlert.showSnackBar(
            cBuildContext, MessageConstants.noInternetConnection);
      }
    });
  }

  Future<void> tivraHealthCreateAccount() async {
    String userId = await SharedPrefs().getUserId();
    String regId = await SharedPrefs().getCorporateAffiliation();
    int registrationId = (regId == "false") ? 1 : 0;
    await NetworkUtils().checkInternetConnection().then((isInternetAvailable) {
      if (isInternetAvailable) {
        _mTivraHealthCreateAccountBloc.add(
            TivraHealthCreateAccountClickEvent(
                mTivraHealthCreateAccountListRequest:
                TivraHealthCreateAccountRequest(userId: userId, otp: mOTPController.text, password: mPasswordController.text, registrationId: 1)));
      } else {
        AppAlert.showSnackBar(
            cBuildContext, MessageConstants.noInternetConnection);
      }
    });
  }

  showNextPage(String nextPage, {bool bRemove = true}) async {
    if (bRemove) {
      Navigator.pushNamedAndRemoveUntil(
          cBuildContext, nextPage, (route) => false);
    } else {
      Navigator.pushNamed(cBuildContext, nextPage);
    }
  }
}
