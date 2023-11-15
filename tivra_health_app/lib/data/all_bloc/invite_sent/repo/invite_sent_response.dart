/// data : [{"_id":"651f39282d7bfd5b7ad866e2","userName":"rahul singh","icon":"","role":"Wellness Coaches","status":0,"date":"2023-10-05T22:31:04.120Z","endDate":"2023-10-12T22:31:04.120Z","isIncomingInvite":false,"senderEmail":"techsupport@tivrahealth.com","senderUserId":"65159bbb90da941b73bd5921","inviteEmail":"joinme0222@gmail.com","subject":"Hi Rahul, let's catch-up on this awesome platform","id":"651f39282d7bfd5b7ad866e2"},{"_id":"6537008975689c7a2626751b","userName":"Test Testng","icon":"","role":"","status":"Pending","date":"2023-10-23T23:23:53.381Z","endDate":"2023-10-30T23:23:53.381Z","isIncomingInvite":false,"senderEmail":"techsupport@tivrahealth.com","senderUserId":"65159bbb90da941b73bd5921","inviteEmail":"prepexoveze-4@yopmail.com","subject":"Hey, let's catchup on this innovative platform","isApproved":false,"id":"6537008975689c7a2626751b"},{"_id":"6539c7f077b3a11ba92c17f5","userName":"Unknown Unknown","icon":"","role":"","status":"Pending","date":"2023-10-26T01:59:12.042Z","endDate":"2023-11-02T01:59:12.042Z","isIncomingInvite":false,"senderEmail":"techsupport@tivrahealth.com","senderUserId":"65159bbb90da941b73bd5921","inviteEmail":"shankar@vencertec.com","subject":"Lets catch up","isApproved":false,"id":"6539c7f077b3a11ba92c17f5"},{"_id":"653e2ed9e766126df7e2394c","userName":"Lavanya M","icon":"","role":"Fitness Enthusiast","status":4,"date":"2023-10-29T10:07:21.825Z","endDate":"2023-11-05T10:07:21.825Z","isIncomingInvite":false,"senderEmail":"techsupport@tivrahealth.com","senderUserId":"65159bbb90da941b73bd5921","inviteEmail":"lavanya0501@gmail.com","subject":"Wellness","isApproved":false,"id":"653e2ed9e766126df7e2394c"},{"_id":"651dfeadc2c8db0271ff6e4e","userName":"ra sdas","icon":"","role":"Pilot","status":3,"date":"2023-10-05T00:09:17.250Z","endDate":"2023-10-12T00:09:17.250Z","isIncomingInvite":false,"senderEmail":"techsupport@tivrahealth.com","senderUserId":"65159bbb90da941b73bd5921","inviteEmail":"rahu@gmail.com","subject":"Hi, Let's connect and for a team","isApproved":true,"id":"651dfeadc2c8db0271ff6e4e"}]

class InviteSentResponse {
  InviteSentResponse({
    this.data,});

  InviteSentResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(InviteSentData.fromJson(v));
      });
    }
  }
  List<InviteSentData>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// _id : "651f39282d7bfd5b7ad866e2"
/// userName : "rahul singh"
/// icon : ""
/// role : "Wellness Coaches"
/// status : 0
/// date : "2023-10-05T22:31:04.120Z"
/// endDate : "2023-10-12T22:31:04.120Z"
/// isIncomingInvite : false
/// senderEmail : "techsupport@tivrahealth.com"
/// senderUserId : "65159bbb90da941b73bd5921"
/// inviteEmail : "joinme0222@gmail.com"
/// subject : "Hi Rahul, let's catch-up on this awesome platform"
/// id : "651f39282d7bfd5b7ad866e2"

class InviteSentData {
  InviteSentData({
    this.id,
    this.userName,
    this.icon,
    this.role,
    this.status,
    this.date,
    this.endDate,
    this.isIncomingInvite,
    this.isApproved,
    this.senderEmail,
    this.senderUserId,
    this.inviteEmail,
    this.subject,
    this.idInviteSent,});

  InviteSentData.fromJson(dynamic json) {
    id = json['_id'];
    userName = json['userName'];
    icon = json['icon'];
    role = json['role'];
    status = json['status'].toString();
    date = json['date'];
    endDate = json['endDate'];
    isIncomingInvite = json['isIncomingInvite'];
    isApproved = json['isApproved'];
    senderEmail = json['senderEmail'];
    senderUserId = json['senderUserId'];
    inviteEmail = json['inviteEmail'];
    subject = json['subject'];
    idInviteSent = json['id'];
  }
  String? id;
  String? idInviteSent;
  String? userName;
  String? icon;
  String? role;
  String? status;
  String? date;
  String? endDate;
  bool? isIncomingInvite;
  bool? isApproved;
  String? senderEmail;
  String? senderUserId;
  String? inviteEmail;
  String? subject;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['userName'] = userName;
    map['icon'] = icon;
    map['role'] = role;
    map['status'] = status;
    map['date'] = date;
    map['endDate'] = endDate;
    map['isIncomingInvite'] = isIncomingInvite;
    map['isApproved'] = isApproved;
    map['senderEmail'] = senderEmail;
    map['senderUserId'] = senderUserId;
    map['inviteEmail'] = inviteEmail;
    map['subject'] = subject;
    map['id'] = idInviteSent;
    return map;
  }

}