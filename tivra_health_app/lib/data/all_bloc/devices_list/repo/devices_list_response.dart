/// data : [{"_id":"6510c25a0a8340c61ce9dc83","id":3,"name":"BioStrap","active":"1"},{"_id":"6510c25a0a8340c61ce9dc84","id":4,"name":"Polar","active":"1"},{"_id":"6510c25a0a8340c61ce9dc85","id":5,"name":"Withings","active":"1"},{"_id":"6510c25a0a8340c61ce9dc86","id":6,"name":"Omron","active":"1"},{"_id":"6510c25a0a8340c61ce9dc87","id":7,"name":"FitBit","active":"1"},{"_id":"6510c25a0a8340c61ce9dc88","id":8,"name":"iFit","active":"1"},{"_id":"6510c25a0a8340c61ce9dc89","id":9,"name":"Garmin","active":"1"},{"_id":"6510c25a0a8340c61ce9dc8a","id":10,"name":"Google Fit","active":"1"},{"_id":"6510c25a0a8340c61ce9dc8b","id":11,"name":"Oura","active":"1"},{"_id":"6510c25a0a8340c61ce9dc8c","id":12,"name":"Wahoo","active":"1"},{"_id":"6510c25a0a8340c61ce9dc8d","id":13,"name":"Peloton","active":"1"},{"_id":"6510c25a0a8340c61ce9dc8e","id":14,"name":"Zwift","active":"1"},{"_id":"6510c25a0a8340c61ce9dc8f","id":15,"name":"TrainingPeaks","active":"1"},{"_id":"6510c25a0a8340c61ce9dc90","id":16,"name":"Polar","active":"1"},{"_id":"6510c25a0a8340c61ce9dc91","id":17,"name":"Suunto","active":"1"},{"_id":"6510c25a0a8340c61ce9dc92","id":18,"name":"Freestyle Libre","active":"1"},{"_id":"6510c25a0a8340c61ce9dc93","id":19,"name":"Apple Health","active":"1"},{"_id":"6510c25a0a8340c61ce9dc94","id":20,"name":"Eight Sleep","active":"1"},{"_id":"6510c25a0a8340c61ce9dc95","id":21,"name":"Samsung Health","active":"1"},{"_id":"6510c25a0a8340c61ce9dc96","id":22,"name":"Concept2","active":"1"},{"_id":"6510c25a0a8340c61ce9dc97","id":23,"name":"Cronmeter","active":"1"},{"_id":"6510c25a0a8340c61ce9dc98","id":24,"name":"Nutracheck","active":"1"},{"_id":"6510c25a0a8340c61ce9dc99","id":25,"name":"Underarmour","active":"1"},{"_id":"6510c25a0a8340c61ce9dc9a","id":26,"name":"Dexcom","active":"1"},{"_id":"6510c25a0a8340c61ce9dc9b","id":27,"name":"Coros","active":"1"},{"_id":"6510c25a0a8340c61ce9dc9c","id":28,"name":"Huawei","active":"1"},{"_id":"6510c25a0a8340c61ce9dc81","id":1,"name":"TechnoGym","active":"1"},{"_id":"6510c25a0a8340c61ce9dc82","id":2,"name":"FatSecret","active":"1"}]

class DevicesListResponse {
  DevicesListResponse({
    this.data,});

  DevicesListResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(DevicesListData.fromJson(v));
      });
    }
  }
  List<DevicesListData>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// _id : "6510c25a0a8340c61ce9dc83"
/// id : 3
/// name : "BioStrap"
/// active : "1"
/// deviceMake : "BioStrap"

class DevicesListData {
  DevicesListData({
    this.meanId,
    this.id,
    this.name,
    this.active,
  this.deviceMake});

  DevicesListData.fromJson(dynamic json) {
    meanId = json['_id'];
    id = json['id'];
    name = json['name'];
    active = json['active'];
    deviceMake = json['deviceMake'];
  }
  String? meanId;
  int? id;
  String? name;
  bool? active;
  String? deviceMake;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = meanId;
    map['id'] = id;
    map['name'] = name;
    map['active'] = active;
    map['deviceMake'] = deviceMake;
    return map;
  }

}