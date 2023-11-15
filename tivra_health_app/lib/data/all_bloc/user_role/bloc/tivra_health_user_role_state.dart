import 'package:equatable/equatable.dart';
import 'package:tivra_health/data/all_bloc/user_role/repo/tivra_health_user_role_response.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';

enum TivraHealthUserRoleStatus { loading, success, failed }

class TivraHealthUserRoleState extends Equatable {
  const TivraHealthUserRoleState(
      {this.status = TivraHealthUserRoleStatus.loading,
        this.mTivraHealthUserRoleResponse ,
        this.webResponseFailed});

  final TivraHealthUserRoleStatus status;
  final TivraHealthUserRoleResponse? mTivraHealthUserRoleResponse;
  final WebResponseFailed? webResponseFailed;


  TivraHealthUserRoleState copyWith({
    TivraHealthUserRoleStatus? status,
    TivraHealthUserRoleResponse? mTivraHealthUserRoleResponse,
    WebResponseFailed? webResponseFailed
  }) {
    return TivraHealthUserRoleState(
      status: status ?? this.status,
      mTivraHealthUserRoleResponse:
      mTivraHealthUserRoleResponse ?? this.mTivraHealthUserRoleResponse,
      webResponseFailed: webResponseFailed ?? this.webResponseFailed,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, TivraHealthUserRoleResponse: $mTivraHealthUserRoleResponse }''';
  }

  @override
  List<Object> get props => [
    status,
    mTivraHealthUserRoleResponse??TivraHealthUserRoleResponse(),
    webResponseFailed ?? WebResponseFailed()
  ];
}
