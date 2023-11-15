import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tivra_health/data/all_bloc/invite_receive/bloc/invite_receive_event.dart';
import 'package:tivra_health/data/all_bloc/invite_receive/bloc/invite_receive_state.dart';
import 'package:tivra_health/data/all_bloc/invite_receive/repo/invite_receive_repo.dart';
import 'package:tivra_health/data/all_bloc/invite_sent/repo/invite_sent_response.dart';
import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';
import 'package:tivra_health/data/remote/web_service.dart';

class InviteReceiveBloc
    extends Bloc<InviteReceiveEvent, InviteReceiveState> {
  final InviteReceiveRepository repository =
      InviteReceiveRepository(
          sharedPrefs: SharedPrefs(), webservice: Webservice());

  InviteReceiveBloc() : super(const InviteReceiveState()) {
    on<InviteReceiveClickEvent>(
      (event, emit) async {
        emit(state.copyWith(status: InviteReceiveStatus.loading));
        try {
          var response =
              await repository.fetchInviteReceive(event.mStringRequest);

          if (response is InviteSentResponse) {
            emit(state.copyWith(
              status: InviteReceiveStatus.success,
              mInviteReceiveResponse: response,
            ));
          } else if (response is WebResponseFailed) {
            emit(state.copyWith(
                status: InviteReceiveStatus.failed,
                webResponseFailed: response));
          }
        } catch (e) {
          emit(state.copyWith(
              status: InviteReceiveStatus.failed,
              webResponseFailed: WebResponseFailed(
                  statusMessage: "Unable to process your request right now")));
        }
      },
    );
  }
}
