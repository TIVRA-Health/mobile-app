/// "deviceBrand":"6510c25a0a8340c61ce9dc9b"

class DeviceRegistrationRequest {
  DeviceRegistrationRequest({
    String? deviceBrand,
  }) {
    _deviceBrand = deviceBrand;
  }

  DeviceRegistrationRequest.fromJson(dynamic json) {
    _deviceBrand = json['deviceBrand'];
  }

  String? _deviceBrand;

  String? get deviceBrand => _deviceBrand;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['deviceBrand'] = _deviceBrand;
    return map;
  }
}
