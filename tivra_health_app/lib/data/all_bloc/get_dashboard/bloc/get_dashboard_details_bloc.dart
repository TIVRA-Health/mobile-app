import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tivra_health/data/all_bloc/get_dashboard/bloc/get_dashboard_details_event.dart';
import 'package:tivra_health/data/all_bloc/get_dashboard/bloc/get_dashboard_details_state.dart';
import 'package:tivra_health/data/all_bloc/get_dashboard/repo/get_dashboard_details_repo.dart';
import 'package:tivra_health/data/all_bloc/get_dashboard/repo/get_dashboard_details_response.dart';
import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';
import 'package:tivra_health/data/remote/web_service.dart';

class GetDashboardDetailsBloc
    extends Bloc<GetDashboardDetailsEvent, GetDashboardDetailsState> {
  final GetDashboardDetailsRepository repository =
      GetDashboardDetailsRepository(
          sharedPrefs: SharedPrefs(), webservice: Webservice());

  GetDashboardDetailsBloc() : super(const GetDashboardDetailsState()) {
    on<GetDashboardDetailsClickEvent>(
      (event, emit) async {
        emit(state.copyWith(status: GetDashboardDetailsStatus.loading));
        try {
          var response =
              await repository.fetchGetDashboardDetails(event.mStringRequest);

          if (response is GetDashboardDetailsResponse) {
            emit(state.copyWith(
              status: GetDashboardDetailsStatus.success,
              mGetDashboardDetailsResponse: response,
            ));
          } else if (response is WebResponseFailed) {
            emit(state.copyWith(
                status: GetDashboardDetailsStatus.failed,
                webResponseFailed: response));
          }
        } catch (e) {
          emit(state.copyWith(
              status: GetDashboardDetailsStatus.failed,
              webResponseFailed: WebResponseFailed(
                  statusMessage: "Unable to process your request right now")));
        }
      },
    );
  }
}
