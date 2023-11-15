import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tivra_health/data/all_bloc/save_team_preference/bloc/save_team_event.dart';
import 'package:tivra_health/data/all_bloc/save_team_preference/bloc/save_team_state.dart';
import 'package:tivra_health/data/all_bloc/save_team_preference/repo/save_team_preference_repo.dart';
import 'package:tivra_health/data/all_bloc/save_team_preference/repo/save_team_response.dart';
import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';
import 'package:tivra_health/data/remote/web_service.dart';

class SaveTeamPreferenceBloc
    extends Bloc<SaveTeamPreferenceEvent, SaveTeamPreferenceState> {
  final SaveTeamPreferenceRepository repository =
      SaveTeamPreferenceRepository(
          sharedPrefs: SharedPrefs(), webservice: Webservice());

  SaveTeamPreferenceBloc() : super(const SaveTeamPreferenceState()) {
    on<SaveTeamPreferenceClickEvent>(
      (event, emit) async {
        emit(state.copyWith(status: SaveTeamPreferenceStatus.loading));
        try {
          var response =
              await repository.fetchSaveTeamPreference(event.mSaveTeamPreferenceRequest);

          if (response is SaveTeamPreferenceResponse) {
            emit(state.copyWith(
              status: SaveTeamPreferenceStatus.success,
              mSaveTeamPreferenceResponse: response,
            ));
          } else if (response is WebResponseFailed) {
            emit(state.copyWith(
                status: SaveTeamPreferenceStatus.failed,
                webResponseFailed: response));
          }
        } catch (e) {
          emit(state.copyWith(
              status: SaveTeamPreferenceStatus.failed,
              webResponseFailed: WebResponseFailed(
                  statusMessage: "Unable to process your request right now")));
        }
      },
    );
  }
}
