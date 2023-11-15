
/// "username": "techsupport@tivrahealth.com",
/// "password": "Testing@123"


class TivraHealthLoginScreenRequest {
  TivraHealthLoginScreenRequest({
    String? userName,
    String? password,
  }){
    _userName = userName;
    _password = password;
  }

  TivraHealthLoginScreenRequest.fromJson(dynamic json) {
    _userName = json['username'];
    _password = json['password'];
  }
  String? _userName;
  String? _password;

  String? get userName => _userName;
  String? get password => _password;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['username'] = _userName;
    map['password'] = _password;
    return map;
  }
}