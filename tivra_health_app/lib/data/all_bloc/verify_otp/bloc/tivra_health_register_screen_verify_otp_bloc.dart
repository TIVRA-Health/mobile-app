import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tivra_health/data/all_bloc/verify_otp/bloc/tivra_health_register_screen_verify_otp_event.dart';
import 'package:tivra_health/data/all_bloc/verify_otp/bloc/tivra_health_register_screen_verify_otp_state.dart';
import 'package:tivra_health/data/all_bloc/verify_otp/repo/tivra_health_register_screen_verify_otp_repo.dart';
import 'package:tivra_health/data/all_bloc/verify_otp/repo/tivra_health_verify_otp_response.dart';
import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';
import 'package:tivra_health/data/remote/web_service.dart';

class TivraHealthRegisterScreenVerifyOTPBloc extends Bloc<
    TivraHealthRegisterScreenVerifyOTPEvent, TivraHealthRegisterScreenVerifyOTPState> {
  final TivraHealthRegisterScreenVerifyOTPRepository repository =
  TivraHealthRegisterScreenVerifyOTPRepository(
          sharedPrefs: SharedPrefs(), webservice: Webservice());

  TivraHealthRegisterScreenVerifyOTPBloc()
      : super(const TivraHealthRegisterScreenVerifyOTPState()) {
    on<TivraHealthRegisterScreenClickVerifyOTPEvent>(
      (event, emit) async {
        emit(
            state.copyWith(status: TivraHealthRegisterScreenVerifyOTPStatus.loading));
        try {
          var response = await repository.tivraHealthRegisterVerifyOTP(
              event.mTivraHealthRegisterScreenVerifyOTPListRequest);

          if (response is TivraHealthVerifyOTPResponse) {
            emit(state.copyWith(
              status: TivraHealthRegisterScreenVerifyOTPStatus.success,
              mTivraHealthRegisterScreenResponse: response,
            ));
          } else if (response is WebResponseFailed) {
            emit(state.copyWith(
                status: TivraHealthRegisterScreenVerifyOTPStatus.failed,
                webResponseFailed: response));
          }
        } catch (e) {
          emit(state.copyWith(
              status: TivraHealthRegisterScreenVerifyOTPStatus.failed,
              webResponseFailed: WebResponseFailed(
                  statusMessage: "Unable to process your request right now")));
        }
      },
    );
  }
}
