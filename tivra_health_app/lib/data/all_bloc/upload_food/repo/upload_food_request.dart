/// userId : "65141e6d198605c7a4799d1a"
/// itemName : "corn sandwich"
/// calories : "123"
/// cholesterol : "245"
/// fat : "234"
/// protien : "244"
/// fiber : "24"
/// sugar : "123"
/// itemQty : "1"
/// item : "breakfast"

class UploadFoodRequest {
  UploadFoodRequest({
      this.userId, 
      this.itemName, 
      this.calories, 
      this.cholesterol, 
      this.fat,
    this.creationTs,
      this.protien, 
      this.fiber, 
      this.sugar,
      this.itemQty, 
      this.item,});

  UploadFoodRequest.fromJson(dynamic json) {
    userId = json['userId'];
    itemName = json['itemName'];
    calories = json['calories'];
    cholesterol = json['cholesterol'];
    fat = json['fat'];
    protien = json['protien'];
    fiber = json['fiber'];
    sugar = json['sugar'];
    itemQty = json['itemQty'];
    creationTs = json['creationTs'];
    item = json['item'];
  }
  String? userId;
  String? itemName;
  String? calories;
  String? cholesterol;
  String? fat;
  String? protien;
  String? fiber;
  String? sugar;
  String? itemQty;
  String? item;
  String? creationTs;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = userId;
    map['itemName'] = itemName;
    map['calories'] = calories;
    map['cholesterol'] = cholesterol;
    map['fat'] = fat;
    map['protien'] = protien;
    map['fiber'] = fiber;
    map['sugar'] = sugar;
    map['itemQty'] = itemQty;
    map['item'] = item;
    map['creationTs'] = creationTs;
    return map;
  }

}