/// address : {"addressLines":["1600 Amphitheatre Pkwy"]}

class AddressRequest {
  AddressRequest({
      this.address,});

  AddressRequest.fromJson(dynamic json) {
    address = json['address'] != null ? Address.fromJson(json['address']) : null;
  }
  Address? address;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (address != null) {
      map['address'] = address?.toJson();
    }
    return map;
  }

}

/// addressLines : ["1600 Amphitheatre Pkwy"]

class Address {
  Address({
      this.addressLines,});

  Address.fromJson(dynamic json) {
    addressLines = json['addressLines'] != null ? json['addressLines'].cast<String>() : [];
  }
  List<String>? addressLines;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['addressLines'] = addressLines;
    return map;
  }

}