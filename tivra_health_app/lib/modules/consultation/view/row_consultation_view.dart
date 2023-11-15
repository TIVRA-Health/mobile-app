import 'package:flutter/material.dart';
import 'package:tivra_health/common/color_constants.dart';
import 'package:tivra_health/common/size_constants.dart';
import 'package:tivra_health/common/text_styles_constants.dart';
import 'package:tivra_health/modules/consultation/model/consultation_model.dart';
import 'package:tivra_health/routes/route_constants.dart';

class RowConsultationViewWidget extends StatefulWidget {
  final int index;
  final ConsultationModel mConsultationModel;

  const RowConsultationViewWidget(
      {super.key, required this.index, required this.mConsultationModel});

  @override
  State<RowConsultationViewWidget> createState() =>
      _RowConsultationViewWidgetState();
}

class _RowConsultationViewWidgetState extends State<RowConsultationViewWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () async {
          Navigator.pushNamed(
              context, RouteConstants.rConsultationDetailsScreenWidget);
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
                                "Kailua",
                                style: getTextSemiBold(
                                    colors:
                                        ColorConstants.cDashboardGradientColor,
                                    size: SizeConstants.s_18),
                              ),
                              SizedBox(
                                height: SizeConstants.s1 * 3,
                              ),
                              Text(
                                "Athletic Coach",
                                style: getTextRegular(
                                    colors: Colors.black,
                                    size: SizeConstants.s_16),
                              ),
                            ],
                          )),
                        ],
                      ),
                    ],
                  ))),
        ));
  }
}
