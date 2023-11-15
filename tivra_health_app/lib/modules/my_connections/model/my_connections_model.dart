import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tivra_health/common/alert/app_alert.dart';
import 'package:tivra_health/common/app_constants.dart';
import 'package:tivra_health/common/message_constants.dart';
import 'package:tivra_health/common/utils/network_utils.dart';
import 'package:tivra_health/data/all_bloc/get_user_details/repo/get_user_details_response.dart';
import 'package:tivra_health/data/all_bloc/invite/bloc/invite_bloc.dart';
import 'package:tivra_health/data/all_bloc/invite/bloc/invite_event.dart';
import 'package:tivra_health/data/all_bloc/invite/bloc/invite_state.dart';
import 'package:tivra_health/data/all_bloc/invite/repo/invite_request.dart';
import 'package:tivra_health/data/all_bloc/invite_receive/bloc/invite_receive_bloc.dart';
import 'package:tivra_health/data/all_bloc/invite_receive/bloc/invite_receive_event.dart';
import 'package:tivra_health/data/all_bloc/invite_receive/bloc/invite_receive_state.dart';
import 'package:tivra_health/data/all_bloc/invite_sent/bloc/invite_sent_bloc.dart';
import 'package:tivra_health/data/all_bloc/invite_sent/bloc/invite_sent_event.dart';
import 'package:tivra_health/data/all_bloc/invite_sent/bloc/invite_sent_state.dart';
import 'package:tivra_health/data/all_bloc/invite_sent/repo/invite_sent_response.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tivra_health/data/all_bloc/invite_update/bloc/invite_update_bloc.dart';
import 'package:tivra_health/data/all_bloc/invite_update/bloc/invite_update_event.dart';
import 'package:tivra_health/data/all_bloc/invite_update/bloc/invite_update_state.dart';
import 'package:tivra_health/data/all_bloc/invite_update/repo/invite_update_request.dart';
import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';

class MyConnectionsModel {
  final BuildContext mContext;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  final Function onRefreshPage;

  MyConnectionsModel(this.mContext, this.onRefreshPage);

  TextEditingController mUserNameTextEditingController =
      TextEditingController();
  TextEditingController mSubjectTextEditingController = TextEditingController();

  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  int onRefreshView = 0;

  onRefresh() async {
    onRefreshView = 1;
    if (sSelectValue == AppConstants.mWordConstants.wMyInvites) {
      initInviteSent();
    } else {
      initInviteReceive();
    }
  }

  void loadEnd() {
    AppAlert.closeDialog(mContext);
    if (onRefreshView == 0) {
      // AppAlert.closeDialog(mContext);
    } else if (onRefreshView == 1) {
      refreshController.refreshCompleted();
    } else if (onRefreshView == 2) {
      refreshController.loadComplete();
    }
    onRefreshPage();
  }

  // List<String> mMyTeamList = [];

  String sSelectValue = AppConstants.mWordConstants.wMyInvites;

  ///UsrDetails
  late GetUserDetailsResponse mGetUserDetailsResponse;

  getUsrDetails() async {
    String sUserDetails = await SharedPrefs().getUserDetails();
    print("###sUserDetails### ${sUserDetails}");
    mGetUserDetailsResponse =
        GetUserDetailsResponse.fromJson(jsonDecode(sUserDetails));
  }

  /// InviteSent Api
  late InviteSentBloc _mInviteSentBloc;

  setInviteSentBloc() {
    _mInviteSentBloc = InviteSentBloc();
  }

  getInviteSentBloc() {
    return _mInviteSentBloc;
  }

  callInviteSent() async {
    onRefreshView = 0;
    initInviteSent();
  }

  Future<void> initInviteSent() async {
    await NetworkUtils().checkInternetConnection().then((isInternetAvailable) {
      if (isInternetAvailable) {
        _mInviteSentBloc.add(InviteSentClickEvent(
            mStringRequest: mGetUserDetailsResponse.userId ?? "0"));
      } else {
        AppAlert.showSnackBar(mContext, MessageConstants.noInternetConnection);
      }
    });
  }

  blocInviteSentListener(BuildContext context, InviteSentState state) {
    switch (state.status) {
      case InviteSentStatus.loading:
        AppAlert.showProgressDialog(context);
        break;
      case InviteSentStatus.failed:
        loadEnd();
        if (state.webResponseFailed != null) {
          AppAlert.showSnackBar(
              context, state.webResponseFailed!.statusMessage ?? "");
        } else {
          AppAlert.showSnackBar(
              mContext, AppConstants.mWordConstants.wSomethingWentWrong);
        }
        break;
      case InviteSentStatus.success:
        setInviteSentList(state.mInviteSentResponse!);
        loadEnd();
        break;
    }
  }

  /// InviteReceive Api
  late InviteReceiveBloc _mInviteReceiveBloc;

  setInviteReceiveBloc() {
    _mInviteReceiveBloc = InviteReceiveBloc();
  }

  getInviteReceiveBloc() {
    return _mInviteReceiveBloc;
  }

  callInviteReceive() async {
    onRefreshView = 0;
    initInviteReceive();
  }

  Future<void> initInviteReceive() async {
    await NetworkUtils().checkInternetConnection().then((isInternetAvailable) {
      if (isInternetAvailable) {
        _mInviteReceiveBloc.add(InviteReceiveClickEvent(
            mStringRequest: mGetUserDetailsResponse.userId ?? "0"));
      } else {
        AppAlert.showSnackBar(mContext, MessageConstants.noInternetConnection);
      }
    });
  }

  blocInviteReceiveListener(BuildContext context, InviteReceiveState state) {
    switch (state.status) {
      case InviteReceiveStatus.loading:
        AppAlert.showProgressDialog(context);
        break;
      case InviteReceiveStatus.failed:
        loadEnd();
        if (state.webResponseFailed != null) {
          AppAlert.showSnackBar(
              context, state.webResponseFailed!.statusMessage ?? "");
        } else {
          AppAlert.showSnackBar(
              mContext, AppConstants.mWordConstants.wSomethingWentWrong);
        }
        break;
      case InviteReceiveStatus.success:
        setInviteSentList(state.mInviteReceiveResponse!);
        loadEnd();
        break;
    }
  }

  /// InviteSentState

  var responseSubjectInviteSent = PublishSubject<InviteSentResponse?>();

  Stream<InviteSentResponse?> get responseStreamInviteSent =>
      responseSubjectInviteSent.stream;

  void closeObservableInviteSent() {
    responseSubjectInviteSent.close();
  }

  void setInviteSentList(InviteSentResponse state) async {
    try {
      responseSubjectInviteSent.sink.add(state);
    } catch (e) {
      responseSubjectInviteSent.sink.addError(e);
    }
  }

  ///InviteUpdate

  late InviteUpdateBloc _mInviteUpdateBloc;

  setInviteUpdateBloc() {
    _mInviteUpdateBloc = InviteUpdateBloc();
  }

  getInviteUpdateBloc() {
    return _mInviteUpdateBloc;
  }

  Future<void> fetchInviteUpdateUrl(String userId, bool bValue) async {
    await NetworkUtils().checkInternetConnection().then((isInternetAvailable) {
      if (isInternetAvailable) {
        InviteUpdateRequest mInviteUpdateRequest = bValue
            ? InviteUpdateRequest(
                id: userId, //mGetUserDetailsResponse.userId ?? "0",
                isApproved: bValue.toString())
            : InviteUpdateRequest(
                id: userId, //mGetUserDetailsResponse.userId ?? "0",
                status: bValue.toString());
        _mInviteUpdateBloc.add(InviteUpdateClickEvent(
            mInviteUpdateListRequest: mInviteUpdateRequest));
      } else {
        AppAlert.showSnackBar(mContext, MessageConstants.noInternetConnection);
      }
    });
  }

  blocInviteUpdateListener(
      BuildContext context, InviteUpdateState state) async {
    switch (state.status) {
      case InviteUpdateStatus.loading:
        AppAlert.showProgressDialog(context);
        break;
      case InviteUpdateStatus.failed:
        AppAlert.closeDialog(context);
        AppAlert.showSnackBar(
            context, state.webResponseFailed?.statusMessage ?? "");
        break;
      case InviteUpdateStatus.success:
        AppAlert.closeDialog(context);
        if (state.mInviteUpdateResponse?.message != null) {
          AppAlert.showSnackBar(
              context, state.mInviteUpdateResponse?.message ?? "");
        }
        onRefreshView = 0;
        initInviteReceive();
        break;
    }
  }

  ///Invite

  late InviteBloc _mInviteBloc;

  setInviteBloc() {
    _mInviteBloc = InviteBloc();
  }

  getInviteBloc() {
    return _mInviteBloc;
  }

  Future<void> fetchInviteUrl() async {
    await NetworkUtils().checkInternetConnection().then((isInternetAvailable) {
      if (isInternetAvailable) {
        _mInviteBloc.add(InviteClickEvent(
            mInviteListRequest: InviteRequest(
                senderUserId: mGetUserDetailsResponse.userId ?? "0",
                senderEmail: mGetUserDetailsResponse.email ?? "",
                inviteEmail: mUserNameTextEditingController.text,
                subject: mSubjectTextEditingController.text)));
      } else {
        AppAlert.showSnackBar(mContext, MessageConstants.noInternetConnection);
      }
    });
  }

  Future<void> fetchResentUrl(String usrEmail,String subject) async {
    await NetworkUtils().checkInternetConnection().then((isInternetAvailable) {
      if (isInternetAvailable) {
        _mInviteBloc.add(InviteClickEvent(
            mInviteListRequest: InviteRequest(
                senderUserId: mGetUserDetailsResponse.userId ?? "0",
                senderEmail: mGetUserDetailsResponse.email ?? "",
                inviteEmail: usrEmail,
                subject: subject)));
      } else {
        AppAlert.showSnackBar(mContext, MessageConstants.noInternetConnection);
      }
    });
  }

  blocInviteListener(BuildContext context, InviteState state) async {
    switch (state.status) {
      case InviteStatus.loading:
        AppAlert.showProgressDialog(context);
        break;
      case InviteStatus.failed:
        AppAlert.closeDialog(context);
        AppAlert.showSnackBar(
            context, state.webResponseFailed?.statusMessage ?? "");
        break;
      case InviteStatus.success:
        AppAlert.closeDialog(context);
        if (state.mInviteResponse?.acknowledged == "true") {
          AppAlert.showSnackBar(context, "New invite success sent");
          if (sSelectValue == AppConstants.mWordConstants.wMyInvites) {
            onRefreshView = 0;
            initInviteSent();
          }
        } else {
          AppAlert.showSnackBar(context, state.mInviteResponse?.message ?? "");
        }
        break;
    }
  }
}
