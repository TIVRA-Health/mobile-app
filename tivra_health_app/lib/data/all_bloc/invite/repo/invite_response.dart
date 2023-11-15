/// acknowledged : true
/// message : "Invitation updated successfully"
/// "insertedId": "65351924c34e30bc97de586c"

class InviteResponse {
  InviteResponse({
    this.acknowledged,
    this.message,
    this.insertedId,
  });

  InviteResponse.fromJson(dynamic json) {
    acknowledged = json['acknowledged'].toString();
    message = json['message'].toString();
    insertedId = json['insertedId'].toString();
  }
  String? acknowledged;
  String? message;
  String? insertedId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['acknowledged'] = acknowledged;
    map['message'] = message;
    map['insertedId'] = insertedId;
    return map;
  }
}