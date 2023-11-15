import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tivra_health/common/alert/app_alert.dart';
import 'package:tivra_health/common/message_constants.dart';
import 'package:tivra_health/common/utils/network_utils.dart';
import 'package:tivra_health/data/all_bloc/consultation/bloc/consultation_bloc.dart';
import 'package:tivra_health/data/all_bloc/consultation/bloc/consultation_event.dart';
import 'package:tivra_health/data/all_bloc/consultation/repo/consultation_request.dart';
import 'package:tivra_health/data/all_bloc/consultation/repo/consultation_response.dart';
import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';

class ConsultationModel {
  final BuildContext mContext;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  final Function onRefreshPage;

 ConsultationModel(this.mContext,this.onRefreshPage);

  TextEditingController consultController = TextEditingController();
  List<String> allMessages = [];

  final RefreshController refreshController =
  RefreshController(initialRefresh: false);
  int onRefreshView = 0;

  onRefresh() async {
    onRefreshView = 1;
    mMyTeamList.clear();
    mMyTeamList = ["1", "2", "3", "4"];
    Future.delayed(const Duration(seconds: 2), () {
      loadEnd();
    });
  }

  void loadEnd() {
    if (onRefreshView == 0) {
      // AppAlert.hideLoadingDialog(mContext);
    } else if (onRefreshView == 1) {
      refreshController.refreshCompleted();
    } else if (onRefreshView == 2) {
      refreshController.loadComplete();
    }
    onRefreshPage();
  }

  List<String> mMyTeamList = [];

  /// DeviceRegistration Api
  late ConsultationBloc _mConsultationBloc;

  setConsultationBloc() {
    _mConsultationBloc = ConsultationBloc();
  }

  getConsultationBloc() {
    return _mConsultationBloc;
  }

  Future<void> fetchMessage() async {
    await NetworkUtils().checkInternetConnection().then((isInternetAvailable) {
      if (isInternetAvailable) {
        _mConsultationBloc.add(ConsultationClickEvent(
            mConsultationListRequest: ConsultationRequest(message: consultController.text)));
      } else {
        AppAlert.showSnackBar(mContext, MessageConstants.noInternetConnection);
      }
    });
  }

  Future<void> getMessages() async {
    await SharedPrefs().getMessage().then((value) => {
      allMessages.add(value)
    });
  }

}
