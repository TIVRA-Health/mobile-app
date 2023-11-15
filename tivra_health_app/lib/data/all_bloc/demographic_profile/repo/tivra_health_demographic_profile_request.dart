/// formData : {"address1":"FC 105","address2":"MG Street","city":"Houston","country":"US","dob":"1980-09-27T20:53:04.978+00:00","gender":"Male","state":"Texas","zip":"115598","userId":"6515f86d0b21a3b2f80bac4c"}

class TivraHealthDemographicProfileRequest {
  TivraHealthDemographicProfileRequest({
      FormData? formData,}){
    _formData = formData;
  }

  TivraHealthDemographicProfileRequest.fromJson(dynamic json) {
    _formData = json['formData'] != null ? FormData.fromJson(json['formData']) : null;
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

/// address1 : "FC 105"
/// address2 : "MG Street"
/// city : "Houston"
/// country : "US"
/// dob : "1980-09-27T20:53:04.978+00:00"
/// gender : "Male"
/// state : "Texas"
/// zip : "115598"
/// userId : "6515f86d0b21a3b2f80bac4c"

class FormData {
  FormData({
    String? address1,
    String? address2,
    String? city,
    String? country,
    String? dob,
    String? gender,
    String? state,
    String? zip,
    String? userId,}){
    _address1 = address1;
    _address2 = address2;
    _city = city;
    _country = country;
    _dob = dob;
    _gender = gender;
    _state = state;
    _zip = zip;
    _userId = userId;
  }

  FormData.fromJson(dynamic json) {
    _address1 = json['address1'];
    _address2 = json['address2'];
    _city = json['city'];
    _country = json['country'];
    _dob = json['dob'];
    _gender = json['gender'];
    _state = json['state'];
    _zip = json['zip'];
    _userId = json['userId'];
  }
  String? _address1;
  String? _address2;
  String? _city;
  String? _country;
  String? _dob;
  String? _gender;
  String? _state;
  String? _zip;
  String? _userId;

  String? get address1 => _address1;
  String? get address2 => _address2;
  String? get city => _city;
  String? get country => _country;
  String? get dob => _dob;
  String? get gender => _gender;
  String? get state => _state;
  String? get zip => _zip;
  String? get userId => _userId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['address1'] = _address1;
    map['address2'] = _address2;
    map['city'] = _city;
    map['country'] = _country;
    map['dob'] = _dob;
    map['gender'] = _gender;
    map['state'] = _state;
    map['zip'] = _zip;
    map['userId'] = _userId;
    return map;
  }

}