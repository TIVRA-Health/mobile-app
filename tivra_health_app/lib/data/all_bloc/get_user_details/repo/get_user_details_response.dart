/// _id : "65159bbb90da941b73bd5921"
/// firstName : "ram"
/// middleName : ""
/// lastName : "M"
/// email : "techsupport@tivrahealth.com"
/// phoneNumber : "7897897898"
/// paymentPlanRole : {"roleId":7,"planId":2,"userRoleId":7}
/// registrationId : 6
/// demographic : {"address1":"Delhi","address2":"Delhi","city":"Delhi","country":"India","dob":"2023-09-01T06:30:00.000Z","gender":"male","state":"Delhi","zip":"112233"}
/// socialProfile : {"educationLevel":"Doctorate or higher","healthCare":true,"hospitalAssociated":"","incomeRange":"$100K to $150K"}
/// healthFitness : {"chronicCondition":"No diagnosed chronic condition","height":"6 ft","smoker":false,"weight":"80"}
/// password : "Testing@123"
/// roleName : "Wellness Coaches"
/// userId : "65159bbb90da941b73bd5921"

class GetUserDetailsResponse {
  GetUserDetailsResponse({
    this.id,
    this.firstName,
    this.middleName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.paymentPlanRole,
    this.registrationId,
    this.demographic,
    this.socialProfile,
    this.healthFitness,
    this.password,
    this.roleName,
    this.userId,});

  GetUserDetailsResponse.fromJson(dynamic json) {
    id = json['_id'];
    firstName = json['firstName'];
    middleName = json['middleName'];
    lastName = json['lastName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    paymentPlanRole = json['paymentPlanRole'] != null ? PaymentPlanRole.fromJson(json['paymentPlanRole']) : null;
    registrationId = json['registrationId'];
    demographic = json['demographic'] != null ? Demographic.fromJson(json['demographic']) : null;
    socialProfile = json['socialProfile'] != null ? SocialProfile.fromJson(json['socialProfile']) : null;
    healthFitness = json['healthFitness'] != null ? HealthFitness.fromJson(json['healthFitness']) : null;
    password = json['password'];
    roleName = json['roleName'];
    userId = json['userId'];
  }
  String? id;
  String? firstName;
  String? middleName;
  String? lastName;
  String? email;
  String? phoneNumber;
  PaymentPlanRole? paymentPlanRole;
  int? registrationId;
  Demographic? demographic;
  SocialProfile? socialProfile;
  HealthFitness? healthFitness;
  String? password;
  String? roleName;
  String? userId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['firstName'] = firstName;
    map['middleName'] = middleName;
    map['lastName'] = lastName;
    map['email'] = email;
    map['phoneNumber'] = phoneNumber;
    if (paymentPlanRole != null) {
      map['paymentPlanRole'] = paymentPlanRole?.toJson();
    }
    map['registrationId'] = registrationId;
    if (demographic != null) {
      map['demographic'] = demographic?.toJson();
    }
    if (socialProfile != null) {
      map['socialProfile'] = socialProfile?.toJson();
    }
    if (healthFitness != null) {
      map['healthFitness'] = healthFitness?.toJson();
    }
    map['password'] = password;
    map['roleName'] = roleName;
    map['userId'] = userId;
    return map;
  }

}

/// chronicCondition : "No diagnosed chronic condition"
/// height : "6 ft"
/// smoker : false
/// weight : "80"

class HealthFitness {
  HealthFitness({
    this.chronicCondition,
    this.height,
    this.smoker,
    this.weight,});

  HealthFitness.fromJson(dynamic json) {
    chronicCondition = json['chronicCondition'];
    height = json['height'];
    smoker = json['smoker'];
    weight = json['weight'];
  }
  String? chronicCondition;
  String? height;
  bool? smoker;
  String? weight;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['chronicCondition'] = chronicCondition;
    map['height'] = height;
    map['smoker'] = smoker;
    map['weight'] = weight;
    return map;
  }

}

/// educationLevel : "Doctorate or higher"
/// healthCare : true
/// hospitalAssociated : ""
/// incomeRange : "$100K to $150K"

class SocialProfile {
  SocialProfile({
    this.educationLevel,
    this.healthCare,
    this.hospitalAssociated,
    this.incomeRange,});

  SocialProfile.fromJson(dynamic json) {
    educationLevel = json['educationLevel'];
    healthCare = json['healthCare'];
    hospitalAssociated = json['hospitalAssociated'];
    incomeRange = json['incomeRange'];
  }
  String? educationLevel;
  bool? healthCare;
  String? hospitalAssociated;
  String? incomeRange;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['educationLevel'] = educationLevel;
    map['healthCare'] = healthCare;
    map['hospitalAssociated'] = hospitalAssociated;
    map['incomeRange'] = incomeRange;
    return map;
  }

}

/// address1 : "Delhi"
/// address2 : "Delhi"
/// city : "Delhi"
/// country : "India"
/// dob : "2023-09-01T06:30:00.000Z"
/// gender : "male"
/// state : "Delhi"
/// zip : "112233"

class Demographic {
  Demographic({
    this.address1,
    this.address2,
    this.city,
    this.country,
    this.dob,
    this.gender,
    this.state,
    this.zip,});

  Demographic.fromJson(dynamic json) {
    address1 = json['address1'];
    address2 = json['address2'];
    city = json['city'];
    country = json['country'];
    dob = json['dob'];
    gender = json['gender'];
    state = json['state'];
    zip = json['zip'];
  }
  String? address1;
  String? address2;
  String? city;
  String? country;
  String? dob;
  String? gender;
  String? state;
  String? zip;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['address1'] = address1;
    map['address2'] = address2;
    map['city'] = city;
    map['country'] = country;
    map['dob'] = dob;
    map['gender'] = gender;
    map['state'] = state;
    map['zip'] = zip;
    return map;
  }

}

/// roleId : 7
/// planId : 2
/// userRoleId : 7

class PaymentPlanRole {
  PaymentPlanRole({
    this.roleId,
    this.planId,
    this.userRoleId,});

  PaymentPlanRole.fromJson(dynamic json) {
    roleId = json['roleId'];
    planId = json['planId'];
    userRoleId = json['userRoleId'];
  }
  int? roleId;
  int? planId;
  int? userRoleId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['roleId'] = roleId;
    map['planId'] = planId;
    map['userRoleId'] = userRoleId;
    return map;
  }

}