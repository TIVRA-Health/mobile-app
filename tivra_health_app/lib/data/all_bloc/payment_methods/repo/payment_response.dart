/// _id : "6510cb8e0a8340c61ce9dca7"
/// roleName : "Aviation Medical Examiner (AME)"
/// id : 9
/// active : 1
/// paymentPlans : [{"id":1,"plan":"Monthly","currency":"USD","amount":19.99,"description":"Billed Monthly","stripeProductPriceId":"price_1NzSTjKKoWpF5LTXnvLScJzR"},{"id":2,"plan":"Quarterly","currency":"USD","amount":54.99,"description":"Billed Quarterly","stripeProductPriceId":"price_1NzSTjKKoWpF5LTXnvLScJzR"},{"id":3,"plan":"Annually","currency":"USD","amount":199.99,"description":"Billed Annually","stripeProductPriceId":"price_1NzSTjKKoWpF5LTXnvLScJzR"}]
/// corporateAffiliation : 0
/// userRoleId : 9

class PaymentResponse {
  PaymentResponse({
      this.mainId,
      this.roleName, 
      this.id, 
      this.active, 
      this.paymentPlans, 
      this.corporateAffiliation, 
      this.userRoleId,});

  PaymentResponse.fromJson(dynamic json) {
    mainId = json['_id'];
    roleName = json['roleName'];
    id = json['id'];
    active = json['active'];
    if (json['paymentPlans'] != null) {
      paymentPlans = [];
      json['paymentPlans'].forEach((v) {
        paymentPlans?.add(PaymentPlans.fromJson(v));
      });
    }
    corporateAffiliation = json['corporateAffiliation'];
    userRoleId = json['userRoleId'];
  }
  String? mainId;
  String? roleName;
  int? id;
  int? active;
  List<PaymentPlans>? paymentPlans;
  int? corporateAffiliation;
  int? userRoleId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = mainId;
    map['roleName'] = roleName;
    map['id'] = id;
    map['active'] = active;
    if (paymentPlans != null) {
      map['paymentPlans'] = paymentPlans?.map((v) => v.toJson()).toList();
    }
    map['corporateAffiliation'] = corporateAffiliation;
    map['userRoleId'] = userRoleId;
    return map;
  }

}

/// id : 1
/// plan : "Monthly"
/// currency : "USD"
/// amount : 19.99
/// description : "Billed Monthly"
/// stripeProductPriceId : "price_1NzSTjKKoWpF5LTXnvLScJzR"

class PaymentPlans {
  PaymentPlans({
      this.id, 
      this.plan, 
      this.currency, 
      this.amount, 
      this.description, 
      this.stripeProductPriceId,});

  PaymentPlans.fromJson(dynamic json) {
    id = json['id'];
    plan = json['plan'];
    currency = json['currency'];
    amount = json['amount'];
    description = json['description'];
    stripeProductPriceId = json['stripeProductPriceId'];
  }
  int? id;
  String? plan;
  String? currency;
  int? amount;
  String? description;
  String? stripeProductPriceId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['plan'] = plan;
    map['currency'] = currency;
    map['amount'] = amount;
    map['description'] = description;
    map['stripeProductPriceId'] = stripeProductPriceId;
    return map;
  }

}