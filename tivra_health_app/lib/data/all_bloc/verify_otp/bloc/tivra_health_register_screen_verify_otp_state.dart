import 'package:equatable/equatable.dart';
import 'package:tivra_health/data/all_bloc/verify_otp/repo/tivra_health_verify_otp_response.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';

enum TivraHealthRegisterScreenVerifyOTPStatus { loading, success, failed }

class TivraHealthRegisterScreenVerifyOTPState extends Equatable {
  const TivraHealthRegisterScreenVerifyOTPState(
      {this.status = TivraHealthRegisterScreenVerifyOTPStatus.loading,
        this.mTivraHealthRegisterScreenResponse ,
        this.webResponseFailed});

  final TivraHealthRegisterScreenVerifyOTPStatus status;
  final TivraHealthVerifyOTPResponse? mTivraHealthRegisterScreenResponse;
  final WebResponseFailed? webResponseFailed;


  TivraHealthRegisterScreenVerifyOTPState copyWith({
    TivraHealthRegisterScreenVerifyOTPStatus? status,
    TivraHealthVerifyOTPResponse? mTivraHealthRegisterScreenResponse,
    WebResponseFailed? webResponseFailed
  }) {
    return TivraHealthRegisterScreenVerifyOTPState(
      status: status ?? this.status,
      mTivraHealthRegisterScreenResponse:
      mTivraHealthRegisterScreenResponse ?? this.mTivraHealthRegisterScreenResponse,
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
    mTivraHealthRegisterScreenResponse??TivraHealthVerifyOTPResponse(),
    webResponseFailed ?? WebResponseFailed()
  ];
}
