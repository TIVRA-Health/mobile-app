import 'package:equatable/equatable.dart';
import 'package:tivra_health/data/all_bloc/create_account/repo/tivra_health_create_account_response.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';

enum TivraHealthCreateAccountStatus { loading, success, failed }

class TivraHealthCreateAccountState extends Equatable {
  const TivraHealthCreateAccountState(
      {this.status = TivraHealthCreateAccountStatus.loading,
        this.mTivraHealthCreateAccountResponse ,
        this.webResponseFailed});

  final TivraHealthCreateAccountStatus status;
  final TivraHealthCreateAccountResponse? mTivraHealthCreateAccountResponse;
  final WebResponseFailed? webResponseFailed;


  TivraHealthCreateAccountState copyWith({
    TivraHealthCreateAccountStatus? status,
    TivraHealthCreateAccountResponse? mTivraHealthCreateAccountResponse,
    WebResponseFailed? webResponseFailed
  }) {
    return TivraHealthCreateAccountState(
      status: status ?? this.status,
      mTivraHealthCreateAccountResponse:
      mTivraHealthCreateAccountResponse ?? this.mTivraHealthCreateAccountResponse,
      webResponseFailed: webResponseFailed ?? this.webResponseFailed,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, TivraHealthCreateAccountResponse: $mTivraHealthCreateAccountResponse }''';
  }

  @override
  List<Object> get props => [
    status,
    mTivraHealthCreateAccountResponse??TivraHealthCreateAccountResponse(),
    webResponseFailed ?? WebResponseFailed()
  ];
}
