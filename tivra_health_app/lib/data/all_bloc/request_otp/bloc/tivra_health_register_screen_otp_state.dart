import 'package:equatable/equatable.dart';
import 'package:tivra_health/data/all_bloc/request_otp/repo/tivra_health_register_screen_otp_response.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';

enum TivraHealthRegisterScreenOTPStatus { loading, success, failed }

class TivraHealthRegisterScreenOTPState extends Equatable {
  const TivraHealthRegisterScreenOTPState(
      {this.status = TivraHealthRegisterScreenOTPStatus.loading,
        this.mTivraHealthRegisterScreenResponse ,
        this.webResponseFailed});

  final TivraHealthRegisterScreenOTPStatus status;
  final TivraHealthRegisterScreenOtpResponse? mTivraHealthRegisterScreenResponse;
  final WebResponseFailed? webResponseFailed;


  TivraHealthRegisterScreenOTPState copyWith({
    TivraHealthRegisterScreenOTPStatus? status,
    TivraHealthRegisterScreenOtpResponse? mTivraHealthRegisterScreenResponse,
    WebResponseFailed? webResponseFailed
  }) {
    return TivraHealthRegisterScreenOTPState(
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
    mTivraHealthRegisterScreenResponse??TivraHealthRegisterScreenOtpResponse(),
    webResponseFailed ?? WebResponseFailed()
  ];
}
