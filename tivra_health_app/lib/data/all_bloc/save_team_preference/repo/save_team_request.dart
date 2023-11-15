/// userId : "65159bbb90da941b73bd5921"
/// preference : [{"active":true,"icon":"Iconbodybattery","isPreferred":false,"item":"BodyBattery","label":"BodyBattery"},{"active":true,"icon":"Iconbodybattery","isPreferred":false,"item":"BodyBattery","label":"BodyBattery"}]

class SaveTeamPreferenceRequest {
  SaveTeamPreferenceRequest({
      this.userId, 
      this.preference,});

  SaveTeamPreferenceRequest.fromJson(dynamic json) {
    userId = json['userId'];
    if (json['preference'] != null) {
      preference = [];
      json['preference'].forEach((v) {
        preference?.add(Preference.fromJson(v));
      });
    }
  }
  String? userId;
  List<Preference>? preference;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = userId;
    if (preference != null) {
      map['preference'] = preference?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// active : true
/// icon : "Iconbodybattery"
/// isPreferred : false
/// item : "BodyBattery"
/// label : "BodyBattery"

class Preference {
  Preference({
      this.active, 
      this.icon, 
      this.isPreferred, 
      this.item, 
      this.label,});

  Preference.fromJson(dynamic json) {
    active = json['active'];
    icon = json['icon'];
    isPreferred = json['isPreferred'];
    item = json['item'];
    label = json['label'];
  }
  bool? active;
  String? icon;
  bool? isPreferred;
  String? item;
  String? label;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['active'] = active;
    map['icon'] = icon;
    map['isPreferred'] = isPreferred;
    map['item'] = item;
    map['label'] = label;
    return map;
  }

}