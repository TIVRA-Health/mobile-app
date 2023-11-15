/// acknowledged : true
/// insertedId : "653f7ebd4001a797d010d7bc"

class UploadFoodResponse {
  UploadFoodResponse({
      this.acknowledged, 
      this.insertedId,});

  UploadFoodResponse.fromJson(dynamic json) {
    acknowledged = json['acknowledged'];
    insertedId = json['insertedId'];
  }
  bool? acknowledged;
  String? insertedId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['acknowledged'] = acknowledged;
    map['insertedId'] = insertedId;
    return map;
  }

}