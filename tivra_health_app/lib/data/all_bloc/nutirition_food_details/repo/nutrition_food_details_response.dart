/// name : {"foodName":"chicken and broccoli alfredo","foodNutrients":[{"nutrientName":"Protein","value":81.65,"unitName":""},{"nutrientName":"Cholesterol","value":527.64,"unitName":""},{"nutrientName":"Sodium","value":1885.04,"unitName":""},{"nutrientName":"Fiber","value":10.3,"unitName":""},{"nutrientName":"Sugars","value":11.25,"unitName":""},{"nutrientName":"Fat","value":160.04,"unitName":""},{"nutrientName":"Energy","value":2350.89,"unitName":""},{"nutrientName":"Potassium","value":1130.29,"unitName":""}],"description":"chicken and broccoli alfredo","brandName":null}
/// quantity : 2

class NutritionFoodDetailsResponse {
  NutritionFoodDetailsResponse({
      this.name, 
      this.quantity,});

  NutritionFoodDetailsResponse.fromJson(dynamic json) {
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
    quantity = json['quantity'];
  }
  Name? name;
  num? quantity;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (name != null) {
      map['name'] = name?.toJson();
    }
    map['quantity'] = quantity;
    return map;
  }

}

/// foodName : "chicken and broccoli alfredo"
/// foodNutrients : [{"nutrientName":"Protein","value":81.65,"unitName":""},{"nutrientName":"Cholesterol","value":527.64,"unitName":""},{"nutrientName":"Sodium","value":1885.04,"unitName":""},{"nutrientName":"Fiber","value":10.3,"unitName":""},{"nutrientName":"Sugars","value":11.25,"unitName":""},{"nutrientName":"Fat","value":160.04,"unitName":""},{"nutrientName":"Energy","value":2350.89,"unitName":""},{"nutrientName":"Potassium","value":1130.29,"unitName":""}]
/// description : "chicken and broccoli alfredo"
/// brandName : null

class Name {
  Name({
      this.foodName, 
      this.foodNutrients, 
      this.description, 
      this.brandName,});

  Name.fromJson(dynamic json) {
    foodName = json['foodName'];
    if (json['foodNutrients'] != null) {
      foodNutrients = [];
      json['foodNutrients'].forEach((v) {
        foodNutrients?.add(FoodNutrients.fromJson(v));
      });
    }
    description = json['description'];
    brandName = json['brandName'];
  }
  String? foodName;
  List<FoodNutrients>? foodNutrients;
  String? description;
  dynamic brandName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['foodName'] = foodName;
    if (foodNutrients != null) {
      map['foodNutrients'] = foodNutrients?.map((v) => v.toJson()).toList();
    }
    map['description'] = description;
    map['brandName'] = brandName;
    return map;
  }

}

/// nutrientName : "Protein"
/// value : 81.65
/// unitName : ""

class FoodNutrients {
  FoodNutrients({
      this.nutrientName, 
      this.value, 
      this.unitName,});

  FoodNutrients.fromJson(dynamic json) {
    nutrientName = json['nutrientName'];
    value = json['value'];
    unitName = json['unitName'];
  }
  String? nutrientName;
  num? value;
  String? unitName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['nutrientName'] = nutrientName;
    map['value'] = value;
    map['unitName'] = unitName;
    return map;
  }

}