import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tivra_health/data/all_bloc/tivra_health_registration/bloc/tivra_health_register_screen_event.dart';
import 'package:tivra_health/data/all_bloc/tivra_health_registration/bloc/tivra_health_register_screen_state.dart';
import 'package:tivra_health/data/all_bloc/tivra_health_registration/repo/tivra_health_register_screen_repo.dart';
import 'package:tivra_health/data/all_bloc/tivra_health_registration/repo/tivra_health_register_screen_response.dart';
import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';
import 'package:tivra_health/data/remote/web_service.dart';



class TivraHealthRegisterScreenBloc extends Bloc<
    TivraHealthRegisterScreenEvent,
    TivraHealthRegisterScreenState> {
  final TivraHealthRegisterScreenRepository repository =
      TivraHealthRegisterScreenRepository(
          sharedPrefs: SharedPrefs(), webservice: Webservice());

  TivraHealthRegisterScreenBloc()
      : super( const TivraHealthRegisterScreenState()) {
    on<TivraHealthRegisterScreenClickEvent>(
      (event, emit) async {
        emit(state.copyWith(
            status: TivraHealthRegisterScreenStatus.loading));
        try {
          var response =
              await repository.fetchTivraHealthRegisterScreen(event.mTivraHealthRegisterScreenListRequest);

          if (response is TivraHealthRegisterScreenResponse) {
              emit(state.copyWith(
                status: TivraHealthRegisterScreenStatus.success,
                mTivraHealthRegisterScreenResponse: response,
              ));

          } else if (response is WebResponseFailed) {
            emit(state.copyWith(
                status: TivraHealthRegisterScreenStatus.failed,
                webResponseFailed: response));
          }
        } catch (e) {
          emit(state.copyWith(
              status: TivraHealthRegisterScreenStatus.failed,
              webResponseFailed: WebResponseFailed(
                  statusMessage: "Unable to process your request right now")));
        }
      },
    );
  }
}
