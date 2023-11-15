import 'package:tivra_health/common/app_constants.dart';

class WebConstants {
  /// Standard Comparison Values
  static int statusCode200 = 200;
  static int statusCode400 = 400;
  static int statusCode422 = 422;

  static String statusMessageOK = "OK";
  static String statusMessageBadRequest = "Bad Request";
  static String statusMessageEntityError = "Unprocessable Entity Error";
  static String statusMessageTokenIsExpired = "Token is Expired";

  /// Web response cases
  static String statusCode200Message =
      "{  \"error\" : true,\n  \"statusCode\" : 200,\n  \"statusMessage\" : \"Success Request\",\n  \"data\" : {\"message\":\" Success \"},\n  \"responseTime\" : 1639548038\n  }";
  static String statusCode401Message =
      "{  \"error\" : true,\n  \"statusCode\" : 401,\n  \"statusMessage\" : \"Unauthenticated\",\n  \"data\" : {\"message\":\"Unauthenticated\"},\n  \"responseTime\" : 1639548038\n  }";
  static String statusCode403Message =
      "{  \"error\" : true,\n  \"statusCode\" : 403,\n  \"statusMessage\" : \"Bad Request\",\n  \"data\" : {\"message\":\"Unauthorized error\"},\n  \"responseTime\" : 1639548038\n  }";
  static String statusCode404Message =
      "{  \"error\" : true,\n  \"statusCode\" : 404,\n  \"statusMessage\" : \"Bad Request\",\n  \"data\" : {\"message\":\"Unable to find the action URL\"},\n  \"responseTime\" : 1639548038\n  }";
  static String statusCode412Message =
      "{  \"error\" : true,\n  \"statusCode\" : 412,\n  \"statusMessage\" : \"Bad Request\",\n  \"data\" : {\"message\":\"Unable to find the action URL\"},\n  \"responseTime\" : 1639548038\n  }";
  static String statusCode422Message =
      "{  \"error\" : true,\n  \"statusCode\" : 412,\n  \"statusMessage\" : \"Bad Request\",\n  \"data\" : {\"message\":\"Unable to find the action URL\"},\n  \"responseTime\" : 1639548038\n  }";
  static String statusCode502Message =
      "{\r\n  \"error\": true,\r\n  \"statusCode\": 502,\r\n  \"statusMessage\": \"Bad Request\",\r\n  \"data\": {\r\n    \"message\": \"Server Error, Please try after sometime\"\r\n  },\r\n  \"responseTime\": 1639548038\r\n}";
  static String statusCode503Message =
      "{  \"error\" : true,\n  \"statusCode\" : 503,\n  \"statusMessage\" : \"Bad Request\",\n  \"data\" : {\"message\":\"Unable to process your request right now, Please try again later\"},\n  \"responseTime\" : 1639548038\n  }";

  /// Control

  /// Base URL
  static String baseUrlLive = "https://uattivrafit.com/";
  static String baseUrlDev = "https://uattivrafit.com/";
  static String baseURL =  AppConstants.isLiveURLToUse
          ? baseUrlLive
          : baseUrlDev;
  /// LoginScreen post
  static String actionTivraHealthLoginScreen = "${baseURL}account/login";
  /// Get user details
  static String actionGetUserDetails = "${baseURL}user/";
  /// Dashboard Details get
  static String actionGetDashboardDetails = "${baseURL}dashboard/data/";
  /// Dashboard image get
  static String actionGetImage = "${baseURL}image/icon/loadAll";
  ///invite
  static String actionInvite = "${baseURL}invite";
  ///invite/sent
  static String actionInviteSent = "${baseURL}invite/sent/";
  ///invite/Receive
  static String actionInviteReceive = "${baseURL}invite/receive/";
  /// invite update
  static String actionInviteUpdate = "${baseURL}invite/update";
  /// MyTeamList get
  static String actionMyTeamList = "${baseURL}team/info/";
  /// Registration POST
  static String actionTivraHealthRegisterAccountScreen = "${baseURL}account/register";
  /// Generate OTP POST
  static String actionTivraHealthRegisterAccountOtp = "${baseURL}account/otp-generate";
  /// Verify OTP POST
  static String actionTivraHealthRegisterVerifyOtp = "${baseURL}account/otp-validate";
  /// DeviceRegistration
  static String actionDeviceRegistration = "${baseURL}device/device-session";
  /// create Account
  static String actionTivraHealthRegisterCreateAccount = "${baseURL}user/account";
  /// Payment Methods GET
  static String actionPaymentMethods = "${baseURL}plan/payment-plan-role";
  /// User role PUT
  static String actionUserRole = "${baseURL}user/role";
  /// Devices List get
  static String actionDevicesList = "${baseURL}device/";
  /// demographic profile PUT
  static String actionDemographicProfile = "${baseURL}user/demographic";
  /// social profile PUT
  static String actionSocialProfile = "${baseURL}user/social";
  /// health and fitness profile PUT
  static String actionHealthAndFitnessProfile = "${baseURL}user/healthFitness";
  /// get My Dashboard preference GET
  static String actionGetMyDashboardPreference = "${baseURL}dashboard/config/preference/dashboard/";
  /// get My Dashboard preference GET
  static String actionGetMyTeamPreference = "${baseURL}dashboard/config/preference/team/";
  /// get My Dashboard Config GET
  static String actionGetDashboardConfig = "${baseURL}dashboard/config/";
  /// get Payment link
  static String actionPaymentLink = "${baseURL}payment/create/payment-link";
  /// get nutrition log date
  static String actionNutritionLogBasedOnDate = "${baseURL}nutrition-log/";
  /// food search
  static String actionFoodSearch = "${baseURL}nutrition/search/";
  /// AI Consultation
  static String actionConsultation = "${baseURL}openai/chat";

  /// Nutrition food details
  static String actionFoodDetails = "${baseURL}nutrition/food-detail";

  ///upload food
  static String actionUploadFood = "${baseURL}nutrition-log/upload";

  ///save dashboard
  static String actionDashboardPreference = "${baseURL}dashboard/config/preference/dashboard";

  ///save team
  static String actionTeamPreference = "${baseURL}dashboard/config/preference/team";

  ///save dashboardConfig
  static String actionSaveDashboardConfig = "${baseURL}dashboard/config";

  ///ResetPassword
  static String actionResetPassword = "${baseURL}account/reset-password";

  ///Corporate Affiliation PUT
  static String actionCorporateAffiliation= "${baseURL}user/corporateAssociation";

  ///Address
  static String actionAddress = "${baseURL}google/validate/address";

  ///NPI
  static String actionNpi = "${baseURL}organization/npi/validate/";
}
