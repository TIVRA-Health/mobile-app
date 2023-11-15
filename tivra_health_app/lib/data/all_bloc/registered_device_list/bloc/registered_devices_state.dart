import 'package:equatable/equatable.dart';
import 'package:tivra_health/data/all_bloc/registered_device_list/repo/registered_devices_response.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';

enum RegisteredDevicesStatus { loading, success, failed }

class RegisteredDevicesState extends Equatable {
  const RegisteredDevicesState(
      {this.status = RegisteredDevicesStatus.loading,
        this.mRegisteredDevicesResponse ,
        this.webResponseFailed});

  final RegisteredDevicesStatus status;
  final RegisteredDevicesResponse? mRegisteredDevicesResponse;
  final WebResponseFailed? webResponseFailed;



  RegisteredDevicesState copyWith({
    RegisteredDevicesStatus? status,
    RegisteredDevicesResponse? mRegisteredDevicesResponse,
    WebResponseFailed? webResponseFailed
  }) {
    return RegisteredDevicesState(
      status: status ?? this.status,
      mRegisteredDevicesResponse:
      mRegisteredDevicesResponse ?? this.mRegisteredDevicesResponse,
      webResponseFailed:  webResponseFailed ?? this.webResponseFailed,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, RegisteredDevicesResponse: $mRegisteredDevicesResponse }''';
  }

  @override
  List<Object> get props => [
    status,
    mRegisteredDevicesResponse??RegisteredDevicesResponse(),
    webResponseFailed ?? WebResponseFailed()
  ];
}
