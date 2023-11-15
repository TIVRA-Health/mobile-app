import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tivra_health/data/all_bloc/user_role/bloc/tivra_health_user_role_event.dart';
import 'package:tivra_health/data/all_bloc/user_role/bloc/tivra_health_user_role_state.dart';
import 'package:tivra_health/data/all_bloc/user_role/repo/tivra_health_user_role_repo.dart';
import 'package:tivra_health/data/all_bloc/user_role/repo/tivra_health_user_role_response.dart';
import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';
import 'package:tivra_health/data/remote/web_service.dart';

class TivraHealthUserRoleBloc extends Bloc<
    TivraHealthUserRoleEvent,
    TivraHealthUserRoleState> {
  final TivraHealthUserRoleRepository repository =
      TivraHealthUserRoleRepository(
          sharedPrefs: SharedPrefs(), webservice: Webservice());

  TivraHealthUserRoleBloc()
      : super( const TivraHealthUserRoleState()) {
    on<TivraHealthUserRoleClickEvent>(
      (event, emit) async {
        emit(state.copyWith(
            status: TivraHealthUserRoleStatus.loading));
        try {
          var response =
              await repository.putUserRole(event.mTivraHealthRUserRoleListRequest);

          if (response is TivraHealthUserRoleResponse) {
              emit(state.copyWith(
                status: TivraHealthUserRoleStatus.success,
                mTivraHealthUserRoleResponse: response,
              ));

          } else if (response is WebResponseFailed) {
            emit(state.copyWith(
                status: TivraHealthUserRoleStatus.failed,
                webResponseFailed: response));
          }
        } catch (e) {
          emit(state.copyWith(
              status: TivraHealthUserRoleStatus.failed,
              webResponseFailed: WebResponseFailed(
                  statusMessage: "Unable to process your request right now")));
        }
      },
    );
  }
}
