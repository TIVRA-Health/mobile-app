
/// "id": "techsupport@tivrahealth.com",
/// "isApproved": "Testing@123"


class InviteUpdateRequest {
  InviteUpdateRequest({
    String? id,
    String? isApproved,
    String? status,
  }){
    _id = id;
    _isApproved = isApproved;
    _status = status;
  }

  InviteUpdateRequest.fromJson(dynamic json) {
    _id = json['id'];
    _isApproved = json['isApproved'];
    _status = json['status'];
  }
  String? _id;
  String? _isApproved;
  String? _status;

  String? get id => _id;
  String? get isApproved => _isApproved;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    if(_isApproved!=null) {
      map['isApproved'] = _isApproved;
    }
    if(_status!=null) {
      map['status'] = _status;
    }
    return map;
  }
}