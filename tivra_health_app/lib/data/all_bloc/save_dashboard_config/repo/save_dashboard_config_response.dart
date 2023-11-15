/// message : "User configuration saved successfully"

class SaveDashboardConfigResponse {
  SaveDashboardConfigResponse({
      this.message,});

  SaveDashboardConfigResponse.fromJson(dynamic json) {
    message = json['message'];
  }
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    return map;
  }

}