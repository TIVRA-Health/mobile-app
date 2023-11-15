import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tivra_health/data/all_bloc/demographic_profile/bloc/tivra_health_demographic_profile_event.dart';
import 'package:tivra_health/data/all_bloc/demographic_profile/bloc/tivra_health_demographic_profile_state.dart';
import 'package:tivra_health/data/all_bloc/demographic_profile/repo/tivra_health_demographic_profile_repo.dart';
import 'package:tivra_health/data/all_bloc/demographic_profile/repo/tivra_health_demographic_profile_response.dart';
import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';
import 'package:tivra_health/data/remote/web_service.dart';

class TivraHealthDemographicProfileBloc extends Bloc<
    TivraHealthDemographicProfileEvent,
    TivraHealthDemographicProfileState> {
  final TivraHealthDemographicProfileRepository repository =
      TivraHealthDemographicProfileRepository(
          sharedPrefs: SharedPrefs(), webservice: Webservice());

  TivraHealthDemographicProfileBloc()
      : super( const TivraHealthDemographicProfileState()) {
    on<TivraHealthDemographicProfileClickEvent>(
      (event, emit) async {
        emit(state.copyWith(
            status: TivraHealthDemographicProfileStatus.loading));
        try {
          var response =
              await repository.putDemographicProfile(event.mTivraHealthDemographicProfileListRequest);

          if (response is TivraHealthDemographicProfileResponse) {
              emit(state.copyWith(
                status: TivraHealthDemographicProfileStatus.success,
                mTivraHealthDemographicProfileResponse: response,
              ));

          } else if (response is WebResponseFailed) {
            emit(state.copyWith(
                status: TivraHealthDemographicProfileStatus.failed,
                webResponseFailed: response));
          }
        } catch (e) {
          emit(state.copyWith(
              status: TivraHealthDemographicProfileStatus.failed,
              webResponseFailed: WebResponseFailed(
                  statusMessage: "Unable to process your request right now")));
        }
      },
    );
  }
}
