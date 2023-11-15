import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tivra_health/data/all_bloc/my_team_preference/repo/my_team_preference_repo.dart';
import 'package:tivra_health/data/all_bloc/my_team_preference/repo/my_team_preference_response.dart';
import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';
import 'package:tivra_health/data/remote/web_service.dart';

import 'my_team_preference_event.dart';
import 'my_team_preference_state.dart';

class MyTeamPreferenceBloc
    extends Bloc<MyTeamPreferenceEvent, MyTeamPreferenceState> {
  final MyTeamPreferenceRepository repository =
      MyTeamPreferenceRepository(
          sharedPrefs: SharedPrefs(), webservice: Webservice());

  MyTeamPreferenceBloc() : super(const MyTeamPreferenceState()) {
    on<MyTeamPreferenceClickEvent>(
      (event, emit) async {
        emit(state.copyWith(status: MyTeamPreferenceStatus.loading));
        try {
          var response =
              await repository.fetchMyTeamPreference(event.mStringRequest);

          if (response is MyTeamPreferenceResponse) {
            emit(state.copyWith(
              status: MyTeamPreferenceStatus.success,
              mMyTeamPreferenceResponse: response,
            ));
          } else if (response is WebResponseFailed) {
            emit(state.copyWith(
                status: MyTeamPreferenceStatus.failed,
                webResponseFailed: response));
          }
        } catch (e) {
          emit(state.copyWith(
              status: MyTeamPreferenceStatus.failed,
              webResponseFailed: WebResponseFailed(
                  statusMessage: "Unable to process your request right now")));
        }
      },
    );
  }
}
