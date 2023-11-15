/// userId : "65159bbb90da941b73bd5921"
/// priceId : "price_1NzSTjKKoWpF5LTXnvLScJzR"

class TivraHealthPaymentLinkRequest {
  TivraHealthPaymentLinkRequest({
      this.userId, 
      this.priceId,});

  TivraHealthPaymentLinkRequest.fromJson(dynamic json) {
    userId = json['userId'];
    priceId = json['priceId'];
  }
  String? userId;
  String? priceId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = userId;
    map['priceId'] = priceId;
    return map;
  }

}