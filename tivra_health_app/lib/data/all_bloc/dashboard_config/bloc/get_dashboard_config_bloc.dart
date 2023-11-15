import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tivra_health/data/all_bloc/dashboard_config/repo/get_dashboard_config_repo.dart';
import 'package:tivra_health/data/all_bloc/dashboard_config/repo/get_dashboard_config_response_new.dart';
import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';
import 'package:tivra_health/data/remote/web_service.dart';

import 'get_dashboard_config_event.dart';
import 'get_dashboard_config_state.dart';

class GetDashboardConfigBloc
    extends Bloc<GetDashboardConfigEvent, GetDashboardConfigState> {
  final GetDashboardConfigRepository repository =
      GetDashboardConfigRepository(
          sharedPrefs: SharedPrefs(), webservice: Webservice());

  GetDashboardConfigBloc() : super(const GetDashboardConfigState()) {
    on<GetDashboardConfigClickEvent>(
      (event, emit) async {
        emit(state.copyWith(status: GetDashboardConfigStatus.loading));
        try {
          var response =
              await repository.fetchGetDashboardConfig(event.mStringRequest);

          if (response is GetDashboardConfigResponseNew) {
            emit(state.copyWith(
              status: GetDashboardConfigStatus.success,
              mGetDashboardConfigResponse: response,
            ));
          } else if (response is WebResponseFailed) {
            emit(state.copyWith(
                status: GetDashboardConfigStatus.failed,
                webResponseFailed: response));
          }
        } catch (e) {
          emit(state.copyWith(
              status: GetDashboardConfigStatus.failed,
              webResponseFailed: WebResponseFailed(
                  statusMessage: "Unable to process your request right now")));
        }
      },
    );
  }
}
