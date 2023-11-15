/// auth_url : "https://connect.garmin.com/oauthConfirm?oauth_callback=https%3A%2F%2Fapi.tryterra.co%2Fv2%2Fauth%2Fgarmin%2Foauth1&oauth_token=707630d5-a144-45a0-949f-e42081343300"
/// status : "success"
/// user_id : "6cc050d0-9bdb-4703-9075-7a3c1ba2311e"

class DeviceRegistrationResponse {
  DeviceRegistrationResponse({
      this.authUrl, 
      this.status, 
      this.userId,});

  DeviceRegistrationResponse.fromJson(dynamic json) {
    authUrl = json['auth_url'];
    status = json['status'];
    userId = json['user_id'];
  }
  String? authUrl;
  String? status;
  String? userId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['auth_url'] = authUrl;
    map['status'] = status;
    map['user_id'] = userId;
    return map;
  }

}