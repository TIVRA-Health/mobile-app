import 'package:flutter/material.dart';
import 'package:tivra_health/common/alert/app_alert.dart';
import 'package:tivra_health/common/message_constants.dart';
import 'package:tivra_health/common/utils/network_utils.dart';
import 'package:tivra_health/common/utils/utils.dart';
import 'package:tivra_health/data/all_bloc/reset_password/bloc/reset_password_bloc.dart';
import 'package:tivra_health/data/all_bloc/reset_password/bloc/reset_password_event.dart';
import 'package:tivra_health/data/all_bloc/reset_password/repo/reset_password_request.dart';

class ResetPasswordScreenModel {
  final BuildContext context;
  ResetPasswordScreenModel(this.context);

  TextEditingController mUserNameTextEditingController  = TextEditingController();
  TextEditingController mPasswordTextEditingController  = TextEditingController();
  TextEditingController mConfirmPasswordTextEditingController  = TextEditingController();
  bool pwdValidator = false;
  bool confirmPwdValidator = false;

  late ResetPasswordBloc _mResetPasswordBloc;

  setTivraHealthRegisterScreenBloc() {
    _mResetPasswordBloc = ResetPasswordBloc();
  }

  getResetPasswordBloc() {
    return _mResetPasswordBloc;
  }

  bool validatePassword() {
    return !isValidPassword(mPasswordTextEditingController.text);
  }

  bool validateConfirmPassword() {
    return !isValidConfirmPassword(
        mPasswordTextEditingController.text, mConfirmPasswordTextEditingController.text);
  }

  validatePasswordFields() {
    pwdValidator = validatePassword();
    confirmPwdValidator = validateConfirmPassword();
  }

  Future<void> tivraHealthResetPassword(String email) async {
    await NetworkUtils().checkInternetConnection().then((isInternetAvailable) {
      if (isInternetAvailable) {
        _mResetPasswordBloc.add(
            ResetPasswordClickEvent(
                mResetPasswordListRequest:
                ResetPasswordRequest(
                    email: email,
                    password: mPasswordTextEditingController.text)));
      } else {
        AppAlert.showSnackBar(
            context, MessageConstants.noInternetConnection);
      }
    });
  }

}