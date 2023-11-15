/// userId : "65159bbb90da941b73bd5921"
/// configData : [{"category":"health","label":"HRV","icon":"heartrate","item":"HRV","user_device_id":"omron"}]

class SaveDashboardConfigRequest {
  SaveDashboardConfigRequest({
      this.userId, 
      this.configData,});

  SaveDashboardConfigRequest.fromJson(dynamic json) {
    userId = json['userId'];
    if (json['configData'] != null) {
      configData = [];
      json['configData'].forEach((v) {
        configData?.add(ConfigData.fromJson(v));
      });
    }
  }
  String? userId;
  List<ConfigData>? configData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = userId;
    if (configData != null) {
      map['configData'] = configData?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// category : "health"
/// label : "HRV"
/// icon : "heartrate"
/// item : "HRV"
/// user_device_id : "omron"

class ConfigData {
  ConfigData({
      this.category, 
      this.label, 
      this.icon, 
      this.item, 
      this.userDeviceId,});

  ConfigData.fromJson(dynamic json) {
    category = json['category'];
    label = json['label'];
    icon = json['icon'];
    item = json['item'];
    userDeviceId = json['user_device_id'];
  }
  String? category;
  String? label;
  String? icon;
  String? item;
  String? userDeviceId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['category'] = category;
    map['label'] = label;
    map['icon'] = icon;
    map['item'] = item;
    map['user_device_id'] = userDeviceId;
    return map;
  }

}