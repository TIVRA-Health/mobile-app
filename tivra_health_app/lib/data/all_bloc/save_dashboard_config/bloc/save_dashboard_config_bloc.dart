import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tivra_health/data/all_bloc/save_dashboard_config/bloc/save_dashboard_config_event.dart';
import 'package:tivra_health/data/all_bloc/save_dashboard_config/bloc/save_dashboard_config_state.dart';
import 'package:tivra_health/data/all_bloc/save_dashboard_config/repo/save_dashboard_config_repo.dart';
import 'package:tivra_health/data/all_bloc/save_dashboard_config/repo/save_dashboard_config_response.dart';
import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';
import 'package:tivra_health/data/remote/web_service.dart';

class SaveDashboardConfigBloc
    extends Bloc<SaveDashboardConfigEvent, SaveDashboardConfigState> {
  final SaveDashboardConfigRepository repository =
      SaveDashboardConfigRepository(
          sharedPrefs: SharedPrefs(), webservice: Webservice());

  SaveDashboardConfigBloc() : super(const SaveDashboardConfigState()) {
    on<SaveDashboardConfigClickEvent>(
      (event, emit) async {
        emit(state.copyWith(status: SaveDashboardConfigStatus.loading));
        try {
          var response =
              await repository.fetchSaveDashboardConfig(event.mSaveDashboardConfigRequest);

          if (response is SaveDashboardConfigResponse) {
            emit(state.copyWith(
              status: SaveDashboardConfigStatus.success,
              mSaveDashboardConfigResponse: response,
            ));
          } else if (response is WebResponseFailed) {
            emit(state.copyWith(
                status: SaveDashboardConfigStatus.failed,
                webResponseFailed: response));
          }
        } catch (e) {
          emit(state.copyWith(
              status: SaveDashboardConfigStatus.failed,
              webResponseFailed: WebResponseFailed(
                  statusMessage: "Unable to process your request right now")));
        }
      },
    );
  }
}
