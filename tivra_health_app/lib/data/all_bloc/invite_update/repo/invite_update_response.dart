/// valid : true
/// message : "Invitation updated successfully"
/// result : {"acknowledged":"","modifiedCount":1,"upsertedId":"","upsertedCount":0,"matchedCount":1}

class InviteUpdateResponse {
  InviteUpdateResponse({
    this.valid,
    this.message,
    this.result,});

  InviteUpdateResponse.fromJson(dynamic json) {
    valid = json['valid'];
    message = json['message'];
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }
  bool? valid;
  String? message;
  Result? result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['valid'] = valid;
    map['message'] = message;
    if (result != null) {
      map['result'] = result?.toJson();
    }
    return map;
  }

}

/// acknowledged : ""
/// modifiedCount : 1
/// upsertedId : ""
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
    acknowledged = json['acknowledged'].toString();
    modifiedCount = json['modifiedCount'].toString();
    upsertedId = json['upsertedId'].toString();
    upsertedCount = json['upsertedCount'].toString();
    matchedCount = json['matchedCount'].toString();
  }
  String? acknowledged;
  String? modifiedCount;
  String? upsertedId;
  String? upsertedCount;
  String? matchedCount;

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