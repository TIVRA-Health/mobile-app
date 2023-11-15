/// message : "OTP sent successfully"

class TivraHealthRegisterScreenOtpResponse {
  TivraHealthRegisterScreenOtpResponse({
      this.message,});

  TivraHealthRegisterScreenOtpResponse.fromJson(dynamic json) {
    message = json['message'];
  }
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    return map;
  }

}