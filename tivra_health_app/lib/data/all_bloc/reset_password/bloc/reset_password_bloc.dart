import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tivra_health/data/all_bloc/reset_password/bloc/reset_password_event.dart';
import 'package:tivra_health/data/all_bloc/reset_password/bloc/reset_password_state.dart';
import 'package:tivra_health/data/all_bloc/reset_password/repo/reset_password_repo.dart';
import 'package:tivra_health/data/all_bloc/reset_password/repo/reset_password_response.dart';
import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';
import 'package:tivra_health/data/remote/web_service.dart';

class ResetPasswordBloc extends Bloc<
    ResetPasswordEvent, ResetPasswordState> {
  final ResetPasswordRepository repository =
      ResetPasswordRepository(
          sharedPrefs: SharedPrefs(), webservice: Webservice());

  ResetPasswordBloc()
      : super(const ResetPasswordState()) {
    on<ResetPasswordClickEvent>(
      (event, emit) async {
        emit(
            state.copyWith(status: ResetPasswordStatus.loading));
        try {
          var response = await repository.tivraHealthRegisterSendOTP(
              event.mResetPasswordListRequest);

          if (response is ResetPasswordResponse) {
            emit(state.copyWith(
              status: ResetPasswordStatus.success,
              mTivraHealthRegisterScreenResponse: response,
            ));
          } else if (response is WebResponseFailed) {
            emit(state.copyWith(
                status: ResetPasswordStatus.failed,
                webResponseFailed: response));
          }
        } catch (e) {
          emit(state.copyWith(
              status: ResetPasswordStatus.failed,
              webResponseFailed: WebResponseFailed(
                  statusMessage: "Unable to process your request right now")));
        }
      },
    );
  }
}
