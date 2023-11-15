import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tivra_health/data/all_bloc/invite_sent/bloc/invite_sent_event.dart';
import 'package:tivra_health/data/all_bloc/invite_sent/bloc/invite_sent_state.dart';
import 'package:tivra_health/data/all_bloc/invite_sent/repo/invite_sent_repo.dart';
import 'package:tivra_health/data/all_bloc/invite_sent/repo/invite_sent_response.dart';
import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';
import 'package:tivra_health/data/remote/web_service.dart';

class InviteSentBloc
    extends Bloc<InviteSentEvent, InviteSentState> {
  final InviteSentRepository repository =
      InviteSentRepository(
          sharedPrefs: SharedPrefs(), webservice: Webservice());

  InviteSentBloc() : super(const InviteSentState()) {
    on<InviteSentClickEvent>(
      (event, emit) async {
        emit(state.copyWith(status: InviteSentStatus.loading));
        try {
          var response =
              await repository.fetchInviteSent(event.mStringRequest);

          if (response is InviteSentResponse) {
            emit(state.copyWith(
              status: InviteSentStatus.success,
              mInviteSentResponse: response,
            ));
          } else if (response is WebResponseFailed) {
            emit(state.copyWith(
                status: InviteSentStatus.failed,
                webResponseFailed: response));
          }
        } catch (e) {
          emit(state.copyWith(
              status: InviteSentStatus.failed,
              webResponseFailed: WebResponseFailed(
                  statusMessage: "Unable to process your request right now")));
        }
      },
    );
  }
}
