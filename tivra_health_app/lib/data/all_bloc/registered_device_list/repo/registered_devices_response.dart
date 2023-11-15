/// data : [{"name":"Omron","active":true,"deviceMake":"omron"},{"name":"Google Fit","active":false,"deviceMake":"google"}]

class RegisteredDevicesResponse {
  RegisteredDevicesResponse({
      this.data,});

  RegisteredDevicesResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }
  List<Data>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// name : "Omron"
/// active : true
/// deviceMake : "omron"

class Data {
  Data({
      this.name, 
      this.active, 
      this.deviceMake,});

  Data.fromJson(dynamic json) {
    name = json['name'];
    active = json['active'];
    deviceMake = json['deviceMake'];
  }
  String? name;
  bool? active;
  String? deviceMake;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['active'] = active;
    map['deviceMake'] = deviceMake;
    return map;
  }

}