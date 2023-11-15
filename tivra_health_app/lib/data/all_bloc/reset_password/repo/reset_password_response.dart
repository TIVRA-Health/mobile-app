/// status : "success"
/// message : "Password updated successfully"

class ResetPasswordResponse {
  ResetPasswordResponse({
      this.status, 
      this.message,});

  ResetPasswordResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
  }
  String? status;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    return map;
  }

}