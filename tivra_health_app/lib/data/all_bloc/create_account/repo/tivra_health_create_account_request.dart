/// userId : "6514083795e87ff3c198e756"
/// otp : "u0aFvj"
/// password : "Testing@123"
/// registrationId : 1

class TivraHealthCreateAccountRequest {
  TivraHealthCreateAccountRequest({
      this.userId, 
      this.otp, 
      this.password, 
      this.registrationId,});

  TivraHealthCreateAccountRequest.fromJson(dynamic json) {
    userId = json['userId'];
    otp = json['otp'];
    password = json['password'];
    registrationId = json['registrationId'];
  }
  String? userId;
  String? otp;
  String? password;
  num? registrationId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = userId;
    map['otp'] = otp;
    map['password'] = password;
    map['registrationId'] = registrationId;
    return map;
  }

}