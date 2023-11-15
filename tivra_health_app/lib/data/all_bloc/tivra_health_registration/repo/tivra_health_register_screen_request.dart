
/// "username": "techsupport@tivrahealth.com",
/// "password": "Testing@123"


class TivraHealthRegisterScreenRequest {
  TivraHealthRegisterScreenRequest({
    String? firstName,
    String? middleName,
    String? lastName,
    String? email,
    String? phoneNumber,
  }){
    _firstName = firstName;
    _middleName = middleName;
    _lastName = lastName;
    _email = email;
    _phoneNumber = phoneNumber;
  }

  TivraHealthRegisterScreenRequest.fromJson(dynamic json) {
    _firstName = json['firstName'];
    _middleName = json['middleName'];
    _lastName = json['lastName'];
    _email = json['email'];
    _phoneNumber = json['phoneNumber'];
  }
  String? _firstName;
  String? _middleName;
  String? _lastName;
  String? _email;
  String? _phoneNumber;

  String? get firstName => _firstName;
  String? get middleName => _middleName;
  String? get lastName => _lastName;
  String? get email => _email;
  String? get phoneNumber => _phoneNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['firstName'] = _firstName;
    map['middleName'] = _middleName;
    map['lastName'] = _lastName;
    map['email'] = _email;
    map['phoneNumber'] = _phoneNumber;
    return map;
  }
}