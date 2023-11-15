import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tivra_health/data/all_bloc/social_profile/bloc/tivra_health_social_profile_event.dart';
import 'package:tivra_health/data/all_bloc/social_profile/bloc/tivra_health_social_profile_state.dart';
import 'package:tivra_health/data/all_bloc/social_profile/repo/tivra_health_social_profile_repo.dart';
import 'package:tivra_health/data/all_bloc/social_profile/repo/tivra_health_social_profile_response.dart';
import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';
import 'package:tivra_health/data/remote/web_service.dart';

class TivraHealthSocialProfileBloc extends Bloc<
    TivraHealthSocialProfileEvent,
    TivraHealthSocialProfileState> {
  final TivraHealthSocialProfileRepository repository =
      TivraHealthSocialProfileRepository(
          sharedPrefs: SharedPrefs(), webservice: Webservice());

  TivraHealthSocialProfileBloc()
      : super( const TivraHealthSocialProfileState()) {
    on<TivraHealthSocialProfileClickEvent>(
      (event, emit) async {
        emit(state.copyWith(
            status: TivraHealthSocialProfileStatus.loading));
        try {
          var response =
              await repository.putSocialProfile(event.mTivraHealthRSocialProfileListRequest);

          if (response is TivraHealthSocialProfileResponse) {
              emit(state.copyWith(
                status: TivraHealthSocialProfileStatus.success,
                mTivraHealthSocialProfileResponse: response,
              ));

          } else if (response is WebResponseFailed) {
            emit(state.copyWith(
                status: TivraHealthSocialProfileStatus.failed,
                webResponseFailed: response));
          }
        } catch (e) {
          emit(state.copyWith(
              status: TivraHealthSocialProfileStatus.failed,
              webResponseFailed: WebResponseFailed(
                  statusMessage: "Unable to process your request right now")));
        }
      },
    );
  }
}
