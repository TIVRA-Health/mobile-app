/// id : "plink_1O55rtKKoWpF5LTXth003hZf"
/// object : "payment_link"
/// active : true
/// after_completion : {"redirect":{"url":"https://uattivrafit.com/sign-up/create-profile"},"type":"redirect"}
/// allow_promotion_codes : false
/// application : null
/// application_fee_amount : null
/// application_fee_percent : null
/// automatic_tax : {"enabled":false}
/// billing_address_collection : "auto"
/// consent_collection : null
/// currency : "usd"
/// custom_fields : []
/// custom_text : {"shipping_address":null,"submit":null,"terms_of_service_acceptance":null}
/// customer_creation : "if_required"
/// invoice_creation : {"enabled":false,"invoice_data":{"account_tax_ids":null,"custom_fields":null,"description":null,"footer":null,"metadata":{},"rendering_options":null}}
/// livemode : false
/// metadata : {}
/// on_behalf_of : null
/// payment_intent_data : null
/// payment_method_collection : "always"
/// payment_method_types : null
/// phone_number_collection : {"enabled":false}
/// shipping_address_collection : null
/// shipping_options : []
/// submit_type : "auto"
/// subscription_data : null
/// tax_id_collection : {"enabled":false}
/// transfer_data : null
/// url : "https://buy.stripe.com/test_14k00EgCIgGKcwMaGJ"

class TivraHealthPaymentLinkResponse {
  TivraHealthPaymentLinkResponse({
      this.id, 
      this.object, 
      this.active, 
      this.afterCompletion, 
      this.allowPromotionCodes, 
      this.application, 
      this.applicationFeeAmount, 
      this.applicationFeePercent, 
      this.automaticTax, 
      this.billingAddressCollection, 
      this.consentCollection, 
      this.currency, 
      this.customFields, 
      this.customText, 
      this.customerCreation, 
      this.invoiceCreation, 
      this.livemode, 
      this.metadata, 
      this.onBehalfOf, 
      this.paymentIntentData, 
      this.paymentMethodCollection, 
      this.paymentMethodTypes, 
      this.phoneNumberCollection, 
      this.shippingAddressCollection, 
      this.shippingOptions, 
      this.submitType, 
      this.subscriptionData, 
      this.taxIdCollection, 
      this.transferData, 
      this.url,});

  TivraHealthPaymentLinkResponse.fromJson(dynamic json) {
    id = json['id'];
    object = json['object'];
    active = json['active'];
    afterCompletion = json['after_completion'] != null ? AfterCompletion.fromJson(json['after_completion']) : null;
    allowPromotionCodes = json['allow_promotion_codes'];
    application = json['application'];
    applicationFeeAmount = json['application_fee_amount'];
    applicationFeePercent = json['application_fee_percent'];
    automaticTax = json['automatic_tax'] != null ? AutomaticTax.fromJson(json['automatic_tax']) : null;
    billingAddressCollection = json['billing_address_collection'];
    consentCollection = json['consent_collection'];
    currency = json['currency'];
    /*if (json['custom_fields'] != null) {
      customFields = [];
      json['custom_fields'].forEach((v) {
        customFields?.add(Dynamic.fromJson(v));
      });
    }*/
    customText = json['custom_text'] != null ? CustomText.fromJson(json['custom_text']) : null;
    customerCreation = json['customer_creation'];
    invoiceCreation = json['invoice_creation'] != null ? InvoiceCreation.fromJson(json['invoice_creation']) : null;
    livemode = json['livemode'];
    metadata = json['metadata'];
    onBehalfOf = json['on_behalf_of'];
    paymentIntentData = json['payment_intent_data'];
    paymentMethodCollection = json['payment_method_collection'];
    paymentMethodTypes = json['payment_method_types'];
    phoneNumberCollection = json['phone_number_collection'] != null ? PhoneNumberCollection.fromJson(json['phone_number_collection']) : null;
    shippingAddressCollection = json['shipping_address_collection'];
   /* if (json['shipping_options'] != null) {
      shippingOptions = [];
      json['shipping_options'].forEach((v) {
        shippingOptions?.add(Dynamic.fromJson(v));
      });
    }*/
    submitType = json['submit_type'];
    subscriptionData = json['subscription_data'];
    taxIdCollection = json['tax_id_collection'] != null ? TaxIdCollection.fromJson(json['tax_id_collection']) : null;
    transferData = json['transfer_data'];
    url = json['url'];
  }
  String? id;
  String? object;
  bool? active;
  AfterCompletion? afterCompletion;
  bool? allowPromotionCodes;
  dynamic application;
  dynamic applicationFeeAmount;
  dynamic applicationFeePercent;
  AutomaticTax? automaticTax;
  String? billingAddressCollection;
  dynamic consentCollection;
  String? currency;
  List<dynamic>? customFields;
  CustomText? customText;
  String? customerCreation;
  InvoiceCreation? invoiceCreation;
  bool? livemode;
  dynamic metadata;
  dynamic onBehalfOf;
  dynamic paymentIntentData;
  String? paymentMethodCollection;
  dynamic paymentMethodTypes;
  PhoneNumberCollection? phoneNumberCollection;
  dynamic shippingAddressCollection;
  List<dynamic>? shippingOptions;
  String? submitType;
  dynamic subscriptionData;
  TaxIdCollection? taxIdCollection;
  dynamic transferData;
  String? url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['object'] = object;
    map['active'] = active;
    if (afterCompletion != null) {
      map['after_completion'] = afterCompletion?.toJson();
    }
    map['allow_promotion_codes'] = allowPromotionCodes;
    map['application'] = application;
    map['application_fee_amount'] = applicationFeeAmount;
    map['application_fee_percent'] = applicationFeePercent;
    if (automaticTax != null) {
      map['automatic_tax'] = automaticTax?.toJson();
    }
    map['billing_address_collection'] = billingAddressCollection;
    map['consent_collection'] = consentCollection;
    map['currency'] = currency;
    if (customFields != null) {
      map['custom_fields'] = customFields?.map((v) => v.toJson()).toList();
    }
    if (customText != null) {
      map['custom_text'] = customText?.toJson();
    }
    map['customer_creation'] = customerCreation;
    if (invoiceCreation != null) {
      map['invoice_creation'] = invoiceCreation?.toJson();
    }
    map['livemode'] = livemode;
    map['metadata'] = metadata;
    map['on_behalf_of'] = onBehalfOf;
    map['payment_intent_data'] = paymentIntentData;
    map['payment_method_collection'] = paymentMethodCollection;
    map['payment_method_types'] = paymentMethodTypes;
    if (phoneNumberCollection != null) {
      map['phone_number_collection'] = phoneNumberCollection?.toJson();
    }
    map['shipping_address_collection'] = shippingAddressCollection;
    if (shippingOptions != null) {
      map['shipping_options'] = shippingOptions?.map((v) => v.toJson()).toList();
    }
    map['submit_type'] = submitType;
    map['subscription_data'] = subscriptionData;
    if (taxIdCollection != null) {
      map['tax_id_collection'] = taxIdCollection?.toJson();
    }
    map['transfer_data'] = transferData;
    map['url'] = url;
    return map;
  }

}

/// enabled : false

class TaxIdCollection {
  TaxIdCollection({
      this.enabled,});

  TaxIdCollection.fromJson(dynamic json) {
    enabled = json['enabled'];
  }
  bool? enabled;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['enabled'] = enabled;
    return map;
  }

}

/// enabled : false

class PhoneNumberCollection {
  PhoneNumberCollection({
      this.enabled,});

  PhoneNumberCollection.fromJson(dynamic json) {
    enabled = json['enabled'];
  }
  bool? enabled;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['enabled'] = enabled;
    return map;
  }

}

/// enabled : false
/// invoice_data : {"account_tax_ids":null,"custom_fields":null,"description":null,"footer":null,"metadata":{},"rendering_options":null}

class InvoiceCreation {
  InvoiceCreation({
      this.enabled, 
      this.invoiceData,});

  InvoiceCreation.fromJson(dynamic json) {
    enabled = json['enabled'];
    invoiceData = json['invoice_data'] != null ? InvoiceData.fromJson(json['invoice_data']) : null;
  }
  bool? enabled;
  InvoiceData? invoiceData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['enabled'] = enabled;
    if (invoiceData != null) {
      map['invoice_data'] = invoiceData?.toJson();
    }
    return map;
  }

}

/// account_tax_ids : null
/// custom_fields : null
/// description : null
/// footer : null
/// metadata : {}
/// rendering_options : null

class InvoiceData {
  InvoiceData({
      this.accountTaxIds, 
      this.customFields, 
      this.description, 
      this.footer, 
      this.metadata, 
      this.renderingOptions,});

  InvoiceData.fromJson(dynamic json) {
    accountTaxIds = json['account_tax_ids'];
    customFields = json['custom_fields'];
    description = json['description'];
    footer = json['footer'];
    metadata = json['metadata'];
    renderingOptions = json['rendering_options'];
  }
  dynamic accountTaxIds;
  dynamic customFields;
  dynamic description;
  dynamic footer;
  dynamic metadata;
  dynamic renderingOptions;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['account_tax_ids'] = accountTaxIds;
    map['custom_fields'] = customFields;
    map['description'] = description;
    map['footer'] = footer;
    map['metadata'] = metadata;
    map['rendering_options'] = renderingOptions;
    return map;
  }

}

/// shipping_address : null
/// submit : null
/// terms_of_service_acceptance : null

class CustomText {
  CustomText({
      this.shippingAddress, 
      this.submit, 
      this.termsOfServiceAcceptance,});

  CustomText.fromJson(dynamic json) {
    shippingAddress = json['shipping_address'];
    submit = json['submit'];
    termsOfServiceAcceptance = json['terms_of_service_acceptance'];
  }
  dynamic shippingAddress;
  dynamic submit;
  dynamic termsOfServiceAcceptance;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['shipping_address'] = shippingAddress;
    map['submit'] = submit;
    map['terms_of_service_acceptance'] = termsOfServiceAcceptance;
    return map;
  }

}

/// enabled : false

class AutomaticTax {
  AutomaticTax({
      this.enabled,});

  AutomaticTax.fromJson(dynamic json) {
    enabled = json['enabled'];
  }
  bool? enabled;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['enabled'] = enabled;
    return map;
  }

}

/// redirect : {"url":"https://uattivrafit.com/sign-up/create-profile"}
/// type : "redirect"

class AfterCompletion {
  AfterCompletion({
      this.redirect, 
      this.type,});

  AfterCompletion.fromJson(dynamic json) {
    redirect = json['redirect'] != null ? Redirect.fromJson(json['redirect']) : null;
    type = json['type'];
  }
  Redirect? redirect;
  String? type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (redirect != null) {
      map['redirect'] = redirect?.toJson();
    }
    map['type'] = type;
    return map;
  }

}

/// url : "https://uattivrafit.com/sign-up/create-profile"

class Redirect {
  Redirect({
      this.url,});

  Redirect.fromJson(dynamic json) {
    url = json['url'];
  }
  String? url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = url;
    return map;
  }

}