import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tivra_health/common/alert/app_alert.dart';
import 'package:tivra_health/common/app_constants.dart';
import 'package:tivra_health/common/appbars_constants.dart';
import 'package:tivra_health/common/color_constants.dart';
import 'package:tivra_health/common/size_constants.dart';
import 'package:tivra_health/common/text_styles_constants.dart';
import 'package:tivra_health/common/widget/edit_text_field.dart';
import 'package:tivra_health/data/all_bloc/consultation/bloc/consultation_bloc.dart';
import 'package:tivra_health/data/all_bloc/consultation/bloc/consultation_state.dart';
import 'package:tivra_health/modules/consultation/model/consultation_model.dart';
import 'package:tivra_health/modules/menu/view/side_menu_drawer.dart';

class ConsultationScreenWidget extends StatefulWidget {
  const ConsultationScreenWidget({super.key});

  @override
  State<ConsultationScreenWidget> createState() =>
      _ConsultationScreenWidgetState();
}

class _ConsultationScreenWidgetState extends State<ConsultationScreenWidget> {
  late ConsultationModel mConsultationModel;

  @override
  void initState() {
    super.initState();
    mConsultationModel = ConsultationModel(context, () {
      setState(() {});
    });
    mConsultationModel.setConsultationBloc();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(child: _buildUI(), listeners: [
      BlocListener<ConsultationBloc, ConsultationState>(
        bloc: mConsultationModel.getConsultationBloc(),
        listener: (context, state) {
          blocConsultationListener(context, state);
        },
      ),
    ]);
  }

  _buildUI() {
    return Scaffold(
      key: mConsultationModel.scaffoldKey,
      appBar:
          AppBars.appBarDashboard((value) {}, mConsultationModel.scaffoldKey),
      drawer:
          SideMenuDrawer(sMenuType: AppConstants.mWordConstants.sConsultation),
      body: _buildChat(),
      bottomSheet: SizedBox(
        height: 60,
        child: Row(
          children: [
            SizedBox(
              width: SizeConstants.width - 80,
              child: editTextFiled(mConsultationModel.consultController),
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
                width: 60,
                height: 50,
                child: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      mConsultationModel.allMessages
                          .add(mConsultationModel.consultController.text);
                      setState(() {
                        mConsultationModel.allMessages;
                      });
                      mConsultationModel.fetchMessage();
                    },
                    child: Container(
                      color: ColorConstants.accentColor,
                      alignment: Alignment.center,
                      child: Text(
                        "Send",
                        style: getTextRegular(
                          colors: ColorConstants.cBlack,
                          size: SizeConstants.s_16,
                        ),
                      ),
                    ))),
          ],
        ),
      ),
    );
  }

  _buildChat() {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 70),
      child: ListView.builder(
        padding: EdgeInsets.only(bottom: SizeConstants.s1 * 5),
        shrinkWrap: true,
        itemCount: mConsultationModel.allMessages.length,
        itemBuilder: (BuildContext context, int index) {
          return (index % 2 == 0)
              ? Container(
            margin: const EdgeInsets.fromLTRB(20, 5, 5, 5),
            padding: const EdgeInsets.all(5),
            color: ColorConstants.cGrey,
            child: Text(
              mConsultationModel.allMessages[index],
              style: getTextRegular(
                  colors: ColorConstants.cBlack,
                  size: SizeConstants.s_16),
              textAlign: TextAlign.end,
            ),
          )
              : Container(
            padding: const EdgeInsets.all(5),
            margin: const EdgeInsets.fromLTRB(5, 5, 20, 5),
            color: ColorConstants.cGrey,
            child: Text(
              mConsultationModel.allMessages[index],
              style: getTextRegular(
                  colors: ColorConstants.cBlack,
                  size: SizeConstants.s_16),
              textAlign: TextAlign.start,
            ),
          );
        },
      ),
    );
  }

  blocConsultationListener(BuildContext context, ConsultationState state) {
    switch (state.status) {
      case ConsultationStatus.loading:
        AppAlert.showProgressDialog(context);
        break;
      case ConsultationStatus.failed:
        AppAlert.closeDialog(context);
        AppAlert.showSnackBar(
            context, state.webResponseFailed?.statusMessage ?? "");
        break;
      case ConsultationStatus.success:
        AppAlert.closeDialog(context);
        mConsultationModel.getMessages();
        setState(() {
          mConsultationModel.allMessages;
          mConsultationModel.consultController.clear();
        });
        break;
    }
  }
}
