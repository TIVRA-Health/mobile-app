/// message : "Hi, how're you doing?"

class ConsultationRequest {
  ConsultationRequest({
      this.message,});

  ConsultationRequest.fromJson(dynamic json) {
    message = json['message'];
  }
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    return map;
  }

}