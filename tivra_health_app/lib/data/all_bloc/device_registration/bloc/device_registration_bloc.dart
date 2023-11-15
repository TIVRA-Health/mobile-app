import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tivra_health/data/all_bloc/device_registration/bloc/device_registration_event.dart';
import 'package:tivra_health/data/all_bloc/device_registration/bloc/device_registration_state.dart';
import 'package:tivra_health/data/all_bloc/device_registration/repo/device_registration_repo.dart';
import 'package:tivra_health/data/all_bloc/device_registration/repo/device_registration_response.dart';
import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';
import 'package:tivra_health/data/remote/web_service.dart';

class DeviceRegistrationBloc extends Bloc<
    DeviceRegistrationEvent, DeviceRegistrationState> {
  final DeviceRegistrationRepository repository =
  DeviceRegistrationRepository(
          sharedPrefs: SharedPrefs(), webservice: Webservice());

  DeviceRegistrationBloc()
      : super(const DeviceRegistrationState()) {
    on<DeviceRegistrationClickEvent>(
      (event, emit) async {
        emit(
            state.copyWith(status: DeviceRegistrationStatus.loading));
        try {
          var response = await repository.mDeviceRegistration(
              event.mDeviceRegistrationListRequest);

          if (response is DeviceRegistrationResponse) {
            emit(state.copyWith(
              status: DeviceRegistrationStatus.success,
              mTivraHealthRegisterScreenResponse: response,
            ));
          } else if (response is WebResponseFailed) {
            emit(state.copyWith(
                status: DeviceRegistrationStatus.failed,
                webResponseFailed: response));
          }
        } catch (e) {
          emit(state.copyWith(
              status: DeviceRegistrationStatus.failed,
              webResponseFailed: WebResponseFailed(
                  statusMessage: "Unable to process your request right now")));
        }
      },
    );
  }
}
