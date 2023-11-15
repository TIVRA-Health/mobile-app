import 'package:flutter/material.dart';
import 'package:tivra_health/common/color_constants.dart';
import 'package:tivra_health/common/size_constants.dart';
import 'package:tivra_health/common/text_styles_constants.dart';
import 'package:tivra_health/common/utils/date_utils.dart';
import 'package:tivra_health/data/all_bloc/invite_sent/repo/invite_sent_response.dart';
import 'package:tivra_health/modules/my_connections/model/my_connections_model.dart';
import 'package:tivra_health/routes/route_constants.dart';

class RowMyApprovalsViewWidget extends StatefulWidget {
  final int index;
  final MyConnectionsModel mMyConnectionsModel;
  final InviteSentData mInviteSentData;

  const RowMyApprovalsViewWidget(
      {super.key,
      required this.index,
      required this.mMyConnectionsModel,
      required this.mInviteSentData});

  @override
  State<RowMyApprovalsViewWidget> createState() =>
      _RowMyApprovalsViewWidgetState();
}

class _RowMyApprovalsViewWidgetState extends State<RowMyApprovalsViewWidget> {
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
                          GestureDetector(
                            onTap: () {
                              widget.mMyConnectionsModel.fetchInviteUpdateUrl(
                                  widget.mInviteSentData.id ?? "0", false);
                            },
                            child: Container(
                              padding: EdgeInsets.all(SizeConstants.s1 * 2),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      width: SizeConstants.s2,
                                      color:
                                          ColorConstants.cSideMenuSelectText),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(SizeConstants.s1 * 20))),
                              child: Icon(
                                Icons.clear,
                                color: ColorConstants.cSideMenuSelectText,
                                size: SizeConstants.s1 * 30,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: SizeConstants.s1 * 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              widget.mMyConnectionsModel.fetchInviteUpdateUrl(
                                  widget.mInviteSentData.id ?? "0", true);
                            },
                            child: Container(
                              padding: EdgeInsets.all(SizeConstants.s1 * 2),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      width: SizeConstants.s2,
                                      color: ColorConstants
                                          .cLightDashboardGreenTextColor),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(SizeConstants.s1 * 20))),
                              child: Icon(
                                Icons.check,
                                color: ColorConstants
                                    .cLightDashboardGreenTextColor,
                                size: SizeConstants.s1 * 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: SizeConstants.s1 * 15,
                      ),
                      Text(
                        getDate(widget.mInviteSentData.date ?? ""),
                        style: getTextRegular(
                            colors: Colors.grey.shade500,
                            size: SizeConstants.s_15),
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
