import 'package:equatable/equatable.dart';
import 'package:tivra_health/data/all_bloc/tivra_health_registration/repo/tivra_health_register_screen_response.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';

enum TivraHealthRegisterScreenStatus { loading, success, failed }

class TivraHealthRegisterScreenState extends Equatable {
  const TivraHealthRegisterScreenState(
      {this.status = TivraHealthRegisterScreenStatus.loading,
        this.mTivraHealthRegisterScreenResponse ,
        this.webResponseFailed});

  final TivraHealthRegisterScreenStatus status;
  final TivraHealthRegisterScreenResponse? mTivraHealthRegisterScreenResponse;
  final WebResponseFailed? webResponseFailed;


  TivraHealthRegisterScreenState copyWith({
    TivraHealthRegisterScreenStatus? status,
    TivraHealthRegisterScreenResponse? mTivraHealthRegisterScreenResponse,
    WebResponseFailed? webResponseFailed
  }) {
    return TivraHealthRegisterScreenState(
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
    mTivraHealthRegisterScreenResponse??TivraHealthRegisterScreenResponse(),
    webResponseFailed ?? WebResponseFailed()
  ];
}
