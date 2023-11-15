import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tivra_health/data/all_bloc/request_otp/bloc/tivra_health_register_screen_otp_event.dart';
import 'package:tivra_health/data/all_bloc/request_otp/bloc/tivra_health_register_screen_otp_state.dart';
import 'package:tivra_health/data/all_bloc/request_otp/repo/tivra_health_register_screen_otp_response.dart';
import 'package:tivra_health/data/all_bloc/request_otp/repo/tivra_health_register_screen_repo.dart';
import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';
import 'package:tivra_health/data/remote/web_service.dart';

class TivraHealthRegisterScreenOTPBloc extends Bloc<
    TivraHealthRegisterScreenOTPEvent, TivraHealthRegisterScreenOTPState> {
  final TivraHealthRegisterScreenOTPRepository repository =
      TivraHealthRegisterScreenOTPRepository(
          sharedPrefs: SharedPrefs(), webservice: Webservice());

  TivraHealthRegisterScreenOTPBloc()
      : super(const TivraHealthRegisterScreenOTPState()) {
    on<TivraHealthRegisterScreenClickOTPEvent>(
      (event, emit) async {
        emit(
            state.copyWith(status: TivraHealthRegisterScreenOTPStatus.loading));
        try {
          var response = await repository.tivraHealthRegisterSendOTP(
              event.mTivraHealthRegisterScreenOTPListRequest);

          if (response is TivraHealthRegisterScreenOtpResponse) {
            emit(state.copyWith(
              status: TivraHealthRegisterScreenOTPStatus.success,
              mTivraHealthRegisterScreenResponse: response,
            ));
          } else if (response is WebResponseFailed) {
            emit(state.copyWith(
                status: TivraHealthRegisterScreenOTPStatus.failed,
                webResponseFailed: response));
          }
        } catch (e) {
          emit(state.copyWith(
              status: TivraHealthRegisterScreenOTPStatus.failed,
              webResponseFailed: WebResponseFailed(
                  statusMessage: "Unable to process your request right now")));
        }
      },
    );
  }
}
