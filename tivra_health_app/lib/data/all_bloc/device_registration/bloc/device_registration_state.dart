import 'package:equatable/equatable.dart';
import 'package:tivra_health/data/all_bloc/device_registration/repo/device_registration_response.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';

enum DeviceRegistrationStatus { loading, success, failed }

class DeviceRegistrationState extends Equatable {
  const DeviceRegistrationState(
      {this.status = DeviceRegistrationStatus.loading,
      this.mTivraHealthRegisterScreenResponse,
      this.webResponseFailed});

  final DeviceRegistrationStatus status;
  final DeviceRegistrationResponse? mTivraHealthRegisterScreenResponse;
  final WebResponseFailed? webResponseFailed;

  DeviceRegistrationState copyWith(
      {DeviceRegistrationStatus? status,
        DeviceRegistrationResponse? mTivraHealthRegisterScreenResponse,
      WebResponseFailed? webResponseFailed}) {
    return DeviceRegistrationState(
      status: status ?? this.status,
      mTivraHealthRegisterScreenResponse: mTivraHealthRegisterScreenResponse ??
          this.mTivraHealthRegisterScreenResponse,
      webResponseFailed: webResponseFailed ?? this.webResponseFailed,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, TivraHealthRegisterScreenResponse: $mTivraHealthRegisterScreenResponse }''';
  }

  @override
  List<Object> get props => [
        status,
        mTivraHealthRegisterScreenResponse ?? DeviceRegistrationResponse(),
        webResponseFailed ?? WebResponseFailed()
      ];
}
