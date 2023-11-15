/// userId : "6515f86d0b21a3b2f80bac4c"
/// roleId : 7
/// planId : 2
/// registrationId : 2

class TivraHealthUserRoleRequest {
  TivraHealthUserRoleRequest({
      this.userId, 
      this.roleId, 
      this.planId, 
      this.registrationId,});

  TivraHealthUserRoleRequest.fromJson(dynamic json) {
    userId = json['userId'];
    roleId = json['roleId'];
    planId = json['planId'];
    registrationId = json['registrationId'];
  }
  String? userId;
  num? roleId;
  num? planId;
  num? registrationId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = userId;
    map['roleId'] = roleId;
    map['planId'] = planId;
    map['registrationId'] = registrationId;
    return map;
  }

}