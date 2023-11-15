import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:tivra_health/common/alert/app_alert.dart';
import 'package:tivra_health/common/app_constants.dart';
import 'package:tivra_health/common/button_constants.dart';
import 'package:tivra_health/common/color_constants.dart';
import 'package:tivra_health/common/size_constants.dart';
import 'package:tivra_health/common/text_styles_constants.dart';
import 'package:tivra_health/data/all_bloc/payment_link/bloc/tivra_health_payment_link_bloc.dart';
import 'package:tivra_health/data/all_bloc/payment_link/bloc/tivra_health_payment_link_state.dart';
import 'package:tivra_health/data/all_bloc/payment_methods/bloc/payment_methods_bloc.dart';
import 'package:tivra_health/data/all_bloc/payment_methods/bloc/payment_methods_state.dart';
import 'package:tivra_health/data/all_bloc/user_role/bloc/tivra_health_user_role_bloc.dart';
import 'package:tivra_health/data/all_bloc/user_role/bloc/tivra_health_user_role_state.dart';
import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';
import 'package:tivra_health/modules/registration/model/payment_details_model.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentDetailsScreen extends StatefulWidget {
  final Function(bool, int, int?, String?) refreshPage;

  const PaymentDetailsScreen(this.refreshPage, {Key? key}) : super(key: key);

  @override
  State<PaymentDetailsScreen> createState() => _PaymentDetailsScreen();
}

class _PaymentDetailsScreen extends State<PaymentDetailsScreen> {
  late PaymentDetailsModel mPaymentDetailsModel;
  String? selectedRole = "";

  @override
  void initState() {
    super.initState();
    mPaymentDetailsModel = PaymentDetailsModel(context);
    mPaymentDetailsModel.setTivraHealthRegisterScreenBloc();
    mPaymentDetailsModel.paymentMethod();
  }

  bool _validate() {
    setState(() {
      mPaymentDetailsModel.validateItem();
    });
    return !mPaymentDetailsModel.selectedItemValidator;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(child: _buildUI(), listeners: [
      BlocListener<PaymentMethodsBloc, PaymentMethodsState>(
        bloc: mPaymentDetailsModel.getPaymentMethodsBloc(),
        listener: (context, state) {
          blocTivraHealthPaymentMethodListener(
              context, state);
        },
      ),
      BlocListener<TivraHealthUserRoleBloc, TivraHealthUserRoleState>(
        bloc: mPaymentDetailsModel.getUserRoleBloc(),
        listener: (context, state) {
          blocTivraHealthUserRoleListener(
              context, state);
        },
      ),
      BlocListener<TivraHealthPaymentLinkBloc, TivraHealthPaymentLinkState>(
        bloc: mPaymentDetailsModel.getPaymentLinkBloc(),
        listener: (context, state) {
          blocTivraHealthPaymentLinkListener(
              context, state);
        },
      ),
    ]);
  }

  _buildUI() {
    return SingleChildScrollView(
        child: Container(
          padding:
          EdgeInsets.fromLTRB(SizeConstants.s_10, 0, SizeConstants.s_10, 0),
          child: Column(
            children: [
              Text(
                AppConstants.mWordConstants.sPaymentDetails,
                style: getTextMedium(
                    colors: ColorConstants.cBlack, size: SizeConstants.s1 * 20),
              ),
              SizedBox(
                height: SizeConstants.s_20,
              ),
              Text(
                AppConstants.mWordConstants.sPleaseSelectYourProfile,
                style: getTextMedium(
                    colors: ColorConstants.cBlack, size: SizeConstants.s1 * 10),
              ),
              SizedBox(
                height: SizeConstants.s_20,
              ),
              Container(
                width: SizeConstants.width - 30,
                color: ColorConstants.cScaffoldBackgroundColor,
                child: DropdownMenu<String>(
                  dropdownMenuEntries: mPaymentDetailsModel.sMenuItems
                      .map<DropdownMenuEntry<String>>((String value) {
                    return DropdownMenuEntry<String>(value: value, label: value);
                  }).toList(),
                  width: SizeConstants.width - 30,
                  hintText: AppConstants.mWordConstants.sRoleSelection,
                  onSelected: (value) {
                    setState(() {
                      selectedRole = value;
                      mPaymentDetailsModel.showPricing = true;
                    });
                    mPaymentDetailsModel.setSelectedRole(value!);
                    mPaymentDetailsModel.getPricing();
                  },
                ),
              ),
              SizedBox(
                height: SizeConstants.s_20,
              ),
              if(mPaymentDetailsModel.showPricing)
                showPricingUI(),
              if(mPaymentDetailsModel.showPricing && mPaymentDetailsModel.selectedItemValidator)
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.fromLTRB(
                      SizeConstants.s_10, 0, SizeConstants.s_10, 0),
                  child: Text(
                    AppConstants.mWordConstants.sSelectPricing,
                    style: getTextRegular(colors: ColorConstants.cRedColor),
                  ),
                ),
              if(mPaymentDetailsModel.showPricing)
                SizedBox(
                  height: SizeConstants.s_20,
                ),
              if(mPaymentDetailsModel.showPricing)
                Container(
                    height: SizeConstants.s1 * 43,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(
                      left: SizeConstants.s1 * 5,
                      right: SizeConstants.s1 * 5,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(SizeConstants.s1 * 5),
                        color: ColorConstants.cSideMenuSelectText),
                    child: rectangleRoundedCornerButton(
                        AppConstants.mWordConstants.sProceed, () {
                      if(_validate()) {
                        mPaymentDetailsModel.getPaymentLink();
                        //mPaymentDetailsModel.selectUserRole();
                       // widget.refreshPage(true, 2, mPaymentDetailsModel.corporateAffiliation, mPaymentDetailsModel.selectedRole);
                      }
                    })),
            ],
          ),
        ));
  }

  showPricingUI() {
    return StaggeredGridView.countBuilder(
      staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: mPaymentDetailsModel.paymentPlans.length,
      crossAxisCount: 3,
      crossAxisSpacing: 3,
      mainAxisSpacing: 3,
      itemBuilder: (BuildContext context, int index) => GestureDetector(
        onTap: () {
          setState(() {
            mPaymentDetailsModel.selectedItem = index;
          });
        },
        child: pricingItem(index),
      ),
    );
  }

  pricingItem(int index) {
    return Container(
      height: SizeConstants.s1 * 160,
      margin: EdgeInsets.fromLTRB(SizeConstants.s_05, 0, SizeConstants.s_05, 0),
      decoration: BoxDecoration(
          boxShadow: const <BoxShadow>[
            BoxShadow(
                color: Colors.black54,
                blurRadius: 15.0,
                offset: Offset(0.0, 0.75))
          ],
          borderRadius: BorderRadius.all(Radius.circular(SizeConstants.s1 * 5)),
          color: mPaymentDetailsModel.selectedItem == index ? ColorConstants.cGrey : ColorConstants.cWhite,
          border: Border.all(
            color: ColorConstants.cEditTextBorderLightColor,
            width: SizeConstants.s_05,
          )),
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: 40,
            color: ColorConstants.cScaffoldBackgroundColor,
            child: Text(
              mPaymentDetailsModel.paymentPlans[index].plan!,
              style: getTextBold(colors: ColorConstants.cSideMenu),
            ),
          ),
          SizedBox(
            height: SizeConstants.s_10,
          ),
          Container(
            alignment: Alignment.center,
            height: 40,
            child: Text(
              "${mPaymentDetailsModel.paymentPlans[index].amount}\n${mPaymentDetailsModel.paymentPlans[index].currency}",
              style: getTextBold(colors: ColorConstants.cError),
            ),
          ),
          SizedBox(
            height: SizeConstants.s_10,
          ),
          Container(
            alignment: Alignment.center,
            height: 40,
            child: Text(
              mPaymentDetailsModel.paymentPlans[index].description!,
              style: getTextRegular(colors: ColorConstants.cGrayText),
            ),
          ),
        ],
      ),
    );
  }

  blocTivraHealthPaymentMethodListener(
      BuildContext context, PaymentMethodsState state) {
    switch (state.status) {
      case PaymentMethodsStatus.loading:
        AppAlert.showProgressDialog(context);
        break;
      case PaymentMethodsStatus.failed:
        AppAlert.closeDialog(context);
        AppAlert.showSnackBar(
            context, state.webResponseFailed?.statusMessage ?? "");
        mPaymentDetailsModel.getRoles();
        setState(() {
          mPaymentDetailsModel.sMenuItems;
        });
        break;
      case PaymentMethodsStatus.success:
        AppAlert.closeDialog(context);
        mPaymentDetailsModel.getRoles();
        setState(() {
          mPaymentDetailsModel.sMenuItems;
        });
        // widget.refreshPage(true, 1);
        break;
    }
  }

  blocTivraHealthUserRoleListener(
      BuildContext context, TivraHealthUserRoleState state) {
    switch (state.status) {
      case TivraHealthUserRoleStatus.loading:
        AppAlert.showProgressDialog(context);
        break;
      case TivraHealthUserRoleStatus.failed:
        AppAlert.closeDialog(context);
        AppAlert.showSnackBar(
            context, state.webResponseFailed?.statusMessage ?? "");
        break;
      case TivraHealthUserRoleStatus.success:
        AppAlert.closeDialog(context);
        widget.refreshPage(true, 2, mPaymentDetailsModel.corporateAffiliation, mPaymentDetailsModel.selectedRole);
        break;
    }
  }

  blocTivraHealthPaymentLinkListener(
      BuildContext context, TivraHealthPaymentLinkState state) {
    switch (state.status) {
      case TivraHealthPaymentLinkStatus.loading:
        AppAlert.showProgressDialog(context);
        break;
      case TivraHealthPaymentLinkStatus.failed:
        AppAlert.closeDialog(context);
        AppAlert.showSnackBar(
            context, state.webResponseFailed?.statusMessage ?? "");
        break;
      case TivraHealthPaymentLinkStatus.success:
        AppAlert.closeDialog(context);
       // widget.refreshPage(true, 2, mPaymentDetailsModel.corporateAffiliation, mPaymentDetailsModel.selectedRole);
        mPaymentDetailsModel.selectUserRole();
        navigateToPaymentLink();
        break;
    }
  }

  navigateToPaymentLink() async {
    String urlValue = await SharedPrefs().getPaymentUrl();
    if(urlValue.isNotEmpty) {
      final Uri url = Uri.parse(urlValue);
      if (!await launchUrl(url)) {
        throw Exception('Could not launch $url');
      }
    }
  }

}