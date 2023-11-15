import 'package:flutter/material.dart';

import 'localization/locale_constant.dart';
import 'localization/localizations_delegate.dart';

abstract class WordConstants {
  static Future<WordConstants> of(BuildContext context) async {
    return AppLocalizationsDelegate.load(Locale(await getLocale(), ''));
  }

  String get appName {
    return "Member app";
  }

  ///common

  String get sSuccess {
    return 'Success';
  }

  String get sError {
    return 'Error';
  }

  ///welcome
  String get sWelcomeText {
    return "Welcome to\nAriani Family";
  }

  String get sWelcomeTextRegistered {
    return "If you are a registered\nmember, please";
  }

  String get sClickHereToRegister {
    return "Click here to register";
  }

  String get sAsAMember {
    return "as a Member";
  }

  ///Dashboard
  String get sDashboard {
    return "Dashboard";
  }

  String get sProfile {
    return "Profile";
  }

  String get sConsultation {
    return "Consultation";
  }

  String get sLogout {
    return "Logout";
  }

  String get sNutritionLog {
    return "Nutrition Log";
  }

  String get sMyTeam {
    return "My Team";
  }

  String get sConfigureDashboard {
    return "Configure Dashboard";
  }

  String get sMyConnections {
    return "My Connections";
  }

  ///device
  String get sDevices {
    return "Devices";
  }

  String get sEdit {
    return "Edit";
  }

  String get sRegister {
    return "Register";
  }

  String get sSelectADevice {
    return "Select a device";
  }

  String get sAddDevices {
    return "Add Devices";
  }

  String get sRegisteredDevices {
    return "Registered Devices";
  }

  String get sAllRegisteredDevices {
    return "All Registered Devices";
  }

  ///login mobile number screen
  String get sBelowText {
    return 'As a registered member, you agree to a ';
  }

  String get sWhatIsYourPhoneNumber {
    return 'Enter your registered Phone Number';
  }

  String get sYourPhone {
    return 'Your Phone!';
  }

  String get sLogin {
    return 'Login';
  }

  String get sEnterPhoneNumber {
    return '';
  }

  String get sPleaseEnterTheValidPhoneNumber {
    return 'Please enter the valid phone number';
  }

  String get sMobileNumberScreenTop {
    return 'Are you member?';
  }

  String get sSendOTP {
    return 'Request OTP';
  }

  String get wGoNowError {
    return "Unable to access learning site";
  }

  ///login mobile number otp screen
  String get sOTPVerification {
    return 'OTP Verification';
  }

  String get sEnterYourVerificationCode {
    return 'Enter the verification code.';
  }

  String get sCancel {
    return 'Cancel';
  }

  String get sResend {
    return 'Resend';
  }

  String get sVerifyNow {
    return 'Verify Now';
  }

  String get sPleaseEnterTheValidPhoneNumberOtp {
    return 'Please enter the valid phone number otp';
  }

  String get sDidntYouReceiveAnyCode {
    return "Click here to resend code";
  }

  String get sResendNewCode {
    return "Resend New Code";
  }

  ///register profile screen
  String get sLetGetToKnowEachOther {
    return "Let's get to know each other!";
  }

  String get sInCaseWeHaveSomethingExcitingToShare {
    return "In case we have something exciting to share";
  }

  String get sSomeMerchantsMightHaveAGiftForYou {
    return "Some merchants might have a gift for you";
  }

  String get sWhatIsYour {
    return "What's your";
  }

  String get sSkip {
    return 'Skip';
  }

  String get sContinue {
    return 'Continue';
  }

  String get sUpdate {
    return 'Update';
  }

  String get sFirstName {
    return 'First name';
  }

  String get sFullName {
    return 'Full name';
  }

  String get sEnterYourFirstName {
    return 'Enter your first name';
  }

  String get sEnterYourAddress {
    return 'Enter your address';
  }

  String get sLastName {
    return 'Last name';
  }

  String get sEnterYourLastName {
    return 'Enter your last name';
  }

  String get sDdMmYYYY {
    return 'YYYY-MM-DD';
  }

  String get sRaces {
    return 'Races';
  }

  String get sTitle {
    return 'Title';
  }

  String get sSelectTitles {
    return 'Select Titles';
  }

  String get sSelectRaces {
    return 'Select Races';
  }

  String get sGender {
    return 'Gender';
  }

  String get sSelectGender {
    return 'Select Gender';
  }

  String get sEmailPhone {
    return 'Email/Phone';
  }

  String get sEnterYourEmail {
    return 'Enter your email';
  }

  String get sPleaseEnterTheFirstName {
    return 'Please enter the First name';
  }

  String get sPleaseEnterTheAddress {
    return 'Please enter the Address';
  }

  String get sPleaseEnterTheLastName {
    return 'Please enter the last name';
  }

  String get sPleaseEnterTheEmailId {
    return 'Please enter the email id';
  }

  String get sPleaseEnterTheCity {
    return 'Please enter the city';
  }

  String get sPleaseEnterThePostalCode {
    return 'Please enter the postal code';
  }

  String get sPleaseSelectRaces {
    return 'Please select races';
  }

  String get sPleaseSelectGender {
    return 'Please select gender';
  }

  String get sPleaseSelectDob {
    return 'Please select date Of birth';
  }

  ///home screen
  String get sTabMyCard {
    return 'My Card';
  }

  String get sTabEamPoints {
    return 'Eam Points';
  }

  String get sTabReward {
    return 'Reward';
  }

  String get sTabOrder {
    return 'Order';
  }

  String get sTabMyProfile {
    return 'My Profile';
  }

  ///home my profile
  String get sEditYourProfile {
    return 'Edit Your Profile';
  }

  String get sTransactions {
    return "Transactions";
  }

  // String  get sReferAFriend { return "Refer a friend";}
  // String  get sSettings { return "Settings";}

  ///home reward
  // String  get sLoyaltyPoints { return 'Loyalty Points';}
  String get sVouchers {
    return 'Vouchers';
  }

  String get sTotalPoints {
    return 'Total points';
  }

  String get sRedeemPoints {
    return 'Redeem points';
  }

  String get sAvailablePoints {
    return 'Available points';
  }

  ///home My Card
  String get sAddToWallet {
    return 'ADD TO WALLET';
  }

  String get sLoyaltyPoints {
    return 'Loyalty Points';
  }

  String get sLatestTransaction {
    return 'Latest Transactions';
  }

  String get sYourRealRewardsCard {
    return "Your Real Rewards Card";
  }

  String get sNoTransactionsFound {
    return "No Transactions Found";
  }

  String get sNoVoucherFound {
    return "No Vouchers Found";
  }

  ///edit_profile
  String get sEditProfile {
    return 'Edit Profile';
  }

  String get sPhoneNumber {
    return 'Phone number';
  }

  String get sAddress1 {
    return 'Address1';
  }

  String get sAddress2 {
    return 'Address2';
  }

  String get sPostalCode {
    return 'Postal code';
  }

  String get sCity {
    return 'City';
  }

  String get sSave {
    return 'Save';
  }

  String get sDeleteProfile {
    return 'Delete Profile';
  }

  String get wGallery {
    return "Gallery";
  }

  String get wCamera {
    return "Camera";
  }

  ///pull_to_refresh
  String get wPullUpLoad {
    return "Pull up load";
  }

  String get wLoadFailedClickRetry {
    return "Load Failed!Click retry!";
  }

  String get wNoMoreData {
    return "No more Data";
  }

  String get wHealth {
    return "Health";
  }

  String get wFitness {
    return "Fitness";
  }

  String get wNutrition {
    return "Nutrition";
  }

  String get wMyInvites {
    return "My Invites";
  }

  String get wResend {
    return "Resend";
  }

  String get wRenew {
    return "Renew";
  }

  String get wMyApprovals {
    return "My Approvals";
  }

  String get wStartYourJourney {
    return "Start your journey";
  }

  String get wSplashPageText {
    return "Smart platform\nto track your fitness";
  }

  String get wSplashPageBottomText {
    return "Tailored subscriptions to your specific needs";
  }

  ///Dashboard configuration
  String get sActiveDevices {
    return "Active Devices";
  }

  String get sDashboardPreference {
    return "My Dashboard Preference";
  }

  String get sTeamPreference {
    return "My Team Preference";
  }

  String get sSelectDevice {
    return "Select Device";
  }

  ///login
  String get sUserName {
    return "User Name";
  }

  String get sEnterTheUserName {
    return "Enter the user name";
  }

  String get sEnterTheUserEmailPhone {
    return "Enter the Email/Phone number";
  }

  String get sPassword {
    return "Password";
  }

  String get sConfirmPassword {
    return "Confirm Password";
  }

  String get sNewPassword {
    return "New Password";
  }

  String get sRememberPassword {
    return "Remember password";
  }

  String get sForgotPassword {
    return "Forgot password?";
  }

  String get sForgotPasswordText {
    return "Forgot Password";
  }

  String get sVerifyOTP {
    return "OTP Verification";
  }

  String get sResetPasswordText {
    return "Reset Password";
  }

  String get sDoNotHaveAnAccount {
    return "Don’t have an account?";
  }

  String get sEnterThePassword {
    return "Enter the password";
  }

  String get sEnterTheConfirmPassword {
    return "Enter the confirm password";
  }

  String get sEnterTheNewPassword {
    return "Enter the new password";
  }

  String get wSignIn {
    return "Sign in";
  }

  String get wSendVerificationLink {
    return "Send Verification Link";
  }

  String get wSendOTP {
    return "Send OTP";
  }

  String get wVerifyOTP {
    return "Verify OTP";
  }

  String get wSignUp {
    return "Sign Up";
  }

  String get wSmartPlatform {
    return "Smart platform";
  }

  String get wTotalMember {
    return "Total member";
  }

  String get wPlayersList {
    return "Players List";
  }

  String get wMyTeamNoList {
    return "It seems like you have not\nadded any players to your team yet.";
  }

  String get wNoDataFound {
    return "No Data Found";
  }

  String get wToTrackYourFitness {
    return "to track your fitness";
  }

  String get sEnterEmailId {
    return "Enter email id";
  }

  String get sSubject {
    return "Subject";
  }

  String get sInvite {
    return "Invite";
  }

  String get wItUnderDevelopment {
    return "It's a under development";
  }

  ///registration
  String get sMiddleName {
    return "Middle Name";
  }

  String get sEmailHint {
    return "Email (This will be your username)";
  }

  String get sMobileNumberHint {
    return "Phone Number (Mobile)";
  }

  String get sCreateYourAccount {
    return "Create your account";
  }

  String get sVerificationMessage {
    return "A one-time verification code has been sent to your above email ID. Please enter the code below and click verify.";
  }

  String get sChangeEmail {
    return "Change email";
  }

  String get sOTP {
    return "OTP";
  }

  String get sVerify {
    return 'Verify';
  }

  String get sPaymentDetails {
    return 'Payment Details';
  }

  String get sPleaseSelectYourProfile {
    return 'Please select your profile';
  }

  String get sRoleSelection {
    return 'Role Selection';
  }

  String get sProceed {
    return 'Proceed';
  }

  String get sOrganizationName {
    return 'Organization Name';
  }

  String get sTypeOfEngagement {
    return 'Type of Engagement';
  }

  String get sYearsOfCoaching {
    return 'Years Of Coaching';
  }

  String get sCorporateAddress1 {
    return 'Corporate Address 1';
  }

  String get sNpi {
    return 'NPI';
  }

  String get sCorporateAddress2 {
    return 'Corporate Address 2';
  }

  String get sState {
    return 'State';
  }

  String get sZipcode {
    return 'Zipcode';
  }

  String get sCountry {
    return 'Country';
  }

  String get sBack {
    return 'Back';
  }

  String get sDateOfBirth {
    return 'Date of birth';
  }

  String get sStreetAddress1 {
    return 'Street Address 1';
  }

  String get sStreetAddress2 {
    return 'Street Address 2';
  }

  String get sHighestEducation {
    return 'Highest Level of Education';
  }

  String get sHouseholdIncome {
    return 'Household Income Range';
  }

  String get sAccessToHealthCare {
    return 'Access to health care';
  }

  String get sHospitalSystem {
    return 'Hospital System Associated with';
  }

  String get sYes {
    return 'Yes';
  }

  String get sNo {
    return 'No';
  }

  String get sWeight {
    return 'Weight';
  }

  String get sHeight {
    return 'Height';
  }

  String get sSmoker {
    return 'Smoker';
  }

  String get sDeviceRegistration {
    return 'Device Registration';
  }

  String get sAlreadyHadAnAccount {
    return 'Already have an account?';
  }

  String get sSignIn {
    return 'Sign In';
  }

  String get sFirstNameError {
    return 'Enter First Name';
  }

  String get sLastNameError {
    return 'Enter Last Name';
  }

  String get sEmailError {
    return 'Enter Valid Email';
  }

  String get sMobileError {
    return 'Enter Phone Number';
  }

  String get sOTPError {
    return 'Enter valid OTP';
  }

  String get sPwdError {
    return 'Password must have at least 8 characters, one letter, one number, and one special character';
  }

  String get sConfirmPwdError {
    return 'Password and Confirm Password does not match';
  }

  String get sSelectPricing {
    return 'Select Pricing';
  }

  String get sCreateAthleteProfile {
    return 'Create your Athlete Profile';
  }

  String get sCreateAthleteCoachProfile {
    return 'Create your Athlete Coach Profile';
  }

  String get sAthlete {
    return 'Athlete';
  }

  String get sAthleteCoach {
    return 'Athletic Coach';
  }

  String get sOrgError {
    return 'Enter Organization Name';
  }

  String get sTypeEngagementError {
    return 'Select Type of Engagement';
  }

  String get sYearsOfCoachingError {
    return 'Enter Years of Coaching';
  }

  String get sCorporateAdd1Error {
    return 'Enter Corporate Address 1';
  }

  String get sNpiError {
    return 'Enter NPI Number';
  }

  String get sCityError {
    return 'Enter City';
  }

  String get sStateError {
    return 'Enter State';
  }

  String get sZipcodeError {
    return 'Enter Zipcode';
  }

  String get sCountryError {
    return 'Enter Country';
  }

  String get sStreetAdd1Error {
    return 'Enter Street Address 1';
  }

  String get sDobError {
    return 'Select DOB';
  }

  String get sEducationError {
    return 'Select Highest Level of Education';
  }

  String get sIncomeRangeError {
    return 'Enter Household Income Range';
  }

  String get sHealthcareError {
    return 'Select Health Care';
  }

  String get sChronicConditions {
    return 'Chronic Conditions';
  }

  String get sHeightError {
    return 'Select Height';
  }

  String get sWeightError {
    return 'Enter Weight';
  }

  String get sChronicConditionError {
    return 'Select Chronic Conditions';
  }

  String get sSmokeError {
    return 'Select Smoker';
  }

  String get sDemographicProfile {
    return 'Demographic \nProfile';
  }

  String get sSocialProfile {
    return 'Social \nProfile';
  }

  String get sHealthAndFitnessProfile {
    return 'Health & Fitness \nProfile';
  }

  String get sCorporateAffiliation {
    return 'Corporate \nAffiliation';
  }

  String get wPleaseEnterUsernameText {
    return "Please enter username";
  }

  String get wPleaseEnterPasswordText {
    return "Please enter password";
  }

  String get wSomethingWentWrong {
    return 'Something went wrong, try again later!';
  }

  String get sCreateYour {
    return 'Create your ';
  }

}
