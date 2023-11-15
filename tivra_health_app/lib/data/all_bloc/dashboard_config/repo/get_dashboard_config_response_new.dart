/// data : [{"category":"health","label":"Heartrate","icon":"redheart","item":"Heartrate","user_device_id":"omron"},{"category":"health","label":"Pulse","icon":"Iconpulse","item":"Pulse","user_device_id":"omron"},{"category":"health","label":"Weight","icon":"Iconweight","item":"Weight","user_device_id":"omron"},{"category":"fitness","label":"BodyBattery","icon":"Iconbodybattery","item":"BodyBattery","user_device_id":"omron"},{"category":"fitness","label":"Stairs","icon":"stairs","item":"Stairs","user_device_id":"omron"},{"category":"nutrition","label":"Fiber","icon":"fiber","item":"Fiber","user_device_id":"omron"},{"category":"nutrition","label":"Cholesterol","icon":"cholesterol","item":"Cholesterol","user_device_id":"omron"},{"category":"health","label":"Respiration","icon":"Iconlungs","item":"Respiration","user_device_id":"omron"},{"category":"health","label":"BP","icon":"IconBP","item":"BP","user_device_id":"omron"},{"category":"health","label":"HRV","icon":"heartrate","item":"HRV","user_device_id":"omron"},{"category":"nutrition","label":"AddedSugars","icon":"addedsugar","item":"AddedSugars","user_device_id":"omron"},{"category":"nutrition","label":"Sugar","icon":"sugar","item":"Sugar","user_device_id":"omron"},{"category":"health","label":"VO2Max","icon":"IconVOx","item":"VO2Max","user_device_id":""},{"category":"fitness","label":"Stepscount","icon":"Iconredfoot","item":"Stepscount","user_device_id":""},{"category":"fitness","label":"Running","icon":"Iconrun","item":"Running","user_device_id":""},{"category":"health","label":"Stress","icon":"Iconstress","item":"Stress","user_device_id":""},{"category":"health","label":"RestingHeartRate","icon":"restingheartrate","item":"RestingHeartRate","user_device_id":""},{"category":"health","label":"BloodGlucoseLevel","icon":"bloodglucoselevel","item":"BloodGlucoseLevel","user_device_id":""},{"category":"health","label":"Temperature","icon":"temperature","item":"Temperature","user_device_id":""},{"category":"health","label":"Sleep","icon":"sleep","item":"Sleep","user_device_id":""},{"category":"health","label":"Menstrualcycle","icon":"menstrualcycle","item":"Menstrualcycle","user_device_id":""},{"category":"fitness","label":"Calories","icon":"Iconredfire","item":"Calories","user_device_id":""},{"category":"fitness","label":"TrainingLoad","icon":"Icontrainingload","item":"TrainingLoad","user_device_id":""},{"category":"fitness","label":"Activities","icon":"Iconactivity","item":"Activities","user_device_id":""},{"category":"fitness","label":"Distance","icon":"distance","item":"Distance","user_device_id":""},{"category":"nutrition","label":"Water","icon":"water","item":"Water","user_device_id":""},{"category":"nutrition","label":"Fat","icon":"fat","item":"Fat","user_device_id":""},{"category":"nutrition","label":"Protien","icon":"protein","item":"Protien","user_device_id":""},{"category":"nutrition","label":"CaloriesConsumed","icon":"calories","item":"CaloriesConsumed","user_device_id":""},{"category":"fitness","label":"GPS","icon":"gps","item":"GPS","user_device_id":""}]

class GetDashboardConfigResponseNew {
  GetDashboardConfigResponseNew({
      this.data,});

  GetDashboardConfigResponseNew.fromJson(dynamic json) {
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

/// category : "health"
/// label : "Heartrate"
/// icon : "redheart"
/// item : "Heartrate"
/// user_device_id : "omron"

class Data {
  Data({
      this.category, 
      this.label, 
      this.icon, 
      this.item, 
      this.userDeviceId,});

  Data.fromJson(dynamic json) {
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