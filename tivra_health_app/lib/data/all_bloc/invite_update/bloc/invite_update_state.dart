import 'package:equatable/equatable.dart';
import 'package:tivra_health/data/all_bloc/invite_update/repo/invite_update_response.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';

enum InviteUpdateStatus { loading, success, failed }

class InviteUpdateState extends Equatable {
  const InviteUpdateState(
      {this.status = InviteUpdateStatus.loading,
        this.mInviteUpdateResponse ,
        this.webResponseFailed});

  final InviteUpdateStatus status;
  final InviteUpdateResponse? mInviteUpdateResponse;
  final WebResponseFailed? webResponseFailed;



  InviteUpdateState copyWith({
    InviteUpdateStatus? status,
    InviteUpdateResponse? mInviteUpdateResponse,
    WebResponseFailed? webResponseFailed
  }) {
    return InviteUpdateState(
      status: status ?? this.status,
      mInviteUpdateResponse:
      mInviteUpdateResponse ?? this.mInviteUpdateResponse,
      webResponseFailed: webResponseFailed ?? this.webResponseFailed,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, InviteUpdateResponse: $mInviteUpdateResponse }''';
  }

  @override
  List<Object> get props => [
    status,
    mInviteUpdateResponse??InviteUpdateResponse(),
    webResponseFailed ?? WebResponseFailed()
  ];
}
