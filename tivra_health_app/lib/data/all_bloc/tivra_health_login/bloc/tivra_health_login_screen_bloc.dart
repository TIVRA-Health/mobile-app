import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tivra_health/data/all_bloc/tivra_health_login/bloc/tivra_health_login_screen_event.dart';
import 'package:tivra_health/data/all_bloc/tivra_health_login/bloc/tivra_health_login_screen_state.dart';
import 'package:tivra_health/data/all_bloc/tivra_health_login/repo/tivra_health_login_screen_repo.dart';
import 'package:tivra_health/data/all_bloc/tivra_health_login/repo/tivra_health_login_screen_response.dart';
import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';
import 'package:tivra_health/data/remote/web_service.dart';



class TivraHealthLoginScreenBloc extends Bloc<
    TivraHealthLoginScreenEvent,
    TivraHealthLoginScreenState> {
  final TivraHealthLoginScreenRepository repository =
      TivraHealthLoginScreenRepository(
          sharedPrefs: SharedPrefs(), webservice: Webservice());

  TivraHealthLoginScreenBloc()
      : super( const TivraHealthLoginScreenState()) {
    on<TivraHealthLoginScreenClickEvent>(
      (event, emit) async {
        emit(state.copyWith(
            status: TivraHealthLoginScreenStatus.loading));
        try {
          var response =
              await repository.fetchTivraHealthLoginScreen(event.mTivraHealthLoginScreenListRequest);

          if (response is TivraHealthLoginScreenResponse) {
              emit(state.copyWith(
                status: TivraHealthLoginScreenStatus.success,
                mTivraHealthLoginScreenResponse: response,
              ));

          } else if (response is WebResponseFailed) {
            emit(state.copyWith(
                status: TivraHealthLoginScreenStatus.failed,
                webResponseFailed: response));
          }
        } catch (e) {
          emit(state.copyWith(
              status: TivraHealthLoginScreenStatus.failed,
              webResponseFailed: WebResponseFailed(
                  statusMessage: "Unable to process your request right now")));
        }
      },
    );
  }
}
