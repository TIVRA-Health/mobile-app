import 'package:equatable/equatable.dart';
import 'package:tivra_health/data/all_bloc/invite_sent/repo/invite_sent_response.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';

enum InviteReceiveStatus { loading, success, failed }

class InviteReceiveState extends Equatable {
  const InviteReceiveState(
      {this.status = InviteReceiveStatus.loading,
        this.mInviteReceiveResponse ,
        this.webResponseFailed});

  final InviteReceiveStatus status;
  final InviteSentResponse? mInviteReceiveResponse;
  final WebResponseFailed? webResponseFailed;



  InviteReceiveState copyWith({
    InviteReceiveStatus? status,
    InviteSentResponse? mInviteReceiveResponse,
    WebResponseFailed? webResponseFailed
  }) {
    return InviteReceiveState(
      status: status ?? this.status,
      mInviteReceiveResponse:
      mInviteReceiveResponse ?? this.mInviteReceiveResponse,
      webResponseFailed:  webResponseFailed ?? this.webResponseFailed,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, InviteReceiveResponse: $mInviteReceiveResponse }''';
  }

  @override
  List<Object> get props => [
    status,
    mInviteReceiveResponse??InviteSentResponse(),
    webResponseFailed ?? WebResponseFailed()
  ];
}
