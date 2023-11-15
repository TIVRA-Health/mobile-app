/// valid : true
/// message : "OTP is valid"

class TivraHealthVerifyOTPResponse {
  TivraHealthVerifyOTPResponse({
      this.valid, 
      this.message,});

  TivraHealthVerifyOTPResponse.fromJson(dynamic json) {
    valid = json['valid'];
    message = json['message'];
  }
  bool? valid;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['valid'] = valid;
    map['message'] = message;
    return map;
  }

}