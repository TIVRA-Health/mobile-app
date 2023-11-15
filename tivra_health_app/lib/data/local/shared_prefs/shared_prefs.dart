import 'package:tivra_health/data/remote/web_request.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pref_constants.dart';

class SharedPrefs {
  // Singleton approach
  static final SharedPrefs _instance = SharedPrefs._internal();

  factory SharedPrefs() => _instance;

  SharedPrefs._internal();

  SharedPreferences? sharedPreferences;

  sharedPreferencesInstance() async {
    if (sharedPreferences == null) {
      return sharedPreferences = await SharedPreferences.getInstance();
    } else {
      return sharedPreferences;
    }
  }

  ///getDecrypted
  getDecryptedString(String key) {
    // if (sharedPreferences != null) {
    //   if (AppConstants.isSharedPrefToEncrypt) {
    //     String value = sharedPreferences!.getString(key) ?? "";
    //     if (value.isNotEmpty) {
    //       return CryptoUtils.decryptedPayload(value);
    //     }
    //   } else {
        return sharedPreferences!.getString(key) ?? "";
    //   }
    // }
  }

  ///setEncrypted
  setEncryptedString(String key, String value) {
    // if (sharedPreferences != null) {
    //   if (AppConstants.isSharedPrefToEncrypt) {
    //     if (value.isNotEmpty) {
    //       String encryptedStringValue = CryptoUtils.encryptedString(value);
    //       sharedPreferences!.setString(key, encryptedStringValue);
    //     }
    //   } else {
        sharedPreferences!.setString(key, value);
    //   }
    // }
  }

  /// User Id
  Future<void> setUserId(String? sUserId) async {
    WebRequest.sUserId = sUserId ?? "";
    setEncryptedString(PrefConstants.sUserId, sUserId ?? "");
  }

  Future<String> getUserId() async {
    WebRequest.sUserId = getDecryptedString(PrefConstants.sUserId) ?? "";
    return WebRequest.sUserId.isNotEmpty?(getDecryptedString(PrefConstants.sUserId) ?? ""):"";
  }

  /// App Token
  Future<void> setUserToken(String? bearerToken) async {
    WebRequest.sBearerToken = bearerToken ?? "";
    setEncryptedString(PrefConstants.token, bearerToken ?? "");
  }

  Future<String> getUserToken() async {
    WebRequest.sBearerToken = getDecryptedString(PrefConstants.token) ?? "";
    return WebRequest.sBearerToken.isNotEmpty?(getDecryptedString(PrefConstants.token) ?? ""):"";
  }


  ///save initial data of user
  Future<void> saveInitialData(String? initialData) async {
    WebRequest.sInitialRegistrationData = initialData ?? "";
    setEncryptedString(PrefConstants.sInitialData, initialData ?? "");
  }

  Future<String> getInitialData() async {
    WebRequest.sInitialRegistrationData = getDecryptedString(PrefConstants.sInitialData) ?? "";
    return WebRequest.sInitialRegistrationData.isNotEmpty?(getDecryptedString(PrefConstants.sInitialData) ?? ""):"";
  }

  ///save payment methods
  Future<void> savePaymentMethods(String? paymentMethods) async {
    WebRequest.sPaymentMethod = paymentMethods ?? "";
    setEncryptedString(PrefConstants.sPaymentMethods, paymentMethods ?? "");
  }

  Future<String> getPaymentMethods() async {
    WebRequest.sPaymentMethod = getDecryptedString(PrefConstants.sPaymentMethods) ?? "";
    return WebRequest.sPaymentMethod.isNotEmpty?(getDecryptedString(PrefConstants.sPaymentMethods) ?? ""):"";
  }

  /// set Corporate Affiliation
  Future<void> setCorporateAffiliation(String sCorporateAffiliation) async {
    WebRequest.sCorporateAffiliation = sCorporateAffiliation ?? "";
    setEncryptedString(PrefConstants.sCorporateAffiliation, sCorporateAffiliation ?? "");
  }

  /// get Corporate Affiliation
  Future<String> getCorporateAffiliation() async {
    WebRequest.sCorporateAffiliation = getDecryptedString(PrefConstants.sCorporateAffiliation) ?? "";
    return WebRequest.sCorporateAffiliation.isNotEmpty?(getDecryptedString(PrefConstants.sCorporateAffiliation) ?? ""):"";
  }

  /// UserDetails
  Future<void> setUserDetails(String? sUserDetails) async {
    WebRequest.sUserDetails = sUserDetails ?? "";
    setEncryptedString(PrefConstants.sUserDetails, sUserDetails ?? "");
  }

  Future<String> getUserDetails() async {
    WebRequest.sUserDetails = getDecryptedString(PrefConstants.sUserDetails) ?? "";
    return WebRequest.sUserDetails.isNotEmpty?(getDecryptedString(PrefConstants.sUserDetails) ?? ""):"";
  }

  /// AllImage
  Future<void> setAllImage(String? sAllImage) async {
    WebRequest.sAllImage = sAllImage ?? "";
    setEncryptedString(PrefConstants.sAllImage, sAllImage ?? "");
  }

  Future<String> getAllImage() async {
    WebRequest.sAllImage = getDecryptedString(PrefConstants.sAllImage) ?? "";
    return WebRequest.sAllImage.isNotEmpty?(getDecryptedString(PrefConstants.sAllImage) ?? ""):"";
  }

  /// User name
  Future<void> setUserName(String? sUserName) async {
    WebRequest.sUserName = sUserName ?? "";
    setEncryptedString(PrefConstants.sUserName, sUserName ?? "");
  }

  Future<String> getUserName() async {
    WebRequest.sUserName = getDecryptedString(PrefConstants.sUserName) ?? "";
    return WebRequest.sUserName.isNotEmpty?(getDecryptedString(PrefConstants.sUserName) ?? ""):"";
  }

  /// password
  Future<void> setUserPassword(String? sUserPassword) async {
    WebRequest.sUserPassword = sUserPassword ?? "";
    setEncryptedString(PrefConstants.sUserPassword, sUserPassword ?? "");
  }

  Future<String> getUserPassword() async {
    WebRequest.sUserPassword = getDecryptedString(PrefConstants.sUserPassword) ?? "";
    return WebRequest.sUserPassword.isNotEmpty?(getDecryptedString(PrefConstants.sUserPassword) ?? ""):"";
  }

  /// set Device List
  Future<void> setDeviceList(String sDeviceList) async {
    WebRequest.sDeviceList = sDeviceList ?? "";
    setEncryptedString(PrefConstants.sDeviceList, sDeviceList ?? "");
  }

  /// get Device List
  Future<String> getDeviceList() async {
    WebRequest.sDeviceList = getDecryptedString(PrefConstants.sDeviceList) ?? "";
    return WebRequest.sDeviceList.isNotEmpty?(getDecryptedString(PrefConstants.sDeviceList) ?? ""):"";
  }

  /// set Dashboard Preference
  Future<void> setMyDashboardPreference(String sPreference) async {
    WebRequest.sMyDashboardPreference = sPreference ?? "";
    setEncryptedString(PrefConstants.sMyDashboardPreference, sPreference ?? "");
  }

  /// get Dashboard Preference
  Future<String> getMyDashboardPreference() async {
    WebRequest.sMyDashboardPreference = getDecryptedString(PrefConstants.sMyDashboardPreference) ?? "";
    return WebRequest.sMyDashboardPreference.isNotEmpty?(getDecryptedString(PrefConstants.sMyDashboardPreference) ?? ""):"";
  }

  /// set Team Preference
  Future<void> setMyTeamPreference(String sPreference) async {
    WebRequest.sMyTeamPreference = sPreference ?? "";
    setEncryptedString(PrefConstants.sMyTeamPreference, sPreference ?? "");
  }

  /// get Team Preference
  Future<String> getMyTeamPreference() async {
    WebRequest.sMyTeamPreference = getDecryptedString(PrefConstants.sMyTeamPreference) ?? "";
    return WebRequest.sMyTeamPreference.isNotEmpty?(getDecryptedString(PrefConstants.sMyTeamPreference) ?? ""):"";
  }

  /// set dashboard config
  Future<void> setDashboardConfig(String sDashboardConfig) async {
    WebRequest.sGetDashboardConfig = sDashboardConfig ?? "";
    setEncryptedString(PrefConstants.sGetDashboardConfig, sDashboardConfig ?? "");
  }

  /// get dashboard config
  Future<String> getDashboardConfig() async {
    WebRequest.sGetDashboardConfig = getDecryptedString(PrefConstants.sGetDashboardConfig) ?? "";
    return WebRequest.sGetDashboardConfig.isNotEmpty?(getDecryptedString(PrefConstants.sGetDashboardConfig) ?? ""):"";
  }

  /// set payment URL
  Future<void> setPaymentUrl(String sUrl) async {
    WebRequest.sPaymentURL = sUrl ?? "";
    setEncryptedString(PrefConstants.sPaymentURL, sUrl ?? "");
  }

  /// get payment URL
  Future<String> getPaymentUrl() async {
    WebRequest.sPaymentURL = getDecryptedString(PrefConstants.sPaymentURL) ?? "";
    return WebRequest.sPaymentURL.isNotEmpty?(getDecryptedString(PrefConstants.sPaymentURL) ?? ""):"";
  }

  /// set nutrition log on date
  Future<void> setNutritionLogOnDate(String nutritionLogOnDate) async {
    WebRequest.sNutritionLogOnDate = nutritionLogOnDate ?? "";
    setEncryptedString(PrefConstants.sNutritionLogOnDate, nutritionLogOnDate ?? "");
  }

  /// get nutrition log on date
  Future<String> getNutritionLogOnDate() async {
    WebRequest.sNutritionLogOnDate = getDecryptedString(PrefConstants.sNutritionLogOnDate) ?? "";
    return WebRequest.sNutritionLogOnDate.isNotEmpty?(getDecryptedString(PrefConstants.sNutritionLogOnDate) ?? ""):"";
  }

  /// set food list
  Future<void> setFoodList(String foodList) async {
    WebRequest.sFoodList = foodList ?? "";
    setEncryptedString(PrefConstants.sFoodList, foodList ?? "");
  }

  /// get food list
  Future<String> getFoodList() async {
    WebRequest.sFoodList = getDecryptedString(PrefConstants.sFoodList) ?? "";
    return WebRequest.sFoodList.isNotEmpty?(getDecryptedString(PrefConstants.sFoodList) ?? ""):"";
  }

  /// set Message
  Future<void> setMessage(String message) async {
    WebRequest.sMessage = message ?? "";
    setEncryptedString(PrefConstants.sMessage, message ?? "");
  }

  /// get Message
  Future<String> getMessage() async {
    WebRequest.sMessage = getDecryptedString(PrefConstants.sMessage) ?? "";
    return WebRequest.sMessage.isNotEmpty?(getDecryptedString(PrefConstants.sMessage) ?? ""):"";
  }

  /// set Registered devices
  Future<void> setRegisteredDevices(String registeredDevices) async {
    WebRequest.sRegisteredDevices = registeredDevices ?? "";
    setEncryptedString(PrefConstants.sRegisteredDevices, registeredDevices ?? "");
  }

  /// get Registered devices
  Future<String> getRegisteredDevices() async {
    WebRequest.sRegisteredDevices = getDecryptedString(PrefConstants.sRegisteredDevices) ?? "";
    return WebRequest.sRegisteredDevices.isNotEmpty?(getDecryptedString(PrefConstants.sRegisteredDevices) ?? ""):"";
  }

  /// set Registered devices
  Future<void> setUploadFood(String uploadFood) async {
    WebRequest.sUploadFood = uploadFood ?? "";
    setEncryptedString(PrefConstants.sUploadFood, uploadFood ?? "");
  }

  /// get Registered devices
  Future<String> getUploadFood() async {
    WebRequest.sUploadFood = getDecryptedString(PrefConstants.sUploadFood) ?? "";
    return WebRequest.sUploadFood.isNotEmpty?(getDecryptedString(PrefConstants.sUploadFood) ?? ""):"";
  }

  Future<void> setFirstLaunch(String firstLaunch) async {
    WebRequest.sFirstLaunch = firstLaunch ?? "";
    setEncryptedString(PrefConstants.sFirstLaunch, firstLaunch ?? "");
  }

  Future<String> getFirstLaunch() async {
    WebRequest.sFirstLaunch = getDecryptedString(PrefConstants.sFirstLaunch) ?? "";
    return WebRequest.sFirstLaunch.isNotEmpty?(getDecryptedString(PrefConstants.sFirstLaunch) ?? ""):"";
  }

  ///clear all
  Future<bool> clearSharedPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.clear();
  }
}
