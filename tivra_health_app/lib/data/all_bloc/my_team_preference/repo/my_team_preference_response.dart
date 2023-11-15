/// userId : "65159bbb90da941b73bd5921"
/// preference : [{"item":"HRV","icon":"heartrate","label":"HRV","active":true,"isPreferred":false},{"item":"Heartrate","icon":"redheart","label":"Heartrate","active":true,"isPreferred":true},{"item":"Sleep","icon":"","label":"Sleep","active":true,"isPreferred":true},{"item":"Weight","icon":"Iconweight","label":"Weight","active":true,"isPreferred":true},{"item":"BP","icon":"IconBP","label":"BP","active":true,"isPreferred":false},{"item":"Temperature","icon":"","label":"Temperature","active":true,"isPreferred":false},{"item":"Menstrualcycle","icon":"IconMental","label":"Menstrualcycle","active":true,"isPreferred":false},{"item":"VO2Max","icon":"IconVOx","label":"VO2Max","active":true,"isPreferred":false},{"item":"BloodGlucoseLevel","icon":"","label":"BloodGlucoseLevel","active":true,"isPreferred":false},{"item":"BodyBattery","icon":"Iconbodybattery","label":"BodyBattery","active":true,"isPreferred":false},{"item":"RestingHeartRate","icon":"","label":"RestingHeartRate","active":true,"isPreferred":false},{"item":"Stepscount","icon":"Iconredfoot","label":"Stepscount","active":true,"isPreferred":false},{"item":"Running","icon":"Iconrun","label":"Running","active":true,"isPreferred":false},{"item":"Respiration","icon":"Iconlungs","label":"Respiration","active":true,"isPreferred":false},{"item":"Stairs","icon":"","label":"Stairs","active":true,"isPreferred":false},{"item":"Pulse","icon":"Iconpulse","label":"Pulse","active":true,"isPreferred":false},{"item":"Stress","icon":"Iconstress","label":"Stress","active":true,"isPreferred":false},{"item":"Calories","icon":"Iconredfire","label":"Calories","active":true,"isPreferred":false},{"item":"TrainingLoad","icon":"Icontrainingload","label":"TrainingLoad","active":true,"isPreferred":false},{"item":"Activities","icon":"Iconactivity","label":"Activities","active":true,"isPreferred":false},{"item":"GPS","icon":"","label":"GPS","active":true,"isPreferred":false},{"item":"Distance","icon":"","label":"Distance","active":true,"isPreferred":false},{"item":"Sugar","icon":"Iconredfoot","label":"Sugar","active":true,"isPreferred":false},{"item":"Carbs","icon":"Iconrun","label":"Carbs","active":true,"isPreferred":false}]

class MyTeamPreferenceResponse {
  MyTeamPreferenceResponse({
      this.userId, 
      this.preference,});

  MyTeamPreferenceResponse.fromJson(dynamic json) {
    userId = json['userId'];
    if (json['preference'] != null) {
      preference = [];
      json['preference'].forEach((v) {
        preference?.add(TeamPreference.fromJson(v));
      });
    }
  }
  String? userId;
  List<TeamPreference>? preference;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = userId;
    if (preference != null) {
      map['preference'] = preference?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// item : "HRV"
/// icon : "heartrate"
/// label : "HRV"
/// active : true
/// isPreferred : false

class TeamPreference {
  TeamPreference({
      this.item, 
      this.icon, 
      this.label, 
      this.active, 
      this.isPreferred,});

  TeamPreference.fromJson(dynamic json) {
    item = json['item'];
    icon = json['icon'];
    label = json['label'];
    active = json['active'];
    isPreferred = json['isPreferred'];
  }
  String? item;
  String? icon;
  String? label;
  bool? active;
  bool? isPreferred;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['item'] = item;
    map['icon'] = icon;
    map['label'] = label;
    map['active'] = active;
    map['isPreferred'] = isPreferred;
    return map;
  }

}