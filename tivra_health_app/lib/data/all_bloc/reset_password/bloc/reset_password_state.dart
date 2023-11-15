import 'package:equatable/equatable.dart';
import 'package:tivra_health/data/all_bloc/request_otp/repo/tivra_health_register_screen_otp_response.dart';
import 'package:tivra_health/data/all_bloc/reset_password/repo/reset_password_response.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';

enum ResetPasswordStatus { loading, success, failed }

class ResetPasswordState extends Equatable {
  const ResetPasswordState(
      {this.status = ResetPasswordStatus.loading,
        this.mTivraHealthRegisterScreenResponse ,
        this.webResponseFailed});

  final ResetPasswordStatus status;
  final ResetPasswordResponse? mTivraHealthRegisterScreenResponse;
  final WebResponseFailed? webResponseFailed;


  ResetPasswordState copyWith({
    ResetPasswordStatus? status,
    ResetPasswordResponse? mTivraHealthRegisterScreenResponse,
    WebResponseFailed? webResponseFailed
  }) {
    return ResetPasswordState(
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
    mTivraHealthRegisterScreenResponse??ResetPasswordResponse(),
    webResponseFailed ?? WebResponseFailed()
  ];
}
