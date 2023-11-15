/// formData : {"educationLevel":"Vocational qualification","healthCare":true,"hospitalAssociated":"","incomeRange":"$80K to $100K","userId":"6515f86d0b21a3b2f80bac4c"}

class TivraHealthSocialProfileRequest {
  TivraHealthSocialProfileRequest({
    FormData? formData,
  }){
    _formData = formData;
  }

  TivraHealthSocialProfileRequest.fromJson(dynamic json) {
    _formData =
        json['formData'] != null ? FormData.fromJson(json['formData']) : null;
  }

  FormData? _formData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_formData != null) {
      map['formData'] = _formData?.toJson();
    }
    return map;
  }
}

/// educationLevel : "Vocational qualification"
/// healthCare : true
/// hospitalAssociated : ""
/// incomeRange : "$80K to $100K"
/// userId : "6515f86d0b21a3b2f80bac4c"

class FormData {
  FormData({
    String? educationLevel,
    bool? healthCare,
    String? hospitalAssociated,
    String? incomeRange,
    String? userId,
  }) {
    _educationLevel = educationLevel;
    _healthCare = healthCare;
    _hospitalAssociated = hospitalAssociated;
    _incomeRange = incomeRange;
    _userId = userId;
  }

  FormData.fromJson(dynamic json) {
    _educationLevel = json['educationLevel'];
    _healthCare = json['healthCare'];
    _hospitalAssociated = json['hospitalAssociated'];
    _incomeRange = json['incomeRange'];
    _userId = json['userId'];
  }

  String? _educationLevel;
  bool? _healthCare;
  String? _hospitalAssociated;
  String? _incomeRange;
  String? _userId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['educationLevel'] = _educationLevel;
    map['healthCare'] = _healthCare;
    map['hospitalAssociated'] = _hospitalAssociated;
    map['incomeRange'] = _incomeRange;
    map['userId'] = _userId;
    return map;
  }
}
