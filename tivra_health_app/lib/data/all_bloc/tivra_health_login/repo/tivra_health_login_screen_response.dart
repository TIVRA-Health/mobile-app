/// message : "Login successful"
/// userId : "65159bbb90da941b73bd5921"
/// token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NTE1OWJiYjkwZGE5NDFiNzNiZDU5MjEiLCJpYXQiOjE2OTYyNTY0NjAsImV4cCI6MTY5NjI2MDA2MH0.1R_IvuNRNzlHxTfyOpBDypLDLWGfPtTMfVRS8QcLwOA"

class TivraHealthLoginScreenResponse {
  TivraHealthLoginScreenResponse({
    this.message,
    this.userId,
    this.token,});

  TivraHealthLoginScreenResponse.fromJson(dynamic json) {
    message = json['message'];
    userId = json['userId'];
    token = json['token'];
  }
  String? message;
  String? userId;
  String? token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['userId'] = userId;
    map['token'] = token;
    return map;
  }

}