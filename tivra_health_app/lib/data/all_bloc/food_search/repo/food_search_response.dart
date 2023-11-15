/// data : {"foods":[{"fdcId":1,"description":"corn","brandName":""},{"fdcId":2,"description":"cornmeal","brandName":""},{"fdcId":3,"description":"can corn","brandName":""},{"fdcId":4,"description":"corn nuts","brandName":""},{"fdcId":5,"description":"cornbread","brandName":""},{"fdcId":6,"description":"baby corn","brandName":""},{"fdcId":7,"description":"cornflakes","brandName":""},{"fdcId":8,"description":"sweet corn","brandName":""},{"fdcId":9,"description":"cornstarch","brandName":""},{"fdcId":10,"description":"corn cakes","brandName":""},{"fdcId":11,"description":"corn salsa","brandName":""},{"fdcId":12,"description":"corn chips","brandName":""},{"fdcId":13,"description":"corn cereal","brandName":""},{"fdcId":14,"description":"corn flakes","brandName":""},{"fdcId":15,"description":"frozen corn","brandName":""},{"fdcId":16,"description":"canned corn","brandName":""},{"fdcId":17,"description":"corned beef","brandName":""},{"fdcId":18,"description":"creamed corn","brandName":""},{"fdcId":19,"description":"corn tortilla","brandName":""},{"fdcId":20,"description":"corn tortillas","brandName":""},{"fdcId":21,"description":"Corn Chips, The Original","brandName":"Fritos"},{"fdcId":22,"description":"Popped Corn, Buttery Caramel Corn & Rich Cheddar Cheese Corn","brandName":"G.H. Cretors"},{"fdcId":23,"description":"Popped Corn Chips, White Cheddar","brandName":"Popcorners"},{"fdcId":24,"description":"Rice Snacks, Caramel Corn","brandName":"Quaker"},{"fdcId":25,"description":"Pop Corners, Carnival Kettle","brandName":"Our Little Rebellion"},{"fdcId":26,"description":"White Cheddar","brandName":"Pop Corners"},{"fdcId":27,"description":"Popped-Corn Snack, Kettle Corn, Sweet & Salty","brandName":"Popcorners"},{"fdcId":28,"description":"Corn Chips, Chili Cheese","brandName":"Fritos"},{"fdcId":29,"description":"Kernel Corn, Whole","brandName":"Del Monte"},{"fdcId":30,"description":"Tortilla Chips, White Corn","brandName":"Santitas"},{"fdcId":31,"description":"Tortillas, Corn","brandName":"Guerrero"},{"fdcId":32,"description":"Sweet & Salty Kettle Corn Popped Corn Snack","brandName":"Pop Corners"},{"fdcId":33,"description":"Corn Chips","brandName":"Fritos"},{"fdcId":34,"description":"Popped Corn Chips, Salt of the Earth","brandName":"Popcorners"},{"fdcId":35,"description":"Corn Tostadas","brandName":"Guerrero"},{"fdcId":36,"description":"Corn Muffin Mix","brandName":"Jiffy"},{"fdcId":37,"description":"Baked Rice and Corn Puffs, Aged White Cheddar","brandName":"Pirate's Booty"},{"fdcId":38,"description":"Cereal, Corn","brandName":"Corn Pops"},{"fdcId":39,"description":"Popped-Corn Snack, Spicy Queso Flavored","brandName":"Popcorners"},{"fdcId":40,"description":"Corn Snack, Spicy Queso","brandName":"Popcorners"}]}

class FoodSearchResponse {
  FoodSearchResponse({
      this.data,});

  FoodSearchResponse.fromJson(dynamic json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

/// foods : [{"fdcId":1,"description":"corn","brandName":""},{"fdcId":2,"description":"cornmeal","brandName":""},{"fdcId":3,"description":"can corn","brandName":""},{"fdcId":4,"description":"corn nuts","brandName":""},{"fdcId":5,"description":"cornbread","brandName":""},{"fdcId":6,"description":"baby corn","brandName":""},{"fdcId":7,"description":"cornflakes","brandName":""},{"fdcId":8,"description":"sweet corn","brandName":""},{"fdcId":9,"description":"cornstarch","brandName":""},{"fdcId":10,"description":"corn cakes","brandName":""},{"fdcId":11,"description":"corn salsa","brandName":""},{"fdcId":12,"description":"corn chips","brandName":""},{"fdcId":13,"description":"corn cereal","brandName":""},{"fdcId":14,"description":"corn flakes","brandName":""},{"fdcId":15,"description":"frozen corn","brandName":""},{"fdcId":16,"description":"canned corn","brandName":""},{"fdcId":17,"description":"corned beef","brandName":""},{"fdcId":18,"description":"creamed corn","brandName":""},{"fdcId":19,"description":"corn tortilla","brandName":""},{"fdcId":20,"description":"corn tortillas","brandName":""},{"fdcId":21,"description":"Corn Chips, The Original","brandName":"Fritos"},{"fdcId":22,"description":"Popped Corn, Buttery Caramel Corn & Rich Cheddar Cheese Corn","brandName":"G.H. Cretors"},{"fdcId":23,"description":"Popped Corn Chips, White Cheddar","brandName":"Popcorners"},{"fdcId":24,"description":"Rice Snacks, Caramel Corn","brandName":"Quaker"},{"fdcId":25,"description":"Pop Corners, Carnival Kettle","brandName":"Our Little Rebellion"},{"fdcId":26,"description":"White Cheddar","brandName":"Pop Corners"},{"fdcId":27,"description":"Popped-Corn Snack, Kettle Corn, Sweet & Salty","brandName":"Popcorners"},{"fdcId":28,"description":"Corn Chips, Chili Cheese","brandName":"Fritos"},{"fdcId":29,"description":"Kernel Corn, Whole","brandName":"Del Monte"},{"fdcId":30,"description":"Tortilla Chips, White Corn","brandName":"Santitas"},{"fdcId":31,"description":"Tortillas, Corn","brandName":"Guerrero"},{"fdcId":32,"description":"Sweet & Salty Kettle Corn Popped Corn Snack","brandName":"Pop Corners"},{"fdcId":33,"description":"Corn Chips","brandName":"Fritos"},{"fdcId":34,"description":"Popped Corn Chips, Salt of the Earth","brandName":"Popcorners"},{"fdcId":35,"description":"Corn Tostadas","brandName":"Guerrero"},{"fdcId":36,"description":"Corn Muffin Mix","brandName":"Jiffy"},{"fdcId":37,"description":"Baked Rice and Corn Puffs, Aged White Cheddar","brandName":"Pirate's Booty"},{"fdcId":38,"description":"Cereal, Corn","brandName":"Corn Pops"},{"fdcId":39,"description":"Popped-Corn Snack, Spicy Queso Flavored","brandName":"Popcorners"},{"fdcId":40,"description":"Corn Snack, Spicy Queso","brandName":"Popcorners"}]

class Data {
  Data({
      this.foods,});

  Data.fromJson(dynamic json) {
    if (json['foods'] != null) {
      foods = [];
      json['foods'].forEach((v) {
        foods?.add(Foods.fromJson(v));
      });
    }
  }
  List<Foods>? foods;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (foods != null) {
      map['foods'] = foods?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// fdcId : 1
/// description : "corn"
/// brandName : ""

class Foods {
  Foods({
      this.fdcId, 
      this.description, 
      this.brandName,});

  Foods.fromJson(dynamic json) {
    fdcId = json['fdcId'];
    description = json['description'];
    brandName = json['brandName'];
  }
  num? fdcId;
  String? description;
  String? brandName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['fdcId'] = fdcId;
    map['description'] = description;
    map['brandName'] = brandName;
    return map;
  }

}