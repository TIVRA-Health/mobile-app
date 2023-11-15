/// "username": "techsupport@tivrahealth.com",
/// "password": "Testing@123"

class TivraHealthRegisterScreenVerifyOTPRequest {
  TivraHealthRegisterScreenVerifyOTPRequest({
    String? emailId,
    String? otp,
  }) {
    _emailId = emailId;
    _otp = otp;
  }

  TivraHealthRegisterScreenVerifyOTPRequest.fromJson(dynamic json) {
    _emailId = json['emailId'];
    _otp = json['otp'];
  }

  String? _emailId;
  String? _otp;

  String? get emailId => _emailId;
  String? get otp => _otp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['emailId'] = _emailId;
    map['otp'] = _otp;
    return map;
  }
}
