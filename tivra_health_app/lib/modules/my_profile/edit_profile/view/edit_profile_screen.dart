import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tivra_health/common/app_constants.dart';
import 'package:tivra_health/common/appbars_constants.dart';
import 'package:tivra_health/common/color_constants.dart';
import 'package:tivra_health/common/size_constants.dart';
import 'package:tivra_health/common/text_styles_constants.dart';
import 'package:tivra_health/data/all_bloc/get_user_details/repo/get_user_details_response.dart';
import 'package:tivra_health/modules/menu/view/side_menu_drawer.dart';
import 'package:tivra_health/modules/my_profile/edit_profile/model/edit_my_profile_model.dart';
import 'package:tivra_health/modules/my_profile/model/my_profile_model.dart';

class EditProfileScreenWidget extends StatefulWidget {
  const EditProfileScreenWidget({super.key});

  @override
  State<EditProfileScreenWidget> createState() => _EditProfileScreenWidgetState();
}

class _EditProfileScreenWidgetState extends State<EditProfileScreenWidget> {
  late EditMyProfileScreenModel mEditProfileScreenModel;

  @override
  void initState() {
    mEditProfileScreenModel = EditMyProfileScreenModel(context, () {
      setState(() {});
    });
    mEditProfileScreenModel.getUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: mEditProfileScreenModel.scaffoldKey,
         appBar: AppBars.appBarBack((value) {}, mEditProfileScreenModel.scaffoldKey),
        body: getUserDetailsView());
  }

  getUserDetailsView() {
    return StreamBuilder<GetUserDetailsResponse?>(
      stream: mEditProfileScreenModel.responseSubject,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          GetUserDetailsResponse mGetUserDetailsResponse =
              snapshot.data as GetUserDetailsResponse;
          if (mGetUserDetailsResponse != null) {
            return _buildMyProfileView(mGetUserDetailsResponse);
          }
        }
        return _buildMyProfileView(GetUserDetailsResponse());
      },
    );
  }

  _buildMyProfileView(GetUserDetailsResponse mGetUserDetailsResponse) {
    return FocusDetector(
        onVisibilityGained: () {},
        child: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              fullView()
            ],
          ),
        )));
  }

  fullView() {
    return Container(
      margin: EdgeInsets.only(
          top: SizeConstants.s1 * 13,
          left: SizeConstants.s1 * 13,
          right: SizeConstants.s1 * 13,
          bottom: SizeConstants.s1 * 15),
      padding: EdgeInsets.all(SizeConstants.s1 * 8),
      constraints: BoxConstraints(minHeight: SizeConstants.height * 0.84),
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
    );
  }
}
