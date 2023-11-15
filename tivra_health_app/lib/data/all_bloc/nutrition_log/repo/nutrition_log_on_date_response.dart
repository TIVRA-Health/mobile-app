/// data : [{"userId":"","itemName":"","calories":"","cholesterol":"","fat":"","protien":"","fiber":"","sugar":"","itemQty":"","item":"breakfast"},{"userId":"","itemName":"","calories":"","cholesterol":"","fat":"","protien":"","fiber":"","sugar":"","itemQty":"","item":"lunch"},{"userId":"","itemName":"","calories":"","cholesterol":"","fat":"","protien":"","fiber":"","sugar":"","itemQty":"","item":"dinner"}]

class NutritionLogOnDateResponse {
  NutritionLogOnDateResponse({
      this.data,});

  NutritionLogOnDateResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }
  List<Data>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// userId : ""
/// itemName : ""
/// calories : ""
/// cholesterol : ""
/// fat : ""
/// protien : ""
/// fiber : ""
/// sugar : ""
/// itemQty : ""
/// item : "breakfast"

class Data {
  Data({
      this.userId,
      this.itemName,
      this.calories,
      this.cholesterol,
      this.fat,
      this.protein,
      this.protien,
      this.fiber,
      this.sugar,
      this.itemQty,
      this.item,});

  Data.fromJson(dynamic json) {
    userId = json['userId'];
    itemName = json['itemName'];
    calories = json['calories'];
    cholesterol = json['cholesterol'];
    fat = json['fat'];
    protein = json['protein'];
    protien = json['protien'];
    fiber = json['fiber'];
    sugar = json['sugar'];
    itemQty = json['itemQty'];
    item = json['item'];
  }
  String? userId;
  String? itemName;
  String? calories;
  String? cholesterol;
  String? fat;
  String? protein;
  String? protien;
  String? fiber;
  String? sugar;
  String? itemQty;
  String? item;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = userId;
    map['itemName'] = itemName;
    map['calories'] = calories;
    map['cholesterol'] = cholesterol;
    map['fat'] = fat;
    map['protein'] = protein;
    map['protien'] = protien;
    map['fiber'] = fiber;
    map['sugar'] = sugar;
    map['itemQty'] = itemQty;
    map['item'] = item;
    return map;
  }

}