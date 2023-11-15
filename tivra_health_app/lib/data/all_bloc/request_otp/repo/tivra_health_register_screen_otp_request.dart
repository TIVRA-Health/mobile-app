/// emailId : "rambo.ukus@gmail.com"
/// flow : "password-reset"

class TivraHealthRegisterScreenOTPRequest {
  TivraHealthRegisterScreenOTPRequest({
      this.emailId, 
      this.flow,});

  TivraHealthRegisterScreenOTPRequest.fromJson(dynamic json) {
    emailId = json['emailId'];
    flow = json['flow'];
  }
  String? emailId;
  String? flow;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['emailId'] = emailId;
    map['flow'] = flow;
    return map;
  }

}