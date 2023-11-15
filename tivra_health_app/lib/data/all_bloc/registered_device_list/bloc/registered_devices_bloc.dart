import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tivra_health/data/all_bloc/registered_device_list/bloc/registered_devices_event.dart';
import 'package:tivra_health/data/all_bloc/registered_device_list/bloc/registered_devices_state.dart';
import 'package:tivra_health/data/all_bloc/registered_device_list/repo/registered_devices_repo.dart';
import 'package:tivra_health/data/all_bloc/registered_device_list/repo/registered_devices_response.dart';
import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';
import 'package:tivra_health/data/remote/web_service.dart';

class RegisteredDevicesBloc
    extends Bloc<RegisteredDevicesEvent, RegisteredDevicesState> {
  final RegisteredDevicesRepository repository =
      RegisteredDevicesRepository(
          sharedPrefs: SharedPrefs(), webservice: Webservice());

  RegisteredDevicesBloc() : super(const RegisteredDevicesState()) {
    on<RegisteredDevicesClickEvent>(
      (event, emit) async {
        emit(state.copyWith(status: RegisteredDevicesStatus.loading));
        try {
          var response =
              await repository.mRegisteredDevices(event.mStringRequest);

          if (response is RegisteredDevicesResponse) {
            emit(state.copyWith(
              status: RegisteredDevicesStatus.success,
              mRegisteredDevicesResponse: response,
            ));
          } else if (response is WebResponseFailed) {
            emit(state.copyWith(
                status: RegisteredDevicesStatus.failed,
                webResponseFailed: response));
          }
        } catch (e) {
          emit(state.copyWith(
              status: RegisteredDevicesStatus.failed,
              webResponseFailed: WebResponseFailed(
                  statusMessage: "Unable to process your request right now")));
        }
      },
    );
  }
}
