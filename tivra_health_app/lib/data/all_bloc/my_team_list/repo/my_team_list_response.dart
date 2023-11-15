/// data : [{"id":"65141e6d198605c7a4799d1a","player":{"name":"Rahul Singh","icon":"userImage","active":"isEven"},"heartRate":{"icon":"redheart","value":46,"unit":"bpm"},"heartRateVariability":{"value":50,"icon":"heartrate"},"running":{"value":46,"unit":"Kms","icon":"Iconrun"}},{"id":"6515f3360b21a3b2f80bac4b","player":{"name":"Disha Pandey","icon":"userImage","active":"isEven"},"heartRate":{"icon":"redheart","value":46,"unit":"bpm"},"heartRateVariability":{"value":50,"icon":"heartrate"},"running":{"value":46,"unit":"Kms","icon":"Iconrun"}},{"id":"65149503b82f79995451c3a1","player":{"name":"Raj Kapoor","icon":"userImage","active":"isEven"},"heartRate":{"icon":"redheart","value":46,"unit":"bpm"},"heartRateVariability":{"value":50,"icon":"heartrate"},"running":{"value":46,"unit":"Kms","icon":"Iconrun"}}]

class MyTeamListResponse {
  MyTeamListResponse({
    this.data,});

  MyTeamListResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(MyTeamListData.fromJson(v));
      });
    }
  }
  List<MyTeamListData>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "65141e6d198605c7a4799d1a"
/// player : {"name":"Rahul Singh","icon":"userImage","active":"isEven"}
/// heartRate : {"icon":"redheart","value":46,"unit":"bpm"}
/// heartRateVariability : {"value":50,"icon":"heartrate"}
/// running : {"value":46,"unit":"Kms","icon":"Iconrun"}

class MyTeamListData {
  MyTeamListData({
    this.id,
    this.mateId,
    this.player,
    this.heartRate,
    this.heartRateVariability,
    this.running,});

  MyTeamListData.fromJson(dynamic json) {
    id = json['id'];
    mateId = json['mateId'];
    player = json['player'] != null ? Player.fromJson(json['player']) : null;
    heartRate = json['heartRate'] != null ? HeartRate.fromJson(json['heartRate']) : null;
    heartRateVariability = json['heartRateVariability'] != null ? HeartRateVariability.fromJson(json['heartRateVariability']) : null;
    running = json['running'] != null ? Running.fromJson(json['running']) : null;
  }
  String? id;
  String? mateId;
  Player? player;
  HeartRate? heartRate;
  HeartRateVariability? heartRateVariability;
  Running? running;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['mateId'] = mateId;
    if (player != null) {
      map['player'] = player?.toJson();
    }
    if (heartRate != null) {
      map['heartRate'] = heartRate?.toJson();
    }
    if (heartRateVariability != null) {
      map['heartRateVariability'] = heartRateVariability?.toJson();
    }
    if (running != null) {
      map['running'] = running?.toJson();
    }
    return map;
  }

}

/// value : 46
/// unit : "Kms"
/// icon : "Iconrun"

class Running {
  Running({
    this.value,
    this.unit,
    this.icon,});

  Running.fromJson(dynamic json) {
    value = json['value'];
    unit = json['unit'];
    icon = json['icon'];
  }
  int? value;
  String? unit;
  String? icon;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['value'] = value;
    map['unit'] = unit;
    map['icon'] = icon;
    return map;
  }

}

/// value : 50
/// icon : "heartrate"

class HeartRateVariability {
  HeartRateVariability({
    this.value,
    this.icon,});

  HeartRateVariability.fromJson(dynamic json) {
    value = json['value'];
    icon = json['icon'];
  }
  int? value;
  String? icon;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['value'] = value;
    map['icon'] = icon;
    return map;
  }

}

/// icon : "redheart"
/// value : 46
/// unit : "bpm"

class HeartRate {
  HeartRate({
    this.icon,
    this.value,
    this.unit,});

  HeartRate.fromJson(dynamic json) {
    icon = json['icon'];
    value = json['value'];
    unit = json['unit'];
  }
  String? icon;
  int? value;
  String? unit;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['icon'] = icon;
    map['value'] = value;
    map['unit'] = unit;
    return map;
  }

}

/// name : "Rahul Singh"
/// icon : "userImage"
/// active : "isEven"

class Player {
  Player({
    this.name,
    this.icon,
    this.active,});

  Player.fromJson(dynamic json) {
    name = json['name'];
    icon = json['icon'];
    active = json['active'];
  }
  String? name;
  String? icon;
  String? active;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['icon'] = icon;
    map['active'] = active;
    return map;
  }

}