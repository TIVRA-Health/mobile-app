import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tivra_health/data/all_bloc/my_dashboard_preference/repo/my_dashboard_preference_repo.dart';
import 'package:tivra_health/data/all_bloc/my_dashboard_preference/repo/my_dashboard_preference_response.dart';
import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';
import 'package:tivra_health/data/remote/web_service.dart';
import 'my_dashboard_preference_event.dart';
import 'my_dashboard_preference_state.dart';

class MyDashboardPreferenceBloc
    extends Bloc<MyDashboardPreferenceEvent, MyDashboardPreferenceState> {
  final MyDashboardPreferenceRepository repository =
      MyDashboardPreferenceRepository(
          sharedPrefs: SharedPrefs(), webservice: Webservice());

  MyDashboardPreferenceBloc() : super(const MyDashboardPreferenceState()) {
    on<MyDashboardPreferenceClickEvent>(
      (event, emit) async {
        emit(state.copyWith(status: MyDashboardPreferenceStatus.loading));
        try {
          var response =
              await repository.fetchMyDashboardPreference(event.mStringRequest);

          if (response is MyDashboardPreferenceResponse) {
            emit(state.copyWith(
              status: MyDashboardPreferenceStatus.success,
              mMyDashboardPreferenceResponse: response,
            ));
          } else if (response is WebResponseFailed) {
            emit(state.copyWith(
                status: MyDashboardPreferenceStatus.failed,
                webResponseFailed: response));
          }
        } catch (e) {
          emit(state.copyWith(
              status: MyDashboardPreferenceStatus.failed,
              webResponseFailed: WebResponseFailed(
                  statusMessage: "Unable to process your request right now")));
        }
      },
    );
  }
}
