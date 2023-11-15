/// message : "User configuration saved successfully"

class SaveDashboardPreferenceResponse {
  SaveDashboardPreferenceResponse({
      this.message,});

  SaveDashboardPreferenceResponse.fromJson(dynamic json) {
    message = json['message'];
  }
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    return map;
  }

}