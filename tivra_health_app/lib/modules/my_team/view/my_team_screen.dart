import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tivra_health/common/app_constants.dart';
import 'package:tivra_health/common/appbars_constants.dart';
import 'package:tivra_health/common/color_constants.dart';
import 'package:tivra_health/common/image_assets.dart';
import 'package:tivra_health/common/size_constants.dart';
import 'package:tivra_health/common/text_styles_constants.dart';
import 'package:tivra_health/common/widget/dropdown_button_view/dropdown_button2.dart';
import 'package:tivra_health/common/widget/empty_view/empty_view.dart';
import 'package:tivra_health/common/widget/pull_to_refresh_header_widget.dart';
import 'package:tivra_health/data/all_bloc/my_team_list/bloc/my_team_list_bloc.dart';
import 'package:tivra_health/data/all_bloc/my_team_list/bloc/my_team_list_state.dart';
import 'package:tivra_health/data/all_bloc/my_team_list/repo/my_team_list_response.dart';
import 'package:tivra_health/modules/menu/view/side_menu_drawer.dart';
import 'package:tivra_health/modules/my_team/model/my_team_model.dart';
import 'package:tivra_health/modules/my_team/view/row_my_team_view.dart';

class MyTeamScreenWidget extends StatefulWidget {
  const MyTeamScreenWidget({super.key});

  @override
  State<MyTeamScreenWidget> createState() => _MyTeamScreenWidgetState();
}

class _MyTeamScreenWidgetState extends State<MyTeamScreenWidget> {
  late MyTeamScreenModel mMyTeamScreenModel;

  @override
  void initState() {
    mMyTeamScreenModel = MyTeamScreenModel(context, () {
      setState(() {});
    });
    mMyTeamScreenModel.setMyTeamListBloc();
    mMyTeamScreenModel.callApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: mMyTeamScreenModel.scaffoldKey,
        appBar:
            AppBars.appBarDashboard((value) {}, mMyTeamScreenModel.scaffoldKey),
        drawer: SideMenuDrawer(sMenuType: AppConstants.mWordConstants.sMyTeam),
        body: _buildMyTeamView());
  }

  _buildMyTeamView() {
    return MultiBlocListener(child: _myTeamView(), listeners: [
      BlocListener<MyTeamListBloc, MyTeamListState>(
        bloc: mMyTeamScreenModel.getMyTeamListBloc(),
        listener: (context, state) {
          mMyTeamScreenModel.blocMyTeamListListener(context, state);
        },
      ),
    ]);
  }

  _myTeamView() {
    return FocusDetector(
        onVisibilityGained: () {},
        child: SafeArea(
            child: Column(
          children: [
            // Container(
            //   margin: EdgeInsets.all(SizeConstants.s1 * 13),
            //   padding: EdgeInsets.all(SizeConstants.s1 * 15),
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.circular(5),
            //     boxShadow: [
            //       BoxShadow(
            //         color: Colors.grey.withOpacity(0.3),
            //         spreadRadius: 1,
            //         blurRadius: 2,
            //         offset: Offset(0, 1), // changes position of shadow
            //       ),
            //     ],
            //   ),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Container(
            //         height: SizeConstants.s1 * 60,
            //         width: SizeConstants.s1 * 60,
            //         decoration: const BoxDecoration(
            //             shape: BoxShape.circle, color: ColorConstants.cProfile),
            //         child: Icon(Icons.person,
            //             size: SizeConstants.s1 * 50, color: Colors.white),
            //       ),
            //       SizedBox(
            //         width: SizeConstants.s1 * 15,
            //       ),
            //       Expanded(
            //           child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Text(
            //             "John Smith",
            //             style: getTextMedium(
            //               colors: Colors.black,
            //               size: SizeConstants.s1 * 20,
            //             ),
            //           ),
            //           SizedBox(
            //             height: SizeConstants.s1 * 3,
            //           ),
            //           Text(
            //             "Football Coach",
            //             style: getTextRegular(
            //                 size: SizeConstants.s1 * 14,
            //                 colors: Colors.grey.shade600),
            //           )
            //         ],
            //       ))
            //     ],
            //   ),
            // ),
            Expanded(
                child: SmartRefresher(
                    controller: mMyTeamScreenModel.refreshController,
                    // onLoading: mCoachHubSubscriptionListModel.onLoading,
                    onRefresh: mMyTeamScreenModel.onRefresh,
                    enablePullUp: false,
                    enablePullDown: true,
                    footer: CustomFooter(builder: (context, loadStatus) {
                      return customFooter(loadStatus);
                    }),
                    header: waterDropHeader(),
                    child: SingleChildScrollView(
                      child: getView(),
                    )))
          ],
        )));
  }

  getView() {
    return StreamBuilder<MyTeamListResponse?>(
      stream: mMyTeamScreenModel.responseSubject,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          MyTeamListResponse mMyTeamListResponse =
              snapshot.data as MyTeamListResponse;
          if (mMyTeamListResponse.data != null) {
            return fullView();
          }
        }
        return Container();
      },
    );
  }

  fullView() {
    return Container(
      margin: EdgeInsets.only(
          top: SizeConstants.s1 * 13,
          left: SizeConstants.s1 * 13,
          right: SizeConstants.s1 * 13,
          bottom: SizeConstants.s1 * 15),
      padding: EdgeInsets.all(SizeConstants.s1 * 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(
                  left: SizeConstants.s1 * 10,
                ),
                padding: EdgeInsets.only(
                    left: SizeConstants.s1 * 12,
                    right: SizeConstants.s1 * 12,
                    bottom: SizeConstants.s1 * 5,
                    top: SizeConstants.s1 * 5),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(SizeConstants.s1 * 15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: const Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Text(
                      AppConstants.mWordConstants.wTotalMember,
                      style: getTextRegular(
                          size: SizeConstants.s1 * 15,
                          colors: Colors.grey.shade700),
                    ),
                    Container(
                      height: SizeConstants.s1 * 20,
                      width: SizeConstants.s_05,
                      margin: EdgeInsets.only(
                        left: SizeConstants.s1 * 8,
                        right: SizeConstants.s1 * 8,
                      ),
                      color: Colors.grey.shade700,
                    ),
                    Text(
                      mMyTeamScreenModel.mMyTeamList.length.toString(),
                      style: getTextMedium(
                          size: SizeConstants.s1 * 17, colors: Colors.black),
                    ),
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.only(
                    right: SizeConstants.s1 * 10,
                  ),
                  child: DropdownButtonHideUnderline(
                      child: DropdownButton2(
                    items: mMyTeamScreenModel
                        .createList(mMyTeamScreenModel.listDropdownData),
                    icon: const Icon(
                      Icons.keyboard_arrow_down_outlined,
                      color: ColorConstants.cWhite,
                    ),
                    value: mMyTeamScreenModel.selectedValue,
                    onChanged: (value) {
                      setState(() {
                        mMyTeamScreenModel.selectedValue = value as String;
                      });
                    },
                    customButton: Container(
                        height: SizeConstants.s1 * 40,
                        width: SizeConstants.s1 * 110,
                        margin: EdgeInsets.only(
                            top: SizeConstants.s1 * 5,
                            bottom: SizeConstants.s1 * 5),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(SizeConstants.s1 * 6),
                          color: ColorConstants.cSideMenuSelectText,
                        ),
                        alignment: Alignment.center,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: SizeConstants.s1 * 10,
                            ),
                            Expanded(
                                child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                mMyTeamScreenModel.selectedValue,
                                style: getTextMedium(
                                  colors: ColorConstants.cWhite,
                                  size: SizeConstants.s1 * 16,
                                ),
                              ),
                            )),
                            const Icon(
                              Icons.arrow_drop_down_sharp,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: SizeConstants.s1 * 6,
                            ),
                          ],
                        )),
                    dropdownPadding: EdgeInsets.all(SizeConstants.s1 * 0),
                    dropdownScrollPadding: EdgeInsets.all(SizeConstants.s1 * 1),
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(SizeConstants.s1 * 6),
                      color: ColorConstants.cSideMenuSelectText,
                    ),
                  )))
            ],
          ),
          SizedBox(
            height: SizeConstants.s1 * 10,
          ),
          Visibility(
              visible: mMyTeamScreenModel.mMyTeamList.isNotEmpty,
              child: Text(
                "  ${AppConstants.mWordConstants.wPlayersList}",
                style: getTextSemiBold(
                    size: SizeConstants.s1 * 18,
                    colors: ColorConstants.cDashboardGradientColor),
              )),
          SizedBox(
            height: SizeConstants.s1 * 5,
          ),
          Container(
              constraints:
                  BoxConstraints(minHeight: SizeConstants.height * 0.72),
              child: mMyTeamScreenModel.mMyTeamList.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.only(bottom: SizeConstants.s1 * 0),
                      itemCount: mMyTeamScreenModel.mMyTeamList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return viewItem(index,mMyTeamScreenModel.mMyTeamList[index]);
                      },
                    )
                  : emptyView(
                      SizeConstants.height * 0.72,
                      ImageAssets.noValueMyTeam,
                      AppConstants.mWordConstants.wMyTeamNoList)),
        ],
      ),
    );
  }

  viewItem(int index,MyTeamListData mMyTeamListData) {
    return RowMyTeamViewWidget(index: index,mMyTeamListData: mMyTeamListData);
  }
}
