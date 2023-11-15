/// query : "2 Chicken & Broccoli Alfredo, Grilled"

class NutritionFoodDetailsRequest {
  NutritionFoodDetailsRequest({
      this.query,});

  NutritionFoodDetailsRequest.fromJson(dynamic json) {
    query = json['query'];
  }
  String? query;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['query'] = query;
    return map;
  }

}