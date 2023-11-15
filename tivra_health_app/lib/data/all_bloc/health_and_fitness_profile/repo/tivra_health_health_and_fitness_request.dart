/// formData : {"weight":"Vocational qualification","height":"Vocational qualification","smoking":true,"chronicCondition":"condition","userId":"6515f86d0b21a3b2f80bac4c"}

class TivraHealthHealthAndFitnessRequest {
  TivraHealthHealthAndFitnessRequest({
      this.formData,});

  TivraHealthHealthAndFitnessRequest.fromJson(dynamic json) {
    formData = json['formData'] != null ? FormData.fromJson(json['formData']) : null;
  }
  FormData? formData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (formData != null) {
      map['formData'] = formData?.toJson();
    }
    return map;
  }

}

/// weight : "Vocational qualification"
/// height : "Vocational qualification"
/// smoking : true
/// chronicCondition : "condition"
/// userId : "6515f86d0b21a3b2f80bac4c"

class FormData {
  FormData({
      this.weight, 
      this.height, 
      this.smoking, 
      this.chronicCondition, 
      this.userId,});

  FormData.fromJson(dynamic json) {
    weight = json['weight'];
    height = json['height'];
    smoking = json['smoking'];
    chronicCondition = json['chronicCondition'];
    userId = json['userId'];
  }
  String? weight;
  String? height;
  String? smoking;
  String? chronicCondition;
  String? userId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['weight'] = weight;
    map['height'] = height;
    map['smoking'] = smoking;
    map['chronicCondition'] = chronicCondition;
    map['userId'] = userId;
    return map;
  }

}