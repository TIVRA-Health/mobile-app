import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tivra_health/data/all_bloc/health_and_fitness_profile/bloc/tivra_health_health_and_fitness_event.dart';
import 'package:tivra_health/data/all_bloc/health_and_fitness_profile/bloc/tivra_health_health_and_fitness_state.dart';
import 'package:tivra_health/data/all_bloc/health_and_fitness_profile/repo/tivra_health_health_and_fitness_profile_response.dart';
import 'package:tivra_health/data/all_bloc/health_and_fitness_profile/repo/tivra_health_health_and_fitness_repo.dart';
import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';
import 'package:tivra_health/data/remote/web_service.dart';

class TivraHealthHealthAndFitnessBloc extends Bloc<
    TivraHealthHealthAndFitnessEvent,
    TivraHealthHealthAndFitnessState> {
  final TivraHealthHealthAndFitnessRepository repository =
      TivraHealthHealthAndFitnessRepository(
          sharedPrefs: SharedPrefs(), webservice: Webservice());

  TivraHealthHealthAndFitnessBloc()
      : super( const TivraHealthHealthAndFitnessState()) {
    on<TivraHealthHealthAndFitnessClickEvent>(
      (event, emit) async {
        emit(state.copyWith(
            status: TivraHealthHealthAndFitnessStatus.loading));
        try {
          var response =
              await repository.fetchTivraHealthHealthAndFitness(event.mTivraHealthHealthAndFitnessListRequest);

          if (response is TivraHealthHealthAndFitnessResponse) {
              emit(state.copyWith(
                status: TivraHealthHealthAndFitnessStatus.success,
                mTivraHealthHealthAndFitnessResponse: response,
              ));

          } else if (response is WebResponseFailed) {
            emit(state.copyWith(
                status: TivraHealthHealthAndFitnessStatus.failed,
                webResponseFailed: response));
          }
        } catch (e) {
          emit(state.copyWith(
              status: TivraHealthHealthAndFitnessStatus.failed,
              webResponseFailed: WebResponseFailed(
                  statusMessage: "Unable to process your request right now")));
        }
      },
    );
  }
}
