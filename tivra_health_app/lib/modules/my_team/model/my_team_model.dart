import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tivra_health/common/alert/app_alert.dart';
import 'package:tivra_health/common/app_constants.dart';
import 'package:tivra_health/common/color_constants.dart';
import 'package:tivra_health/common/message_constants.dart';
import 'package:tivra_health/common/size_constants.dart';
import 'package:tivra_health/common/text_styles_constants.dart';
import 'package:tivra_health/common/utils/network_utils.dart';
import 'package:tivra_health/data/all_bloc/my_team_list/bloc/my_team_list_bloc.dart';
import 'package:tivra_health/data/all_bloc/my_team_list/bloc/my_team_list_event.dart';
import 'package:tivra_health/data/all_bloc/my_team_list/bloc/my_team_list_state.dart';
import 'package:tivra_health/data/all_bloc/my_team_list/repo/my_team_list_response.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';

class MyTeamScreenModel {
  final BuildContext context;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  final Function onRefreshPage;

  MyTeamScreenModel(this.context, this.onRefreshPage);

  List<String> listDropdownData = [
    "Daily",
    // "Live",
    // "Monthly",
  ];
  String selectedValue = "Daily";

  List<DropdownMenuItem<String>> createList(List<String> paymentTypeList) {
    return paymentTypeList
        .map<DropdownMenuItem<String>>(
          (value) => DropdownMenuItem(
            value: value,
            child: Container(
              color: ColorConstants.cSideMenuSelectText,
              width: SizeConstants.s1 * 90,
              child: Text(
                value ?? "",
                style: getTextMedium(
                  colors: ColorConstants.cWhite,
                  size: SizeConstants.s1 * 16,
                ),
              ),
            ),
          ),
        )
        .toList();
  }

  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  int onRefreshView = 0;

  callApi() async {
    String sUserId = await SharedPrefs().getUserId();
    initMyTeamList(sUserId);
  }

  onRefresh() async {
    String sUserId = await SharedPrefs().getUserId();
    onRefreshView = 1;
    mMyTeamList.clear();
    initMyTeamList(sUserId);
  }

  List<MyTeamListData> mMyTeamList = [];

  /// MyTeamList Api
  late MyTeamListBloc _mMyTeamListBloc;

  setMyTeamListBloc() {
    _mMyTeamListBloc = MyTeamListBloc();
  }

  getMyTeamListBloc() {
    return _mMyTeamListBloc;
  }

  Future<void> initMyTeamList(String sUserId) async {
    await NetworkUtils().checkInternetConnection().then((isInternetAvailable) {
      if (isInternetAvailable) {
        _mMyTeamListBloc.add(MyTeamListClickEvent(mStringRequest: sUserId));
      } else {
        AppAlert.showSnackBar(context, MessageConstants.noInternetConnection);
      }
    });
  }

  blocMyTeamListListener(BuildContext context, MyTeamListState state) {
    switch (state.status) {
      case MyTeamListStatus.loading:
        if (onRefreshView == 0) {
          AppAlert.showProgressDialog(context);
        }
        break;
      case MyTeamListStatus.failed:
        loadEnd();
        if (state.webResponseFailed != null) {
          AppAlert.showSnackBar(
              context, state.webResponseFailed!.statusMessage ?? "");
        } else {
          AppAlert.showSnackBar(
              context, AppConstants.mWordConstants.wSomethingWentWrong);
        }
        break;
      case MyTeamListStatus.success:
        mMyTeamList.addAll(state.mMyTeamListResponse?.data ?? []);
        setList(state.mMyTeamListResponse!);
        loadEnd();
        break;
    }
  }

  void loadEnd() {
    if (onRefreshView == 0) {
      AppAlert.closeDialog(context);
    } else if (onRefreshView == 1) {
      refreshController.refreshCompleted();
    } else if (onRefreshView == 2) {
      refreshController.loadComplete();
    }
    onRefreshPage();
  }

  /// MyTeamListState

  var responseSubject = PublishSubject<MyTeamListResponse?>();

  Stream<MyTeamListResponse?> get responseStream => responseSubject.stream;

  void closeObservable() {
    responseSubject.close();
  }

  void setList(MyTeamListResponse state) async {
    try {
      responseSubject.sink.add(state);
    } catch (e) {
      responseSubject.sink.addError(e);
    }
  }
}
