import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tivra_health/data/all_bloc/invite_update/bloc/invite_update_event.dart';
import 'package:tivra_health/data/all_bloc/invite_update/bloc/invite_update_state.dart';
import 'package:tivra_health/data/all_bloc/invite_update/repo/invite_update_repo.dart';
import 'package:tivra_health/data/all_bloc/invite_update/repo/invite_update_response.dart';
import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';
import 'package:tivra_health/data/remote/web_service.dart';



class InviteUpdateBloc extends Bloc<
    InviteUpdateEvent,
    InviteUpdateState> {
  final InviteUpdateRepository repository =
      InviteUpdateRepository(
          sharedPrefs: SharedPrefs(), webservice: Webservice());

  InviteUpdateBloc()
      : super( const InviteUpdateState()) {
    on<InviteUpdateClickEvent>(
      (event, emit) async {
        emit(state.copyWith(
            status: InviteUpdateStatus.loading));
        try {
          var response =
              await repository.fetchInviteUpdate(event.mInviteUpdateListRequest);

          if (response is InviteUpdateResponse) {
              emit(state.copyWith(
                status: InviteUpdateStatus.success,
                mInviteUpdateResponse: response,
              ));

          } else if (response is WebResponseFailed) {
            emit(state.copyWith(
                status: InviteUpdateStatus.failed,
                webResponseFailed: response));
          }
        } catch (e) {
          emit(state.copyWith(
              status: InviteUpdateStatus.failed,
              webResponseFailed: WebResponseFailed(
                  statusMessage: "Unable to process your request right now")));
        }
      },
    );
  }
}
