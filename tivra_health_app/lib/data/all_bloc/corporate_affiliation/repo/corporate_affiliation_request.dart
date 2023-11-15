/// formData : {"address1":"1600 Amphitheatre","address2":"Pkwy","city":"Mountain View","country":"USA","npiNumber":"1598895039","organizationName":"Google","state":"CA","trackHealth":"true","typeOfEngagement":"","yearsOfCoaching":2010,"zip":"94043","registrationId":"3","userId":"6515f86d0b21a3b2f80bac4c"}

class CorporateAffiliationRequest {
  CorporateAffiliationRequest({
      this.formData,});

  CorporateAffiliationRequest.fromJson(dynamic json) {
    formData = json['formData'] != null ? FormData.fromJson(json['formData']) : null;
  }
  FormData? formData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (formData != null) {
      map['formData'] = formData?.toJson();
    }
    return map;
  }

}

/// address1 : "1600 Amphitheatre"
/// address2 : "Pkwy"
/// city : "Mountain View"
/// country : "USA"
/// npiNumber : "1598895039"
/// organizationName : "Google"
/// state : "CA"
/// trackHealth : "true"
/// typeOfEngagement : ""
/// yearsOfCoaching : 2010
/// zip : "94043"
/// registrationId : "3"
/// userId : "6515f86d0b21a3b2f80bac4c"

class FormData {
  FormData({
      this.address1, 
      this.address2, 
      this.city, 
      this.country, 
      this.npiNumber, 
      this.organizationName, 
      this.state, 
      this.trackHealth, 
      this.typeOfEngagement, 
      this.yearsOfCoaching, 
      this.zip, 
      this.registrationId, 
      this.userId,});

  FormData.fromJson(dynamic json) {
    address1 = json['address1'];
    address2 = json['address2'];
    city = json['city'];
    country = json['country'];
    npiNumber = json['npiNumber'];
    organizationName = json['organizationName'];
    state = json['state'];
    trackHealth = json['trackHealth'];
    typeOfEngagement = json['typeOfEngagement'];
    yearsOfCoaching = json['yearsOfCoaching'];
    zip = json['zip'];
    registrationId = json['registrationId'];
    userId = json['userId'];
  }
  String? address1;
  String? address2;
  String? city;
  String? country;
  String? npiNumber;
  String? organizationName;
  String? state;
  String? trackHealth;
  String? typeOfEngagement;
  num? yearsOfCoaching;
  String? zip;
  num? registrationId;
  String? userId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['address1'] = address1;
    map['address2'] = address2;
    map['city'] = city;
    map['country'] = country;
    map['npiNumber'] = npiNumber;
    map['organizationName'] = organizationName;
    map['state'] = state;
    map['trackHealth'] = trackHealth;
    map['typeOfEngagement'] = typeOfEngagement;
    map['yearsOfCoaching'] = yearsOfCoaching;
    map['zip'] = zip;
    map['registrationId'] = registrationId;
    map['userId'] = userId;
    return map;
  }

}