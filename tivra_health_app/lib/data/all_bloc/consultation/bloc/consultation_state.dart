import 'package:equatable/equatable.dart';
import 'package:tivra_health/data/all_bloc/consultation/repo/consultation_response.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';

enum ConsultationStatus { loading, success, failed }

class ConsultationState extends Equatable {
  const ConsultationState(
      {this.status = ConsultationStatus.loading,
      this.mTivraHealthRegisterScreenResponse,
      this.webResponseFailed});

  final ConsultationStatus status;
  final ConsultationResponse? mTivraHealthRegisterScreenResponse;
  final WebResponseFailed? webResponseFailed;

  ConsultationState copyWith(
      {ConsultationStatus? status,
        ConsultationResponse? mTivraHealthRegisterScreenResponse,
      WebResponseFailed? webResponseFailed}) {
    return ConsultationState(
      status: status ?? this.status,
      mTivraHealthRegisterScreenResponse: mTivraHealthRegisterScreenResponse ??
          this.mTivraHealthRegisterScreenResponse,
      webResponseFailed: webResponseFailed ?? this.webResponseFailed,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, TivraHealthRegisterScreenResponse: $mTivraHealthRegisterScreenResponse }''';
  }

  @override
  List<Object> get props => [
        status,
        mTivraHealthRegisterScreenResponse ?? ConsultationResponse(),
        webResponseFailed ?? WebResponseFailed()
      ];
}
