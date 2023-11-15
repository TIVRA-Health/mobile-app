import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:tivra_health/common/app_constants.dart';
import 'package:tivra_health/common/appbars_constants.dart';
import 'package:tivra_health/common/image_assets.dart';
import 'package:tivra_health/common/size_constants.dart';
import 'package:tivra_health/common/widget/empty_view/empty_view.dart';
import 'package:tivra_health/modules/consultation/consultation_details/model/consultation_details_model.dart';

class ConsultationDetailsScreenWidget extends StatefulWidget {
  final String getId;
  const ConsultationDetailsScreenWidget({super.key,required this.getId});

  @override
  State<ConsultationDetailsScreenWidget> createState() =>
      _ConsultationDetailsScreenWidgetState();
}

class _ConsultationDetailsScreenWidgetState extends State<ConsultationDetailsScreenWidget> {
  late ConsultationDetailsModel mConsultationDetailsModel;

  @override
  void initState() {
    super.initState();
    mConsultationDetailsModel = ConsultationDetailsModel(context, () {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: mConsultationDetailsModel.scaffoldKey,
        appBar: AppBars.appBarBack(
            (value) {}, mConsultationDetailsModel.scaffoldKey),
        body: _buildWelcomeView());
  }

  _buildWelcomeView() {
    return FocusDetector(
        child: SafeArea(
            child: Column(
      children: [
        SizedBox(
          height: SizeConstants.s1 * 5,
        ),
        ///listView
        Expanded(child: emptyView(SizeConstants.height * 0.55, ImageAssets.noValueMyTeam,
            AppConstants.mWordConstants.wItUnderDevelopment))
      ],
    )));
  }


}
