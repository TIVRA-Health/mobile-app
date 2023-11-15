/// message : "Error interacting with the OpenAI"

class ConsultationResponse {
  ConsultationResponse({
      this.gptResponse,});

  ConsultationResponse.fromJson(dynamic json) {
    gptResponse = json['gptResponse'];
  }
  String? gptResponse;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['gptResponse'] = gptResponse;
    return map;
  }

}