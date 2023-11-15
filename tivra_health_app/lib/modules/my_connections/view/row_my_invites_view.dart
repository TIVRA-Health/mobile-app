import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tivra_health/common/app_constants.dart';
import 'package:tivra_health/common/appbars_constants.dart';
import 'package:tivra_health/common/color_constants.dart';
import 'package:tivra_health/common/dashboard_common_view.dart';
import 'package:tivra_health/common/image_assets.dart';
import 'package:tivra_health/common/size_constants.dart';
import 'package:tivra_health/common/text_styles_constants.dart';
import 'package:tivra_health/common/utils/date_utils.dart';
import 'package:tivra_health/common/widget/dropdown_button_view/dropdown_button2.dart';
import 'package:tivra_health/common/widget/pull_to_refresh_header_widget.dart';
import 'package:tivra_health/data/all_bloc/invite_sent/repo/invite_sent_response.dart';
import 'package:tivra_health/modules/menu/view/side_menu_drawer.dart';
import 'package:tivra_health/modules/my_connections/model/my_connections_model.dart';
import 'package:tivra_health/modules/my_team/model/my_team_model.dart';
import 'package:tivra_health/routes/route_constants.dart';

class RowMyInvitesViewWidget extends StatefulWidget {
  final int index;
  final MyConnectionsModel mMyConnectionsModel;
  final InviteSentData mInviteSentData;

  const RowMyInvitesViewWidget(
      {super.key,
      required this.index,
      required this.mMyConnectionsModel,
      required this.mInviteSentData});

  @override
  State<RowMyInvitesViewWidget> createState() => _RowMyInvitesViewWidgetState();
}

class _RowMyInvitesViewWidgetState extends State<RowMyInvitesViewWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () async {
          // Navigator.pushNamed(
          //     context, RouteConstants.rPlayerDetailsScreenWidget,
          //     arguments: widget.mInviteSentData.id);
        },
        child: Padding(
          padding: EdgeInsets.all(SizeConstants.s_8),
          child: Container(
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
              child: Padding(
                  padding: EdgeInsets.only(
                    left: SizeConstants.s_15,
                    right: SizeConstants.s_15,
                    top: SizeConstants.s_15,
                    bottom: SizeConstants.s_15,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: SizeConstants.s1 * 60,
                            width: SizeConstants.s1 * 60,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            width: SizeConstants.s1 * 10,
                          ),
                          Expanded(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.mInviteSentData.userName ?? "__",
                                style: getTextSemiBold(
                                    colors:
                                        ColorConstants.cDashboardGradientColor,
                                    size: SizeConstants.s_18),
                              ),
                              SizedBox(
                                height: SizeConstants.s1 * 3,
                              ),
                              Text(
                                widget.mInviteSentData.role ?? "__",
                                style: getTextRegular(
                                    colors: Colors.black,
                                    size: SizeConstants.s_16),
                              ),
                            ],
                          )),
                          SizedBox(
                            width: SizeConstants.s1 * 10,
                          ),
                          myConnectButtonView(
                              (widget.mInviteSentData.isApproved != null &&
                                      !(widget.mInviteSentData.isApproved ??
                                          true))
                                  ? AppConstants.mWordConstants.wResend
                                  : AppConstants.mWordConstants.wRenew,
                              Colors.white,
                              (widget.index % 2 == 0)
                                  ? ColorConstants.cDashboardGradientColor
                                  : ColorConstants.cSideMenuSelectText,
                              (String sValue) {
                            widget.mMyConnectionsModel.fetchResentUrl(
                                widget.mInviteSentData.inviteEmail ?? "",
                                widget.mInviteSentData.subject ?? "");
                          }),
                        ],
                      ),
                      SizedBox(
                        height: SizeConstants.s1 * 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            getDate(widget.mInviteSentData.date ?? ""),
                            style: getTextRegular(
                                colors: Colors.grey.shade500,
                                size: SizeConstants.s_15),
                          ),
                          Text(
                            widget.mInviteSentData.status ?? "__",
                            style: getTextMedium(
                                colors: Colors.grey.shade500,
                                size: SizeConstants.s_15),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: SizeConstants.s1 * 10,
                      ),
                      Text(
                        widget.mInviteSentData.subject ?? "__",
                        style: getTextMedium(
                            colors: ColorConstants.cDashboardGradientColor,
                            size: SizeConstants.s_15),
                      ),
                    ],
                  ))),
        ));
  }
}
