/// acknowledged : true
/// insertedId : "6542451867129bcec6199ced"
/// isNewUser : true
/// token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NTQyNDUxODY3MTI5YmNlYzYxOTljZWQiLCJpYXQiOjE2OTg4NDE4ODAsImV4cCI6MTY5ODg0NTQ4MH0.b-3sirvLPD2H1gV_RN7o0qYwBHzWTGXbKCGlzAnRe20"
/// isRecordCreated : true
/// userId : "6542451867129bcec6199ced"
/// corporateAffiliation : false

class TivraHealthRegisterScreenResponse {
  TivraHealthRegisterScreenResponse({
      this.acknowledged, 
      this.insertedId, 
      this.isNewUser, 
      this.token, 
      this.isRecordCreated, 
      this.userId, 
      this.corporateAffiliation,});

  TivraHealthRegisterScreenResponse.fromJson(dynamic json) {
    acknowledged = json['acknowledged'];
    insertedId = json['insertedId'];
    isNewUser = json['isNewUser'];
    token = json['token'];
    isRecordCreated = json['isRecordCreated'];
    userId = json['userId'];
    corporateAffiliation = json['corporateAffiliation'];
  }
  bool? acknowledged;
  String? insertedId;
  bool? isNewUser;
  String? token;
  bool? isRecordCreated;
  String? userId;
  bool? corporateAffiliation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['acknowledged'] = acknowledged;
    map['insertedId'] = insertedId;
    map['isNewUser'] = isNewUser;
    map['token'] = token;
    map['isRecordCreated'] = isRecordCreated;
    map['userId'] = userId;
    map['corporateAffiliation'] = corporateAffiliation;
    return map;
  }

}