
/// "senderUserId": "techsupport@tivrahealth.com",
/// "senderEmail": "Testing@123"


class InviteRequest {
  InviteRequest({
    String? senderUserId,
    String? senderEmail,
    String? inviteEmail,
    String? subject,
  }){
    _senderUserId = senderUserId;
    _senderEmail = senderEmail;
    _inviteEmail = inviteEmail;
    _subject = subject;
  }

  InviteRequest.fromJson(dynamic json) {
    _senderUserId = json['senderUserId'];
    _senderEmail = json['senderEmail'];
    _inviteEmail = json['inviteEmail'];
    _subject = json['subject'];
  }
  String? _senderUserId;
  String? _senderEmail;
  String? _inviteEmail;
  String? _subject;

  String? get senderUserId => _senderUserId;
  String? get senderEmail => _senderEmail;
  String? get inviteEmail => _inviteEmail;
  String? get subject => _subject;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['senderUserId'] = _senderUserId;
    map['subject'] = _subject;
    if(_senderEmail!=null) {
      map['senderEmail'] = _senderEmail;
    }
    if(_inviteEmail!=null) {
      map['inviteEmail'] = _inviteEmail;
    }
    return map;
  }
}