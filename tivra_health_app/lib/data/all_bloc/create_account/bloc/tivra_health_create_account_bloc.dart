import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tivra_health/data/all_bloc/create_account/bloc/tivra_health_create_account_event.dart';
import 'package:tivra_health/data/all_bloc/create_account/bloc/tivra_health_create_account_state.dart';
import 'package:tivra_health/data/all_bloc/create_account/repo/tivra_health_create_account_repo.dart';
import 'package:tivra_health/data/all_bloc/create_account/repo/tivra_health_create_account_response.dart';
import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';
import 'package:tivra_health/data/remote/web_service.dart';

class TivraHealthCreateAccountBloc extends Bloc<
    TivraHealthCreateAccountEvent,
    TivraHealthCreateAccountState> {
  final TivraHealthCreateAccountRepository repository =
      TivraHealthCreateAccountRepository(
          sharedPrefs: SharedPrefs(), webservice: Webservice());

  TivraHealthCreateAccountBloc()
      : super( const TivraHealthCreateAccountState()) {
    on<TivraHealthCreateAccountClickEvent>(
      (event, emit) async {
        emit(state.copyWith(
            status: TivraHealthCreateAccountStatus.loading));
        try {
          var response =
              await repository.fetchTivraHealthCreateAccount(event.mTivraHealthCreateAccountListRequest);

          if (response is TivraHealthCreateAccountResponse) {
              emit(state.copyWith(
                status: TivraHealthCreateAccountStatus.success,
                mTivraHealthCreateAccountResponse: response,
              ));

          } else if (response is WebResponseFailed) {
            emit(state.copyWith(
                status: TivraHealthCreateAccountStatus.failed,
                webResponseFailed: response));
          }
        } catch (e) {
          emit(state.copyWith(
              status: TivraHealthCreateAccountStatus.failed,
              webResponseFailed: WebResponseFailed(
                  statusMessage: "Unable to process your request right now")));
        }
      },
    );
  }
}
