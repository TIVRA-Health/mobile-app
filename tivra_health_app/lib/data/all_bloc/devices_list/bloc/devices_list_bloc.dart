import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tivra_health/data/all_bloc/devices_list/bloc/devices_list_event.dart';
import 'package:tivra_health/data/all_bloc/devices_list/bloc/devices_list_state.dart';
import 'package:tivra_health/data/all_bloc/devices_list/repo/devices_list_repo.dart';
import 'package:tivra_health/data/all_bloc/devices_list/repo/devices_list_response.dart';
import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';
import 'package:tivra_health/data/remote/web_service.dart';

class DevicesListBloc
    extends Bloc<DevicesListEvent, DevicesListState> {
  final DevicesListRepository repository =
      DevicesListRepository(
          sharedPrefs: SharedPrefs(), webservice: Webservice());

  DevicesListBloc() : super(const DevicesListState()) {
    on<DevicesListClickEvent>(
      (event, emit) async {
        emit(state.copyWith(status: DevicesListStatus.loading));
        try {
          var response =
              await repository.fetchDevicesList(event.mStringRequest);

          if (response is DevicesListResponse) {
            emit(state.copyWith(
              status: DevicesListStatus.success,
              mDevicesListResponse: response,
            ));
          } else if (response is WebResponseFailed) {
            emit(state.copyWith(
                status: DevicesListStatus.failed,
                webResponseFailed: response));
          }
        } catch (e) {
          emit(state.copyWith(
              status: DevicesListStatus.failed,
              webResponseFailed: WebResponseFailed(
                  statusMessage: "Unable to process your request right now")));
        }
      },
    );
  }
}
