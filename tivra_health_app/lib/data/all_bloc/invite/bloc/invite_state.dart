import 'package:equatable/equatable.dart';
import 'package:tivra_health/data/all_bloc/invite/repo/invite_response.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';

enum InviteStatus { loading, success, failed }

class InviteState extends Equatable {
  const InviteState(
      {this.status = InviteStatus.loading,
        this.mInviteResponse ,
        this.webResponseFailed});

  final InviteStatus status;
  final InviteResponse? mInviteResponse;
  final WebResponseFailed? webResponseFailed;



  InviteState copyWith({
    InviteStatus? status,
    InviteResponse? mInviteResponse,
    WebResponseFailed? webResponseFailed
  }) {
    return InviteState(
      status: status ?? this.status,
      mInviteResponse:
      mInviteResponse ?? this.mInviteResponse,
      webResponseFailed: webResponseFailed ?? this.webResponseFailed,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, InviteResponse: $mInviteResponse }''';
  }

  @override
  List<Object> get props => [
    status,
    mInviteResponse??InviteResponse(),
    webResponseFailed ?? WebResponseFailed()
  ];
}
