/// message : "User configuration saved successfully"

class SaveTeamPreferenceResponse {
  SaveTeamPreferenceResponse({
      this.message,});

  SaveTeamPreferenceResponse.fromJson(dynamic json) {
    message = json['message'];
  }
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    return map;
  }

}