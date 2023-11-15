import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tivra_health/common/alert/app_alert.dart';
import 'package:tivra_health/common/message_constants.dart';
import 'package:tivra_health/common/utils/network_utils.dart';
import 'package:tivra_health/common/utils/utils.dart';
import 'package:tivra_health/data/all_bloc/request_otp/bloc/tivra_health_register_screen_otp_bloc.dart';
import 'package:tivra_health/data/all_bloc/request_otp/bloc/tivra_health_register_screen_otp_event.dart';
import 'package:tivra_health/data/all_bloc/request_otp/repo/tivra_health_register_screen_otp_request.dart';
import 'package:tivra_health/data/all_bloc/verify_otp/bloc/tivra_health_register_screen_verify_otp_bloc.dart';
import 'package:tivra_health/data/all_bloc/verify_otp/bloc/tivra_health_register_screen_verify_otp_event.dart';
import 'package:tivra_health/data/all_bloc/verify_otp/repo/tivra_health_register_screen_verify_otp_request.dart';

class ForgotPasswordScreenModel {
  final BuildContext context;

  ForgotPasswordScreenModel(this.context);

  TextEditingController mUserNameTextEditingController = TextEditingController();
  TextEditingController mPasswordTextEditingController = TextEditingController();
  TextEditingController mOTPController = TextEditingController();
  bool emailValidator = false;
  bool otpValidator = false;

  late TivraHealthRegisterScreenOTPBloc _mTivraHealthRegisterScreenOTPBloc;
  late TivraHealthRegisterScreenVerifyOTPBloc _mTivraHealthRegisterScreenVerifyOTPBloc;

  setTivraHealthRegisterScreenBloc() {
    _mTivraHealthRegisterScreenOTPBloc = TivraHealthRegisterScreenOTPBloc();
    _mTivraHealthRegisterScreenVerifyOTPBloc = TivraHealthRegisterScreenVerifyOTPBloc();
  }

  getTivraHealthRegisterScreenOTPBloc() {
    return _mTivraHealthRegisterScreenOTPBloc;
  }

  getHealthRegisterScreenVerifyOTPBloc() {
    return _mTivraHealthRegisterScreenVerifyOTPBloc;
  }

  bool validateEmail() {
    return !isValidEmail(mUserNameTextEditingController.text);
  }

  validateAllRequiredInitialFields() {
    emailValidator = validateEmail();
  }

  bool validateOTP() {
    return !isValidOTP(mOTPController.text);
  }

  validateOTPField() {
    otpValidator = validateOTP();
  }

  Future<void> tivraHealthRegisterScreenSendOTP() async {
    await NetworkUtils().checkInternetConnection().then((isInternetAvailable) {
      if (isInternetAvailable) {
        _mTivraHealthRegisterScreenOTPBloc.add(
            TivraHealthRegisterScreenClickOTPEvent(
                mTivraHealthRegisterScreenOTPListRequest:
                TivraHealthRegisterScreenOTPRequest(
                    emailId: mUserNameTextEditingController.text.toString(),
                    flow: "password-reset")));
      } else {
        AppAlert.showSnackBar(
            context, MessageConstants.noInternetConnection);
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
                    emailId: mUserNameTextEditingController.text.toString(), otp: mOTPController.text.toString())));
      } else {
        AppAlert.showSnackBar(
            context, MessageConstants.noInternetConnection);
      }
    });
  }
}