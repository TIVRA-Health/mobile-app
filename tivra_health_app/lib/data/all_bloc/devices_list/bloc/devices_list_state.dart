import 'package:equatable/equatable.dart';
import 'package:tivra_health/data/all_bloc/devices_list/repo/devices_list_response.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';

enum DevicesListStatus { loading, success, failed }

class DevicesListState extends Equatable {
  const DevicesListState(
      {this.status = DevicesListStatus.loading,
        this.mDevicesListResponse ,
        this.webResponseFailed});

  final DevicesListStatus status;
  final DevicesListResponse? mDevicesListResponse;
  final WebResponseFailed? webResponseFailed;



  DevicesListState copyWith({
    DevicesListStatus? status,
    DevicesListResponse? mDevicesListResponse,
    WebResponseFailed? webResponseFailed
  }) {
    return DevicesListState(
      status: status ?? this.status,
      mDevicesListResponse:
      mDevicesListResponse ?? this.mDevicesListResponse,
      webResponseFailed:  webResponseFailed ?? this.webResponseFailed,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, DevicesListResponse: $mDevicesListResponse }''';
  }

  @override
  List<Object> get props => [
    status,
    mDevicesListResponse??DevicesListResponse(),
    webResponseFailed ?? WebResponseFailed()
  ];
}
