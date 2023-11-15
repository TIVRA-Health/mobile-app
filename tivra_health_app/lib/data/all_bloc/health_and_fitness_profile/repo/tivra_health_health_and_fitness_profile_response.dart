/// message : "User demographic updated successfully"
/// result : {"acknowledged":true,"modifiedCount":1,"upsertedId":null,"upsertedCount":0,"matchedCount":1}

class TivraHealthHealthAndFitnessResponse {
  TivraHealthHealthAndFitnessResponse({
      this.message, 
      this.result,});

  TivraHealthHealthAndFitnessResponse.fromJson(dynamic json) {
    message = json['message'];
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }
  String? message;
  Result? result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (result != null) {
      map['result'] = result?.toJson();
    }
    return map;
  }

}

/// acknowledged : true
/// modifiedCount : 1
/// upsertedId : null
/// upsertedCount : 0
/// matchedCount : 1

class Result {
  Result({
      this.acknowledged, 
      this.modifiedCount, 
      this.upsertedId, 
      this.upsertedCount, 
      this.matchedCount,});

  Result.fromJson(dynamic json) {
    acknowledged = json['acknowledged'];
    modifiedCount = json['modifiedCount'];
    upsertedId = json['upsertedId'];
    upsertedCount = json['upsertedCount'];
    matchedCount = json['matchedCount'];
  }
  bool? acknowledged;
  num? modifiedCount;
  dynamic upsertedId;
  num? upsertedCount;
  num? matchedCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['acknowledged'] = acknowledged;
    map['modifiedCount'] = modifiedCount;
    map['upsertedId'] = upsertedId;
    map['upsertedCount'] = upsertedCount;
    map['matchedCount'] = matchedCount;
    return map;
  }

}