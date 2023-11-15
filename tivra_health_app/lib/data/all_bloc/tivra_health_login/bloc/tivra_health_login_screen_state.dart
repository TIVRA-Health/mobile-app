import 'package:equatable/equatable.dart';
import 'package:tivra_health/data/all_bloc/tivra_health_login/repo/tivra_health_login_screen_response.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';

enum TivraHealthLoginScreenStatus { loading, success, failed }

class TivraHealthLoginScreenState extends Equatable {
  const TivraHealthLoginScreenState(
      {this.status = TivraHealthLoginScreenStatus.loading,
        this.mTivraHealthLoginScreenResponse ,
        this.webResponseFailed});

  final TivraHealthLoginScreenStatus status;
  final TivraHealthLoginScreenResponse? mTivraHealthLoginScreenResponse;
  final WebResponseFailed? webResponseFailed;



  TivraHealthLoginScreenState copyWith({
    TivraHealthLoginScreenStatus? status,
    TivraHealthLoginScreenResponse? mTivraHealthLoginScreenResponse,
    WebResponseFailed? webResponseFailed
  }) {
    return TivraHealthLoginScreenState(
      status: status ?? this.status,
      mTivraHealthLoginScreenResponse:
      mTivraHealthLoginScreenResponse ?? this.mTivraHealthLoginScreenResponse,
      webResponseFailed: webResponseFailed ?? this.webResponseFailed,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, TivraHealthLoginScreenResponse: $mTivraHealthLoginScreenResponse }''';
  }

  @override
  List<Object> get props => [
    status,
    mTivraHealthLoginScreenResponse??TivraHealthLoginScreenResponse(),
    webResponseFailed ?? WebResponseFailed()
  ];
}
