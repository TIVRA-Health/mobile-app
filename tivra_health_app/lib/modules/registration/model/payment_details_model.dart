import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tivra_health/common/alert/app_alert.dart';
import 'package:tivra_health/common/message_constants.dart';
import 'package:tivra_health/common/utils/network_utils.dart';
import 'package:tivra_health/data/all_bloc/payment_link/bloc/tivra_health_payment_link_bloc.dart';
import 'package:tivra_health/data/all_bloc/payment_link/bloc/tivra_health_payment_link_event.dart';
import 'package:tivra_health/data/all_bloc/payment_link/repo/tivra_health_payment_link_request.dart';
import 'package:tivra_health/data/all_bloc/payment_methods/bloc/payment_methods_bloc.dart';
import 'package:tivra_health/data/all_bloc/payment_methods/bloc/payment_methods_event.dart';
import 'package:tivra_health/data/all_bloc/payment_methods/repo/payment_methods_response.dart';
import 'package:tivra_health/data/all_bloc/user_role/bloc/tivra_health_user_role_bloc.dart';
import 'package:tivra_health/data/all_bloc/user_role/bloc/tivra_health_user_role_event.dart';
import 'package:tivra_health/data/all_bloc/user_role/repo/tivra_health_user_role_request.dart';
import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';

class PaymentDetailsModel {
  final BuildContext cBuildContext;
  PaymentDetailsModel(this.cBuildContext);

  bool showPricing = false;
  int selectedItem = -1;
  bool selectedItemValidator = false;
  List<PaymentPlans> paymentPlans = [];
  String selectedRole = "";
  int corporateAffiliation = -1;
  int roleId = -1;

  setSelectedRole(String role) {
    selectedRole = role;
  }

  getSelectedRole() {
    return selectedRole;
  }

  List<String> sMenuItems = [];

  late PaymentMethodsBloc _mPaymentMethodsBloc;
  late TivraHealthUserRoleBloc _mTivraHealthUserRoleBloc;
  late TivraHealthPaymentLinkBloc _mTivraHealthPaymentLinkBloc;

  setTivraHealthRegisterScreenBloc() {
    _mPaymentMethodsBloc = PaymentMethodsBloc();
    _mTivraHealthUserRoleBloc = TivraHealthUserRoleBloc();
    _mTivraHealthPaymentLinkBloc = TivraHealthPaymentLinkBloc();
  }

  getPaymentMethodsBloc() {
    return _mPaymentMethodsBloc;
  }

  getUserRoleBloc() {
    return _mTivraHealthUserRoleBloc;
  }

  getPaymentLinkBloc() {
    return _mTivraHealthPaymentLinkBloc;
  }

  Future<void> getRoles() async {
    PaymentMethodsResponse paymentResponse;
    await SharedPrefs().getPaymentMethods().then((value) => {
      paymentResponse = PaymentMethodsResponse.fromJson(json.decode(value)),
      paymentResponse.data?.forEach((element) {
        sMenuItems.add(element.roleName!);
      })
    });
  }

  Future<void> getPricing() async {
    PaymentMethodsResponse paymentResponse;
    paymentPlans.clear();
    await SharedPrefs().getPaymentMethods().then((value) => {
      paymentResponse = PaymentMethodsResponse.fromJson(json.decode(value)),
      paymentResponse.data?.forEach((element) {
        if(element.roleName == selectedRole) {
          roleId = element.id!;
          corporateAffiliation = element.corporateAffiliation!;
          element.paymentPlans?.forEach((plans) {
            paymentPlans.add(plans);
          });
        }
      })
    });
  }

  Future<void> paymentMethod() async {
    await NetworkUtils().checkInternetConnection().then((isInternetAvailable) {
      if (isInternetAvailable) {
        _mPaymentMethodsBloc.add(
            const PaymentMethodsClickEvent());
      } else {
        AppAlert.showSnackBar(
            cBuildContext, MessageConstants.noInternetConnection);
      }
    });
  }

  Future<void> getPaymentLink() async {
    String userId = await SharedPrefs().getUserId();
    await NetworkUtils().checkInternetConnection().then((isInternetAvailable) {
      if (isInternetAvailable) {
        _mTivraHealthPaymentLinkBloc.add(
            TivraHealthPaymentLinkClickEvent(mTivraHealthPaymentLinkListRequest: TivraHealthPaymentLinkRequest(
              userId: userId, priceId: paymentPlans[selectedItem].stripeProductPriceId
            )));
      } else {
        AppAlert.showSnackBar(
            cBuildContext, MessageConstants.noInternetConnection);
      }
    });
  }

  Future<void> selectUserRole() async {
    String userId = await SharedPrefs().getUserId();
    await NetworkUtils().checkInternetConnection().then((isInternetAvailable) {
      if (isInternetAvailable) {
        _mTivraHealthUserRoleBloc.add(
            TivraHealthUserRoleClickEvent(mTivraHealthRUserRoleListRequest: TivraHealthUserRoleRequest(
              planId: paymentPlans[selectedItem].id,userId: userId, registrationId: 2, roleId: roleId
            )));
      } else {
        AppAlert.showSnackBar(
            cBuildContext, MessageConstants.noInternetConnection);
      }
    });
  }

  validateItem() {
    selectedItemValidator = (selectedItem == -1);
  }

}