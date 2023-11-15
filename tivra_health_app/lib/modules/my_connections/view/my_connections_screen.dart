import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tivra_health/common/alert/app_alert.dart';
import 'package:tivra_health/common/app_constants.dart';
import 'package:tivra_health/common/appbars_constants.dart';
import 'package:tivra_health/common/button_constants.dart';
import 'package:tivra_health/common/color_constants.dart';
import 'package:tivra_health/common/dashboard_common_view.dart';
import 'package:tivra_health/common/image_assets.dart';
import 'package:tivra_health/common/size_constants.dart';
import 'package:tivra_health/common/widget/edit_text_field.dart';
import 'package:tivra_health/common/widget/empty_view/empty_view.dart';
import 'package:tivra_health/common/widget/pull_to_refresh_header_widget.dart';
import 'package:tivra_health/data/all_bloc/invite/bloc/invite_bloc.dart';
import 'package:tivra_health/data/all_bloc/invite/bloc/invite_state.dart';
import 'package:tivra_health/data/all_bloc/invite_receive/bloc/invite_receive_bloc.dart';
import 'package:tivra_health/data/all_bloc/invite_receive/bloc/invite_receive_state.dart';
import 'package:tivra_health/data/all_bloc/invite_sent/bloc/invite_sent_bloc.dart';
import 'package:tivra_health/data/all_bloc/invite_sent/bloc/invite_sent_state.dart';
import 'package:tivra_health/data/all_bloc/invite_sent/repo/invite_sent_response.dart';
import 'package:tivra_health/data/all_bloc/invite_update/bloc/invite_update_bloc.dart';
import 'package:tivra_health/data/all_bloc/invite_update/bloc/invite_update_state.dart';
import 'package:tivra_health/modules/menu/view/side_menu_drawer.dart';
import 'package:tivra_health/modules/my_connections/model/my_connections_model.dart';
import 'package:tivra_health/modules/my_connections/view/row_my_approvals_view.dart';
import 'package:tivra_health/modules/my_connections/view/row_my_invites_view.dart';

class MyConnectionsScreenWidget extends StatefulWidget {
  const MyConnectionsScreenWidget({super.key});

  @override
  State<MyConnectionsScreenWidget> createState() =>
      _MyConnectionsScreenWidgetState();
}

class _MyConnectionsScreenWidgetState extends State<MyConnectionsScreenWidget> {
  late MyConnectionsModel mMyConnectionsModel;

  @override
  void initState() {
    super.initState();
    mMyConnectionsModel = MyConnectionsModel(context, () {
      setState(() {});
    });

    mMyConnectionsModel.getUsrDetails();
    mMyConnectionsModel.setInviteSentBloc();
    mMyConnectionsModel.setInviteReceiveBloc();
    mMyConnectionsModel.setInviteUpdateBloc();
    mMyConnectionsModel.setInviteBloc();
    mMyConnectionsModel.callInviteSent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: mMyConnectionsModel.scaffoldKey,
        appBar: AppBars.appBarDashboard(
            (value) {}, mMyConnectionsModel.scaffoldKey),
        drawer: SideMenuDrawer(
            sMenuType: AppConstants.mWordConstants.sMyConnections),
        body: _buildWelcomeView());
  }

  _buildWelcomeView() {
    return FocusDetector(
        onVisibilityGained: () {

        },
        child: SafeArea(
            child: MultiBlocListener(child: blocFullView(), listeners: [
              ///Invite
              BlocListener<InviteBloc, InviteState>(
                bloc: mMyConnectionsModel.getInviteBloc(),
                listener: (context, state) {
                  mMyConnectionsModel.blocInviteListener(context, state);
                },
              ),
              ///Invite sent
              BlocListener<InviteSentBloc, InviteSentState>(
                bloc: mMyConnectionsModel.getInviteSentBloc(),
                listener: (context, state) {
                  mMyConnectionsModel.blocInviteSentListener(context, state);
                },
              ),
              ///Invite Receive
              BlocListener<InviteReceiveBloc, InviteReceiveState>(
                bloc: mMyConnectionsModel.getInviteReceiveBloc(),
                listener: (context, state) {
                  mMyConnectionsModel.blocInviteReceiveListener(context, state);
                },
              ),
              ///Invite update
              BlocListener<InviteUpdateBloc, InviteUpdateState>(
                bloc: mMyConnectionsModel.getInviteUpdateBloc(),
                listener: (context, state) {
                  mMyConnectionsModel.blocInviteUpdateListener(context, state);
                },
              ),
            ])
           ));
  }

  blocFullView(){
  return Column(
    children: [
      SizedBox(
        height: SizeConstants.s1 * 5,
      ),

      ///search view
      Container(
          margin: EdgeInsets.all(SizeConstants.s1 * 10),
          padding: EdgeInsets.all(SizeConstants.s1 * 13),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(0, 1), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            children: [
              editTextFiled(
                  mMyConnectionsModel.mUserNameTextEditingController,
                  hintText: AppConstants.mWordConstants.sEnterEmailId,
                  backGround: Colors.grey.shade200),
              SizedBox(
                height: SizeConstants.s1 * 10,
              ),
              editTextFiled(
                  mMyConnectionsModel.mSubjectTextEditingController,
                  hintText: AppConstants.mWordConstants.sSubject,
                  backGround: Colors.grey.shade200),
              Container(
                  width: SizeConstants.width * 0.55,
                  height: SizeConstants.s1 * 45,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(
                    top: SizeConstants.s1 * 15,
                    bottom: SizeConstants.s1 * 5,
                  ),
                  decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.circular(SizeConstants.s1 * 5),
                      color: ColorConstants.cSideMenuSelectText),
                  child: rectangleRoundedCornerMediumButton(
                      AppConstants.mWordConstants.sInvite, () {
                        if(mMyConnectionsModel.mUserNameTextEditingController.text.isEmpty){
                          AppAlert.showSnackBar(context, "Please enter the email id");
                        }else if(mMyConnectionsModel.mSubjectTextEditingController.text.isEmpty){
                          AppAlert.showSnackBar(context, "Please enter the Subject");
                        }else {
                          mMyConnectionsModel.fetchInviteUrl();
                        }
                  })),
            ],
          )),

      ///tab
      Container(
          margin: EdgeInsets.only(
            left: SizeConstants.s1 * 5,
            right: SizeConstants.s1 * 5,
          ),
          child: Row(
            children: [
              middleView(AppConstants.mWordConstants.wMyInvites,
                  mMyConnectionsModel.sSelectValue, (String sValue) {
                    setState(() {
                      mMyConnectionsModel.sSelectValue = sValue;
                      mMyConnectionsModel.callInviteSent();
                    });
                  }, ColorConstants.cWhite),
              middleView(AppConstants.mWordConstants.wMyApprovals,
                  mMyConnectionsModel.sSelectValue, (String sValue) {
                    setState(() {
                      mMyConnectionsModel.sSelectValue = sValue;
                      mMyConnectionsModel.callInviteReceive();
                    });
                  }, ColorConstants.cWhite),
            ],
          )),

      ///listView
      Expanded(child: getInviteResponseView())
    ],
  );
  }

  getInviteResponseView() {
    return StreamBuilder<InviteSentResponse?>(
      stream: mMyConnectionsModel.responseSubjectInviteSent,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          InviteSentResponse mInviteSentResponse =
          snapshot.data as InviteSentResponse;
          if (mInviteSentResponse != null) {
            return listView(mInviteSentResponse.data??[]);
          }
        }
        return SizedBox();
      },
    );
  }

  listView(List<InviteSentData> mInviteSentList) {
    return SmartRefresher(
        controller: mMyConnectionsModel.refreshController,
        onRefresh: mMyConnectionsModel.onRefresh,
        enablePullUp: false,
        enablePullDown: true,
        footer: CustomFooter(builder: (context, loadStatus) {
          return customFooter(loadStatus);
        }),
        header: waterDropHeader(),
        child: displayList(mInviteSentList));
  }

  displayList(List<InviteSentData> mInviteSentList) {
    return Container(
        child: mInviteSentList.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.only(bottom: SizeConstants.s1 * 0),
                itemCount: mInviteSentList.length,
                itemBuilder: (BuildContext context, int index) {
                  return viewItem(index,mInviteSentList[index]);
                },
              )
            : emptyView(SizeConstants.height * 0.55, ImageAssets.noValueMyTeam,
                AppConstants.mWordConstants.wMyTeamNoList));
  }

  viewItem(int index,InviteSentData mInviteSentData) {
    if (mMyConnectionsModel.sSelectValue == AppConstants.mWordConstants.wMyInvites) {
      return RowMyInvitesViewWidget(
          index: index, mMyConnectionsModel: mMyConnectionsModel,mInviteSentData:mInviteSentData);
    } else {
      return RowMyApprovalsViewWidget(
          index: index, mMyConnectionsModel: mMyConnectionsModel,mInviteSentData:mInviteSentData);
    }
  }
}
