import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tivra_health/common/app_constants.dart';
import 'package:tivra_health/common/appbars_constants.dart';
import 'package:tivra_health/common/color_constants.dart';
import 'package:tivra_health/common/size_constants.dart';
import 'package:tivra_health/common/text_styles_constants.dart';
import 'package:tivra_health/common/utils/date_utils.dart';
import 'package:tivra_health/data/all_bloc/get_user_details/repo/get_user_details_response.dart';
import 'package:tivra_health/modules/menu/view/side_menu_drawer.dart';
import 'package:tivra_health/modules/my_profile/model/my_profile_model.dart';
import 'package:tivra_health/routes/route_constants.dart';

class MyProfileScreenWidget extends StatefulWidget {
  const MyProfileScreenWidget({super.key});

  @override
  State<MyProfileScreenWidget> createState() => _MyProfileScreenWidgetState();
}

class _MyProfileScreenWidgetState extends State<MyProfileScreenWidget> {
  late MyProfileScreenModel mMyProfileScreenModel;

  @override
  void initState() {
    mMyProfileScreenModel = MyProfileScreenModel(context, () {
      setState(() {});
    });
    mMyProfileScreenModel.getUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: mMyProfileScreenModel.scaffoldKey,
        appBar: AppBars.appBarDashboard(
            (value) {}, mMyProfileScreenModel.scaffoldKey),
        drawer: SideMenuDrawer(sMenuType: AppConstants.mWordConstants.sProfile),
        body: getUserDetailsView());
  }

  getUserDetailsView() {
    return StreamBuilder<GetUserDetailsResponse?>(
      stream: mMyProfileScreenModel.responseSubject,
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
              ///profile
              Container(
                  margin: EdgeInsets.all(SizeConstants.s1 * 13),
                  padding: EdgeInsets.all(SizeConstants.s1 * 15),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: SizeConstants.s1 * 60,
                            width: SizeConstants.s1 * 60,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: ColorConstants.cProfile),
                            child: Icon(Icons.person,
                                size: SizeConstants.s1 * 50,
                                color: Colors.white),
                          ),
                          SizedBox(
                            width: SizeConstants.s1 * 15,
                          ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${mGetUserDetailsResponse.firstName ?? "--"} ${mGetUserDetailsResponse.middleName ?? "--"} ${mGetUserDetailsResponse.lastName ?? "--"}",
                                style: getTextMedium(
                                  colors: Colors.black,
                                  size: SizeConstants.s1 * 20,
                                ),
                              ),
                              SizedBox(
                                height: SizeConstants.s1 * 3,
                              ),
                              Text(
                                mGetUserDetailsResponse.roleName ?? "--",
                                style: getTextRegular(
                                    size: SizeConstants.s1 * 14,
                                    colors: Colors.grey.shade600),
                              )
                            ],
                          )),
                          // GestureDetector(
                          //   onTap: () {
                          //     Navigator.pushNamed(
                          //         context, RouteConstants.rEditProfileScreenWidget);
                          //   },
                          //   child: Container(
                          //     height: SizeConstants.s1 * 60,
                          //     alignment: Alignment.topCenter,
                          //     child: Icon(
                          //       Icons.edit,
                          //       color: ColorConstants.cSideMenuSelectText,
                          //       size: SizeConstants.s1 * 20,
                          //     ),
                          //   ),
                          // )
                        ],
                      ),
                      SizedBox(
                        height: SizeConstants.s1 * 5,
                      ),
                      const Divider(
                        color: Colors.grey,
                      ),
                      SizedBox(
                        height: SizeConstants.s1 * 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 4,
                            child: Text("Email : ",
                                style: getTextMedium(
                                  colors: Colors.black,
                                  size: SizeConstants.s1 * 20,
                                )),
                          ),
                          Expanded(
                              flex: 7,
                              child: Text(
                                mGetUserDetailsResponse.email ?? "--",
                                style: getTextMedium(
                                  colors: Colors.black,
                                  size: SizeConstants.s1 * 20,
                                ),
                              ))
                        ],
                      ),
                      SizedBox(
                        height: SizeConstants.s1 * 5,
                      ),
                      const Divider(
                        color: Colors.grey,
                      ),
                      SizedBox(
                        height: SizeConstants.s1 * 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              flex: 4,
                              child: Text(
                                "Phone : ",
                                style: getTextMedium(
                                  colors: Colors.black,
                                  size: SizeConstants.s1 * 20,
                                ),
                              )),
                          Expanded(
                              flex: 7,
                              child: Text(
                                mGetUserDetailsResponse.phoneNumber ?? "--",
                                style: getTextMedium(
                                  colors: Colors.black,
                                  size: SizeConstants.s1 * 20,
                                ),
                              ))
                        ],
                      ),
                      SizedBox(
                        height: SizeConstants.s1 * 5,
                      ),
                    ],
                  )),

              ///heath
              Container(
                margin: EdgeInsets.only(
                    left: SizeConstants.s1 * 13,
                    right: SizeConstants.s1 * 13,
                    bottom: SizeConstants.s1 * 13),
                padding: EdgeInsets.only(
                    left: SizeConstants.s1 * 20,
                    right: SizeConstants.s1 * 20,
                    bottom: SizeConstants.s1 * 20),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Text(
                          "Health & fitness",
                          style: getTextMedium(
                            colors: Colors.black,
                            size: SizeConstants.s1 * 20,
                          ),
                        )),
                        GestureDetector(
                          onTap: () async {
                            var getValue = await Navigator.pushNamed(context,
                                RouteConstants.rEditHealthAndFitnessProfile);
                            if (getValue != null &&
                                getValue.toString() == "return") {
                              mMyProfileScreenModel.getUserDetails();
                            }
                          },
                          child: Container(
                            height: SizeConstants.s1 * 60,
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.edit,
                              color: ColorConstants.cSideMenuSelectText,
                              size: SizeConstants.s1 * 20,
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Column(
                          children: [
                            Text(
                              "Smoker",
                              style: getTextMedium(
                                  size: SizeConstants.s1 * 20,
                                  colors: Colors.black),
                            ),
                            SizedBox(
                              height: SizeConstants.s1 * 8,
                            ),
                            Container(
                              width: SizeConstants.s1 * 80,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      SizeConstants.s1 * 5),
                                  border: Border.all(
                                      color: Colors.black,
                                      width: SizeConstants.s1 * 2)),
                              padding: EdgeInsets.only(
                                top: SizeConstants.s1 * 5,
                                bottom: SizeConstants.s1 * 5,
                              ),
                              child: Text(
                                (mGetUserDetailsResponse
                                            .healthFitness?.smoker ??
                                        true)
                                    ? "Yes"
                                    : "No",
                                style: getTextRegular(
                                    size: SizeConstants.s1 * 18,
                                    colors: Colors.black),
                              ),
                            )
                          ],
                        )),
                        Expanded(
                            child: Column(
                          children: [
                            Text(
                              "Height",
                              style: getTextMedium(
                                  size: SizeConstants.s1 * 20,
                                  colors: Colors.black),
                            ),
                            SizedBox(
                              height: SizeConstants.s1 * 8,
                            ),
                            Container(
                              width: SizeConstants.s1 * 80,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      SizeConstants.s1 * 5),
                                  border: Border.all(
                                      color: Colors.black,
                                      width: SizeConstants.s1 * 2)),
                              padding: EdgeInsets.only(
                                top: SizeConstants.s1 * 5,
                                bottom: SizeConstants.s1 * 5,
                              ),
                              child: Text(
                                mGetUserDetailsResponse.healthFitness?.height ??
                                    "0",
                                style: getTextRegular(
                                    size: SizeConstants.s1 * 18,
                                    colors: Colors.black),
                              ),
                            )
                          ],
                        )),
                        Expanded(
                            child: Column(
                          children: [
                            Text(
                              "Weight",
                              style: getTextMedium(
                                  size: SizeConstants.s1 * 20,
                                  colors: Colors.black),
                            ),
                            SizedBox(
                              height: SizeConstants.s1 * 8,
                            ),
                            Container(
                              width: SizeConstants.s1 * 80,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      SizeConstants.s1 * 5),
                                  border: Border.all(
                                      color: Colors.black,
                                      width: SizeConstants.s1 * 2)),
                              padding: EdgeInsets.only(
                                top: SizeConstants.s1 * 5,
                                bottom: SizeConstants.s1 * 5,
                              ),
                              child: Text(
                                "${mGetUserDetailsResponse.healthFitness?.weight ?? "0"} lbs",
                                style: getTextRegular(
                                    size: SizeConstants.s1 * 18,
                                    colors: Colors.black),
                              ),
                            )
                          ],
                        )),
                      ],
                    )
                  ],
                ),
              ),

              ///Demographic
              fullView(mGetUserDetailsResponse),

              ///Social Profile
              Container(
                margin: EdgeInsets.only(
                    left: SizeConstants.s1 * 13,
                    right: SizeConstants.s1 * 13,
                    bottom: SizeConstants.s1 * 13),
                padding: EdgeInsets.only(
                    left: SizeConstants.s1 * 20, right: SizeConstants.s1 * 20),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Text(
                          "Social Profile",
                          style: getTextMedium(
                            colors: Colors.black,
                            size: SizeConstants.s1 * 20,
                          ),
                        )),
                        GestureDetector(
                          onTap: () async {
                            var getValue = await Navigator.pushNamed(
                                context, RouteConstants.rEditSocialProfile);
                            if (getValue != null &&
                                getValue.toString() == "return") {
                              mMyProfileScreenModel.getUserDetails();
                            }
                          },
                          child: Container(
                            height: SizeConstants.s1 * 60,
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.edit,
                              color: ColorConstants.cSideMenuSelectText,
                              size: SizeConstants.s1 * 20,
                            ),
                          ),
                        )
                      ],
                    ),
                    const Divider(
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: SizeConstants.s1 * 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            flex: 4,
                            child: Text(
                              "Education : ",
                              style: getTextMedium(
                                colors: Colors.black,
                                size: SizeConstants.s1 * 20,
                              ),
                            )),
                        Expanded(
                            flex: 7,
                            child: Text(
                              mGetUserDetailsResponse
                                      .socialProfile?.educationLevel ??
                                  "--",
                              style: getTextMedium(
                                colors: Colors.black,
                                size: SizeConstants.s1 * 20,
                              ),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: SizeConstants.s1 * 5,
                    ),
                    const Divider(
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: SizeConstants.s1 * 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            flex: 4,
                            child: Text(
                              "Income Range : ",
                              style: getTextMedium(
                                colors: Colors.black,
                                size: SizeConstants.s1 * 20,
                              ),
                            )),
                        Expanded(
                            flex: 7,
                            child: Text(
                              mGetUserDetailsResponse
                                      .socialProfile?.incomeRange ??
                                  "",
                              style: getTextMedium(
                                colors: Colors.black,
                                size: SizeConstants.s1 * 20,
                              ),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: SizeConstants.s1 * 5,
                    ),
                    const Divider(
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: SizeConstants.s1 * 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            flex: 4,
                            child: Text(
                              "Health \nCare : ",
                              style: getTextMedium(
                                colors: Colors.black,
                                size: SizeConstants.s1 * 20,
                              ),
                            )),
                        Expanded(
                            flex: 7,
                            child: Text(
                              (mGetUserDetailsResponse
                                          .socialProfile?.healthCare ??
                                      false)
                                  .toString(),
                              style: getTextMedium(
                                colors: Colors.black,
                                size: SizeConstants.s1 * 20,
                              ),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: SizeConstants.s1 * 5,
                    ),
                    const Divider(
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: SizeConstants.s1 * 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            flex: 4,
                            child: Text(
                              "Hospital Associated : ",
                              style: getTextMedium(
                                colors: Colors.black,
                                size: SizeConstants.s1 * 20,
                              ),
                            )),
                        Expanded(
                            flex: 7,
                            child: Text(
                              mGetUserDetailsResponse
                                      .socialProfile?.hospitalAssociated ??
                                  "__",
                              style: getTextMedium(
                                colors: Colors.black,
                                size: SizeConstants.s1 * 20,
                              ),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: SizeConstants.s1 * 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        )));
  }

  fullView(GetUserDetailsResponse mGetUserDetailsResponse) {
    return Container(
      margin: EdgeInsets.only(
          left: SizeConstants.s1 * 13,
          right: SizeConstants.s1 * 13,
          bottom: SizeConstants.s1 * 15),
      padding: EdgeInsets.only(
          left: SizeConstants.s1 * 20,
          right: SizeConstants.s1 * 20,
          bottom: SizeConstants.s1 * 15),
      constraints: BoxConstraints(minHeight: SizeConstants.height * 0.69),
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
        children: [
          SizedBox(
            height: SizeConstants.s1 * 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: Text(
                "Demographic",
                style: getTextMedium(
                  colors: Colors.black,
                  size: SizeConstants.s1 * 20,
                ),
              )),
              GestureDetector(
                onTap: () async {
                  var getValue = await Navigator.pushNamed(
                      context, RouteConstants.rEditDemographicProfile);
                  if (getValue != null &&
                      getValue.toString() == "return") {
                    mMyProfileScreenModel.getUserDetails();
                  }
                },
                child: Container(
                  height: SizeConstants.s1 * 60,
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.edit,
                    color: ColorConstants.cSideMenuSelectText,
                    size: SizeConstants.s1 * 20,
                  ),
                ),
              )
            ],
          ),
          const Divider(
            color: Colors.grey,
          ),
          SizedBox(
            height: SizeConstants.s1 * 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  flex: 4,
                  child: Text(
                    "Gender : ",
                    style: getTextMedium(
                      colors: Colors.black,
                      size: SizeConstants.s1 * 20,
                    ),
                  )),
              Expanded(
                  flex: 7,
                  child: Text(
                    mGetUserDetailsResponse.demographic?.gender ?? "--",
                    style: getTextMedium(
                      colors: Colors.black,
                      size: SizeConstants.s1 * 20,
                    ),
                  ))
            ],
          ),
          SizedBox(
            height: SizeConstants.s1 * 5,
          ),
          const Divider(
            color: Colors.grey,
          ),
          SizedBox(
            height: SizeConstants.s1 * 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  flex: 4,
                  child: Text(
                    "Dob : ",
                    style: getTextMedium(
                      colors: Colors.black,
                      size: SizeConstants.s1 * 20,
                    ),
                  )),
              Expanded(
                  flex: 7,
                  child: Text(
                    getDate(mGetUserDetailsResponse.demographic?.dob ?? ""),
                    style: getTextMedium(
                      colors: Colors.black,
                      size: SizeConstants.s1 * 20,
                    ),
                  ))
            ],
          ),
          SizedBox(
            height: SizeConstants.s1 * 5,
          ),
          const Divider(
            color: Colors.grey,
          ),
          SizedBox(
            height: SizeConstants.s1 * 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  flex: 4,
                  child: Text(
                    "Address1 : ",
                    style: getTextMedium(
                      colors: Colors.black,
                      size: SizeConstants.s1 * 20,
                    ),
                  )),
              Expanded(
                  flex: 7,
                  child: Text(
                    mGetUserDetailsResponse.demographic?.address1 ?? "--",
                    style: getTextMedium(
                      colors: Colors.black,
                      size: SizeConstants.s1 * 20,
                    ),
                  ))
            ],
          ),
          SizedBox(
            height: SizeConstants.s1 * 5,
          ),
          const Divider(
            color: Colors.grey,
          ),
          SizedBox(
            height: SizeConstants.s1 * 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  flex: 4,
                  child: Text(
                    "Address2 : ",
                    style: getTextMedium(
                      colors: Colors.black,
                      size: SizeConstants.s1 * 20,
                    ),
                  )),
              Expanded(
                  flex: 7,
                  child: Text(
                    mGetUserDetailsResponse.demographic?.address2 ?? "--",
                    style: getTextMedium(
                      colors: Colors.black,
                      size: SizeConstants.s1 * 20,
                    ),
                  ))
            ],
          ),
          SizedBox(
            height: SizeConstants.s1 * 5,
          ),
          const Divider(
            color: Colors.grey,
          ),
          SizedBox(
            height: SizeConstants.s1 * 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  flex: 4,
                  child: Text(
                    "City : ",
                    style: getTextMedium(
                      colors: Colors.black,
                      size: SizeConstants.s1 * 20,
                    ),
                  )),
              Expanded(
                  flex: 7,
                  child: Text(
                    mGetUserDetailsResponse.demographic?.city ?? "--",
                    style: getTextMedium(
                      colors: Colors.black,
                      size: SizeConstants.s1 * 20,
                    ),
                  ))
            ],
          ),
          SizedBox(
            height: SizeConstants.s1 * 5,
          ),
          const Divider(
            color: Colors.grey,
          ),
          SizedBox(
            height: SizeConstants.s1 * 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  flex: 4,
                  child: Text(
                    "State : ",
                    style: getTextMedium(
                      colors: Colors.black,
                      size: SizeConstants.s1 * 20,
                    ),
                  )),
              Expanded(
                  flex: 7,
                  child: Text(
                    mGetUserDetailsResponse.demographic?.state ?? "--",
                    style: getTextMedium(
                      colors: Colors.black,
                      size: SizeConstants.s1 * 20,
                    ),
                  ))
            ],
          ),
          SizedBox(
            height: SizeConstants.s1 * 5,
          ),
          const Divider(
            color: Colors.grey,
          ),
          SizedBox(
            height: SizeConstants.s1 * 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  flex: 4,
                  child: Text(
                    "Country : ",
                    style: getTextMedium(
                      colors: Colors.black,
                      size: SizeConstants.s1 * 20,
                    ),
                  )),
              Expanded(
                  flex: 7,
                  child: Text(
                    mGetUserDetailsResponse.demographic?.country ?? "--",
                    style: getTextMedium(
                      colors: Colors.black,
                      size: SizeConstants.s1 * 20,
                    ),
                  ))
            ],
          ),
          SizedBox(
            height: SizeConstants.s1 * 5,
          ),
          const Divider(
            color: Colors.grey,
          ),
          SizedBox(
            height: SizeConstants.s1 * 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  flex: 4,
                  child: Text(
                    "Zip Code : ",
                    style: getTextMedium(
                      colors: Colors.black,
                      size: SizeConstants.s1 * 20,
                    ),
                  )),
              Expanded(
                  flex: 7,
                  child: Text(
                    mGetUserDetailsResponse.demographic?.zip ?? "--",
                    style: getTextMedium(
                      colors: Colors.black,
                      size: SizeConstants.s1 * 20,
                    ),
                  ))
            ],
          ),
          SizedBox(
            height: SizeConstants.s1 * 5,
          ),
        ],
      ),
    );
  }
}
