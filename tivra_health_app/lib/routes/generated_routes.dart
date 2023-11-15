import 'package:flutter/material.dart';
import 'package:tivra_health/modules/consultation/consultation_details/view/consultation_details_screen.dart';
import 'package:tivra_health/modules/consultation/view/consultation_screen.dart';
import 'package:tivra_health/modules/dashboard/view/dashboard_screen.dart';
import 'package:tivra_health/modules/dashboard_preference/view/dashboard_preference_screen.dart';
import 'package:tivra_health/modules/devices/view/devices_screen.dart';
import 'package:tivra_health/modules/forgot_password_screen/model/forgot_password_screen_model.dart';
import 'package:tivra_health/modules/forgot_password_screen/view/forgot_password_screen.dart';
import 'package:tivra_health/modules/forgot_password_screen/view/otp_verification_screen.dart';
import 'package:tivra_health/modules/login_screen/view/login_screen.dart';
import 'package:tivra_health/modules/masters/devices_list/view/device_list.dart';
import 'package:tivra_health/modules/masters/devices_multiple_select_list/view/device_multiple_list.dart';
import 'package:tivra_health/modules/my_profile/edit_profile/view/edit_demographic_profile.dart';
import 'package:tivra_health/modules/my_profile/edit_profile/view/edit_health_and_fitness_profile.dart';
import 'package:tivra_health/modules/my_profile/edit_profile/view/edit_profile_screen.dart';
import 'package:tivra_health/modules/my_profile/edit_profile/view/edit_social_profile.dart';
import 'package:tivra_health/modules/my_profile/view/my_profile_screen.dart';
import 'package:tivra_health/modules/nutrition_log/view/break_fast_screen.dart';
import 'package:tivra_health/modules/registration/view/registration_flow.dart';
import 'package:tivra_health/modules/my_connections/view/my_connections_screen.dart';
import 'package:tivra_health/modules/my_team/item_details/view/player_details_screen.dart';
import 'package:tivra_health/modules/my_team/view/my_team_screen.dart';
import 'package:tivra_health/modules/nutrition_log/view/nutrition_log_screen.dart';
import 'package:tivra_health/modules/reset_password_screen/view/reset_password_screen.dart';
import 'package:tivra_health/modules/splash/view/splash_screen.dart';
import 'package:tivra_health/routes/route_animator.dart';
import 'route_constants.dart';

class GeneratedRoutes {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    final args = routeSettings.arguments;
    final String routeName = routeSettings.name.toString();

    switch (routeName) {
      // Common
      case RouteConstants.rSplashScreenWidget:
        return MaterialPageRoute(
            builder: (context) => const SplashScreenWidget());

      case RouteConstants.rLoginScreenWidget:
        return MaterialPageRoute(
            builder: (context) => const LoginScreenWidget());

      case RouteConstants.rForgotPasswordScreenWidget:
        return MaterialPageRoute(
            builder: (context) => const ForgotPasswordScreenWidget());

      case RouteConstants.rResetPasswordScreenWidget:
        return MaterialPageRoute(
            builder: (context) => ResetPasswordScreenWidget(email : args as String));

      case RouteConstants.rOTPVerificationScreenWidget:
        return MaterialPageRoute(builder: (context) => OTPScreenWidget(forgotPasswordScreenModel : args as ForgotPasswordScreenModel));

      case RouteConstants.rDashboardScreenWidget:
        return MaterialPageRoute(
            builder: (context) => const DashboardScreenWidget());

      case RouteConstants.rMyProfileScreenWidget:
        return MaterialPageRoute(
            builder: (context) => const MyProfileScreenWidget());

      case RouteConstants.rEditProfileScreenWidget:
        return MaterialPageRoute(
            builder: (context) => const EditProfileScreenWidget());

      case RouteConstants.rEditSocialProfile:
        return MaterialPageRoute(
            builder: (context) => const EditSocialProfile());

      case RouteConstants.rEditHealthAndFitnessProfile:
        return MaterialPageRoute(
            builder: (context) => const EditHealthAndFitnessProfile());

      case RouteConstants.rEditDemographicProfile:
        return MaterialPageRoute(
            builder: (context) => const EditDemographicProfile());

      case RouteConstants.rDevicesScreenWidget:
        return MaterialPageRoute(
            builder: (context) => const DevicesScreenWidget());

      case RouteConstants.rMasterDevicesListScreenWidget:
        return RouteAnimator(page: MasterDevicesScreenList(registeredDeviceList: args as List<String> ?? []));

      case RouteConstants.rDashboardPreferenceScreenWidget:
        return MaterialPageRoute(
            builder: (context) => const DashboardPreferenceScreenNew());

      case RouteConstants.rMyTeamScreenWidget:
        return MaterialPageRoute(
            builder: (context) => const MyTeamScreenWidget());

      case RouteConstants.rMyConnectionsScreenWidget:
        return MaterialPageRoute(
            builder: (context) => const MyConnectionsScreenWidget());

      case RouteConstants.rConsultationScreenWidget:
        return MaterialPageRoute(
            builder: (context) => const ConsultationScreenWidget());

      case RouteConstants.rNutritionLogScreenWidget:
        return MaterialPageRoute(
            builder: (context) => const NutritionLogScreenWidget());

      case RouteConstants.rConsultationDetailsScreenWidget:
        return MaterialPageRoute(
            builder: (context) => ConsultationDetailsScreenWidget(
                  getId: args.toString(),
                ));

      case RouteConstants.rPlayerDetailsScreenWidget:
        return MaterialPageRoute(
            builder: (context) => PlayerDetailsScreenWidget(
                  playerId: args.toString(),
                ));

      case RouteConstants.rMasterMultipleDevicesScreenList:
        return RouteAnimator(
            page: MasterMultipleDevicesScreenList(
          sMultipleDevicesListItems: args as List<String>,
        ));

      case RouteConstants.rRegistrationFlow:
        return MaterialPageRoute(
            builder: (context) => const RegistrationFlow());

      case RouteConstants.rSearchFood:
        return MaterialPageRoute(
            builder: (context) => BreakFastScreen(item: args as List<String>));

      //   case RouteConstants.rCommonWebView:
      //   return MaterialPageRoute(
      //       builder: (context) =>  CommonWebView(sWebView: args as WebModel,));
      //

      // case RouteConstants.rLoginMobileNumberScreenWidget:
      //   return MaterialPageRoute(
      //       builder: (context) => const LoginMobileNumberScreenWidget());
      //
      // case RouteConstants.rLoginMobileNumberOtpScreenWidget:
      //   return MaterialPageRoute(
      //       builder: (context) => LoginMobileNumberOtpScreenWidget(
      //             sMobileNumber: args.toString(),
      //           ));
      // case RouteConstants.rHomeScreenWidget:
      //   return MaterialPageRoute(
      //       builder: (context) => const HomeScreenWidget());
      //
      // case RouteConstants.rTransactionScreenWidget:
      //   return MaterialPageRoute(
      //       builder: (context) => const TransactionScreenWidget());
      //
      // case RouteConstants.rEditProfileScreenWidget:
      //   return MaterialPageRoute(
      //       builder: (context) => EditProfileScreenWidget(
      //             mCallbackModel: args as CallbackModel,
      //           ));

      default:
        return _routeNotFound(sRouteName: " - $routeName");
    }
  }

  static Route<dynamic> _routeNotFound({String sRouteName = ""}) {
    return MaterialPageRoute(builder: (context) {
      return Scaffold(
        body: Center(
          child: Text("Page not found!$sRouteName"),
        ),
      );
    });
  }
}
