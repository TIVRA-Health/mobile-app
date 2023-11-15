import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tivra_health/data/all_bloc/save_dashboard_preference/bloc/save_dashboard_event.dart';
import 'package:tivra_health/data/all_bloc/save_dashboard_preference/bloc/save_dashboard_state.dart';
import 'package:tivra_health/data/all_bloc/save_dashboard_preference/repo/save_dashboard_preference_repo.dart';
import 'package:tivra_health/data/all_bloc/save_dashboard_preference/repo/save_dashboard_response.dart';
import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';
import 'package:tivra_health/data/remote/web_service.dart';

class SaveDashboardPreferenceBloc
    extends Bloc<SaveDashboardPreferenceEvent, SaveDashboardPreferenceState> {
  final SaveDashboardPreferenceRepository repository =
      SaveDashboardPreferenceRepository(
          sharedPrefs: SharedPrefs(), webservice: Webservice());

  SaveDashboardPreferenceBloc() : super(const SaveDashboardPreferenceState()) {
    on<SaveDashboardPreferenceClickEvent>(
      (event, emit) async {
        emit(state.copyWith(status: SaveDashboardPreferenceStatus.loading));
        try {
          var response =
              await repository.fetchSaveDashboardPreference(event.mSaveDashboardPreferenceRequest);

          if (response is SaveDashboardPreferenceResponse) {
            emit(state.copyWith(
              status: SaveDashboardPreferenceStatus.success,
              mSaveDashboardPreferenceResponse: response,
            ));
          } else if (response is WebResponseFailed) {
            emit(state.copyWith(
                status: SaveDashboardPreferenceStatus.failed,
                webResponseFailed: response));
          }
        } catch (e) {
          emit(state.copyWith(
              status: SaveDashboardPreferenceStatus.failed,
              webResponseFailed: WebResponseFailed(
                  statusMessage: "Unable to process your request right now")));
        }
      },
    );
  }
}
