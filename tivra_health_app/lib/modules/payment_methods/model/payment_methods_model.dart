import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tivra_health/common/alert/app_alert.dart';
import 'package:tivra_health/common/app_constants.dart';
import 'package:tivra_health/common/message_constants.dart';
import 'package:tivra_health/common/utils/network_utils.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tivra_health/data/all_bloc/payment_methods/bloc/payment_methods_bloc.dart';
import 'package:tivra_health/data/all_bloc/payment_methods/bloc/payment_methods_event.dart';
import 'package:tivra_health/data/all_bloc/payment_methods/bloc/payment_methods_state.dart';
import 'package:tivra_health/data/all_bloc/payment_methods/repo/payment_methods_response.dart';

class PaymentMethodsModel {
  final BuildContext mBuildContext;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  PaymentMethodsModel(this.mBuildContext);

  /// PaymentMethods Api
  late PaymentMethodsBloc _mPaymentMethodsBloc;

  setPaymentMethodsBloc() {
    _mPaymentMethodsBloc = PaymentMethodsBloc();
  }

  getPaymentMethodsBloc() {
    return _mPaymentMethodsBloc;
  }

  onRefresh() async {
    initPaymentMethods();
  }

  Future<void> initPaymentMethods() async {
    await NetworkUtils().checkInternetConnection().then((isInternetAvailable) {
      if (isInternetAvailable) {
        _mPaymentMethodsBloc
            .add(const PaymentMethodsClickEvent());
      } else {
        AppAlert.showSnackBar(
            mBuildContext, MessageConstants.noInternetConnection);
      }
    });
  }

  blocPaymentMethodsListener(
      BuildContext context, PaymentMethodsState state) {
    switch (state.status) {
      case PaymentMethodsStatus.loading:
        AppAlert.showProgressDialog(context);
        break;
      case PaymentMethodsStatus.failed:
        loadEnd();
        if (state.webResponseFailed != null) {
          AppAlert.showSnackBar(
              context, state.webResponseFailed!.statusMessage ?? "");
        } else {
          AppAlert.showSnackBar(
              mBuildContext, AppConstants.mWordConstants.wSomethingWentWrong);
        }
        break;
      case PaymentMethodsStatus.success:
        print("##payment##${jsonEncode(state.mPaymentMethodsResponse!)}");
        setList(state.mPaymentMethodsResponse!);
        loadEnd();
        break;
    }
  }

  void loadEnd() {
    AppAlert.closeDialog(mBuildContext);
  }

  /// PaymentMethodsState

  var responseSubject = PublishSubject<PaymentMethodsResponse?>();

  Stream<PaymentMethodsResponse?> get responseStream =>
      responseSubject.stream;

  void closeObservable() {
    responseSubject.close();
  }

  void setList(PaymentMethodsResponse state) async {
    try {
      responseSubject.sink.add(state);
    } catch (e) {
      responseSubject.sink.addError(e);
    }
  }
}
