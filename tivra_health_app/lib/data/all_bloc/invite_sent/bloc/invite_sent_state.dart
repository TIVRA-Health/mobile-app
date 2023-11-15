import 'package:equatable/equatable.dart';
import 'package:tivra_health/data/all_bloc/invite_sent/repo/invite_sent_response.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';

enum InviteSentStatus { loading, success, failed }

class InviteSentState extends Equatable {
  const InviteSentState(
      {this.status = InviteSentStatus.loading,
        this.mInviteSentResponse ,
        this.webResponseFailed});

  final InviteSentStatus status;
  final InviteSentResponse? mInviteSentResponse;
  final WebResponseFailed? webResponseFailed;



  InviteSentState copyWith({
    InviteSentStatus? status,
    InviteSentResponse? mInviteSentResponse,
    WebResponseFailed? webResponseFailed
  }) {
    return InviteSentState(
      status: status ?? this.status,
      mInviteSentResponse:
      mInviteSentResponse ?? this.mInviteSentResponse,
      webResponseFailed:  webResponseFailed ?? this.webResponseFailed,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, InviteSentResponse: $mInviteSentResponse }''';
  }

  @override
  List<Object> get props => [
    status,
    mInviteSentResponse??InviteSentResponse(),
    webResponseFailed ?? WebResponseFailed()
  ];
}
