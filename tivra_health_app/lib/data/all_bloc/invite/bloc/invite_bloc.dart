import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tivra_health/data/all_bloc/invite/bloc/invite_event.dart';
import 'package:tivra_health/data/all_bloc/invite/bloc/invite_state.dart';
import 'package:tivra_health/data/all_bloc/invite/repo/invite_repo.dart';
import 'package:tivra_health/data/all_bloc/invite/repo/invite_response.dart';
import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';
import 'package:tivra_health/data/remote/web_service.dart';

class InviteBloc extends Bloc<InviteEvent, InviteState> {
  final InviteRepository repository =
      InviteRepository(sharedPrefs: SharedPrefs(), webservice: Webservice());

  InviteBloc() : super(const InviteState()) {
    on<InviteClickEvent>(
      (event, emit) async {
        emit(state.copyWith(status: InviteStatus.loading));
        try {
          var response = await repository.fetchInvite(event.mInviteListRequest);

          if (response is InviteResponse) {
            emit(state.copyWith(
              status: InviteStatus.success,
              mInviteResponse: response,
            ));
          } else if (response is WebResponseFailed) {
            emit(state.copyWith(
                status: InviteStatus.failed, webResponseFailed: response));
          }
        } catch (e) {
          emit(state.copyWith(
              status: InviteStatus.failed,
              webResponseFailed: WebResponseFailed(
                  statusMessage: "Unable to process your request right now")));
        }
      },
    );
  }
}
