import 'package:flutter/material.dart';
import 'package:tivra_health/common/app_constants.dart';
import 'package:tivra_health/common/color_constants.dart';
import 'package:tivra_health/common/image_assets.dart';
import 'package:tivra_health/common/size_constants.dart';
import 'package:tivra_health/common/text_styles_constants.dart';
import 'package:tivra_health/data/all_bloc/get_user_details/repo/get_user_details_response.dart';
import 'package:tivra_health/modules/menu/model/side_menu_drawer_model.dart';

class SideMenuDrawer extends StatefulWidget {
  String sMenuType;

  SideMenuDrawer({Key? key, required this.sMenuType}) : super(key: key);

  @override
  _SideMenuDrawerState createState() => _SideMenuDrawerState();
}

class _SideMenuDrawerState extends State<SideMenuDrawer> {
  late SideMenuDrawerModel mSideMenuDrawerModel;

  @override
  void initState() {
    super.initState();
    mSideMenuDrawerModel = SideMenuDrawerModel(context, widget.sMenuType);
    mSideMenuDrawerModel.getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(child: drawerView());
  }

  drawerView() {
    return Container(
      color: ColorConstants.cSideMenu,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            getUserDetailsView(),
            Expanded(child: sideMenuMiddleView()),
            Container(
              height: SizeConstants.s1 * 2,
              color: ColorConstants.cSideMenuSelect,
            ),
            unSelectView(
                ImageAssets.logoutIcon, AppConstants.mWordConstants.sLogout),
            SizedBox(
              height: SizeConstants.s1 * 2,
            )
          ]),
    );
  }

  getUserDetailsView() {
    return StreamBuilder<GetUserDetailsResponse?>(
      stream: mSideMenuDrawerModel.responseSubject,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          GetUserDetailsResponse mGetUserDetailsResponse =
              snapshot.data as GetUserDetailsResponse;
          if (mGetUserDetailsResponse != null) {
            return sideMenuTopView(mGetUserDetailsResponse);
          }
        }
        return sideMenuTopView(GetUserDetailsResponse());
      },
    );
  }

  sideMenuTopView(GetUserDetailsResponse mGetUserDetailsResponse) {
    return Column(
      children: [
        SizedBox(
          height: SizeConstants.s1 * 35,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: SizeConstants.s1 * 15,
            ),
            Container(
              height: SizeConstants.s1 * 70,
              width: SizeConstants.s1 * 70,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: ColorConstants.cProfile),
              child: Icon(Icons.person,
                  size: SizeConstants.s1 * 60, color: Colors.white),
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
                  style: getTextSemiBold(
                    size: SizeConstants.s1 * 25,
                  ),
                ),
                SizedBox(
                  height: SizeConstants.s1 * 5,
                ),
                Text(
                  mGetUserDetailsResponse.roleName ?? "--",
                  style: getTextMedium(
                      size: SizeConstants.s1 * 20,
                      colors: ColorConstants.cTextSecond),
                )
              ],
            )),
          ],
        ),
        Container(
          margin: EdgeInsets.all(SizeConstants.s1 * 15),
          child: Row(
            children: [
              // Expanded(
              //     child: Column(
              //   children: [
              //     Text(
              //       "Age",
              //       style: getTextMedium(
              //         size: SizeConstants.s1 * 20,
              //       ),
              //     ),
              //     SizedBox(
              //       height: SizeConstants.s1 * 8,
              //     ),
              //     Container(
              //       width: SizeConstants.s1 * 80,
              //       alignment: Alignment.center,
              //       decoration: BoxDecoration(
              //           borderRadius:
              //               BorderRadius.circular(SizeConstants.s1 * 5),
              //           border: Border.all(
              //               color: Colors.white, width: SizeConstants.s1 * 2)),
              //       padding: EdgeInsets.only(
              //         top: SizeConstants.s1 * 5,
              //         bottom: SizeConstants.s1 * 5,
              //       ),
              //       child: Text(
              //         "36",
              //         style: getTextRegular(
              //           size: SizeConstants.s1 * 18,
              //         ),
              //       ),
              //     )
              //   ],
              // )),
              Expanded(
                  child: Column(
                children: [
                  Text(
                    "Height",
                    style: getTextMedium(
                      size: SizeConstants.s1 * 20,
                    ),
                  ),
                  SizedBox(
                    height: SizeConstants.s1 * 8,
                  ),
                  Container(
                    width: SizeConstants.s1 * 80,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(SizeConstants.s1 * 5),
                        border: Border.all(
                            color: Colors.white, width: SizeConstants.s1 * 2)),
                    padding: EdgeInsets.only(
                      top: SizeConstants.s1 * 5,
                      bottom: SizeConstants.s1 * 5,
                    ),
                    child: Text(
                      mGetUserDetailsResponse.healthFitness?.height ?? "0",
                      style: getTextRegular(
                        size: SizeConstants.s1 * 18,
                      ),
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
                    ),
                  ),
                  SizedBox(
                    height: SizeConstants.s1 * 8,
                  ),
                  Container(
                    width: SizeConstants.s1 * 80,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(SizeConstants.s1 * 5),
                        border: Border.all(
                            color: Colors.white, width: SizeConstants.s1 * 2)),
                    padding: EdgeInsets.only(
                      top: SizeConstants.s1 * 5,
                      bottom: SizeConstants.s1 * 5,
                    ),
                    child: Text(
                      "${mGetUserDetailsResponse.healthFitness?.weight ?? "0"} lbs",
                      style: getTextRegular(
                        size: SizeConstants.s1 * 18,
                      ),
                    ),
                  )
                ],
              )),
            ],
          ),
        ),
        SizedBox(
          height: SizeConstants.s1 * 5,
        ),
        Container(
          height: SizeConstants.s1 * 2,
          color: ColorConstants.cSideMenuSelect,
        ),
        SizedBox(
          height: SizeConstants.s1 * 5,
        ),
      ],
    );
  }

  sideMenuMiddleView() {
    return SingleChildScrollView(
      child: Column(
        children: [
          mSideMenuDrawerModel.isSelect(AppConstants.mWordConstants.sDashboard)
              ? selectView(ImageAssets.dashboardIcon,
                  AppConstants.mWordConstants.sDashboard)
              : unSelectView(ImageAssets.dashboardDecIcon,
                  AppConstants.mWordConstants.sDashboard),
          mSideMenuDrawerModel.isSelect(AppConstants.mWordConstants.sProfile)
              ? selectView("", AppConstants.mWordConstants.sProfile,
                  icons: Icons.account_circle)
              : unSelectView("", AppConstants.mWordConstants.sProfile,
                  icons: Icons.account_circle),
          mSideMenuDrawerModel.isSelect(AppConstants.mWordConstants.sMyTeam)
              ? selectView(
                  ImageAssets.peopleIcon, AppConstants.mWordConstants.sMyTeam)
              : unSelectView(ImageAssets.peopleDecIcon,
                  AppConstants.mWordConstants.sMyTeam),
          mSideMenuDrawerModel
                  .isSelect(AppConstants.mWordConstants.sConfigureDashboard)
              ? selectView(ImageAssets.settingsIcon,
                  AppConstants.mWordConstants.sConfigureDashboard)
              : unSelectView(ImageAssets.settingsDecIcon,
                  AppConstants.mWordConstants.sConfigureDashboard),
          mSideMenuDrawerModel.isSelect(AppConstants.mWordConstants.sDevices)
              ? selectView(
                  ImageAssets.devicesIcon, AppConstants.mWordConstants.sDevices)
              : unSelectView(ImageAssets.devicesDecIcon,
                  AppConstants.mWordConstants.sDevices),
          mSideMenuDrawerModel
                  .isSelect(AppConstants.mWordConstants.sNutritionLog)
              ? selectView(ImageAssets.fastFoodIcon,
                  AppConstants.mWordConstants.sNutritionLog)
              : unSelectView(ImageAssets.fastFoodDecIcon,
                  AppConstants.mWordConstants.sNutritionLog),
          mSideMenuDrawerModel
                  .isSelect(AppConstants.mWordConstants.sConsultation)
              ? selectView(ImageAssets.dashboardIcon,
                  AppConstants.mWordConstants.sConsultation)
              : unSelectView(ImageAssets.dashboardDecIcon,
                  AppConstants.mWordConstants.sConsultation),
          mSideMenuDrawerModel
                  .isSelect(AppConstants.mWordConstants.sMyConnections)
              ? selectView(ImageAssets.dashboardIcon,
                  AppConstants.mWordConstants.sMyConnections)
              : unSelectView(ImageAssets.dashboardDecIcon,
                  AppConstants.mWordConstants.sMyConnections),
        ],
      ),
    );
  }

  selectView(String image, String text, {IconData icons = Icons.add}) {
    return GestureDetector(
        onTap: () {
          mSideMenuDrawerModel.nextView(text);
        },
        child: Container(
          color: ColorConstants.cSideMenuSelect,
          child: Row(
            children: [
              Container(
                height: SizeConstants.s1 * 55,
                width: SizeConstants.s1 * 2,
                color: ColorConstants.cSideMenuSelectText,
              ),
              SizedBox(
                width: SizeConstants.s1 * 23,
              ),
              SizedBox(
                height: SizeConstants.s1 * 28,
                width: SizeConstants.s1 * 28,
                child: image.isNotEmpty
                    ? Image.asset(image)
                    : Icon(
                        icons,
                        color: ColorConstants.cSideMenuSelectText,
                        size: SizeConstants.s1 * 28,
                      ),
              ),
              SizedBox(
                width: SizeConstants.s1 * 10,
              ),
              Text(
                text,
                style: getTextRegular(
                  colors: ColorConstants.cSideMenuSelectText,
                  size: SizeConstants.s1 * 20,
                ),
              )
            ],
          ),
        ));
  }

  unSelectView(String image, String text, {IconData icons = Icons.add}) {
    return GestureDetector(
        onTap: () {
          mSideMenuDrawerModel.nextView(text);
        },
        child: Container(
          color: Colors.transparent,
          child: Row(
            children: [
              Container(
                height: SizeConstants.s1 * 55,
                width: SizeConstants.s1 * 2,
                color: Colors.transparent,
              ),
              SizedBox(
                width: SizeConstants.s1 * 23,
              ),
              SizedBox(
                height: SizeConstants.s1 * 28,
                width: SizeConstants.s1 * 28,
                child: image.isNotEmpty
                    ? Image.asset(image)
                    : Icon(
                        icons,
                        color: Colors.white,
                        size: SizeConstants.s1 * 28,
                      ),
              ),
              SizedBox(
                width: SizeConstants.s1 * 10,
              ),
              Text(
                text,
                style: getTextRegular(
                  size: SizeConstants.s1 * 20,
                ),
              )
            ],
          ),
        ));
  }
}
