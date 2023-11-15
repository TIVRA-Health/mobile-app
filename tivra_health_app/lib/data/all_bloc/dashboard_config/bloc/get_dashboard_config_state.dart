import 'package:equatable/equatable.dart';
import 'package:tivra_health/data/all_bloc/dashboard_config/repo/get_dashboard_config_response_new.dart';
import 'package:tivra_health/data/all_bloc/devices_list/repo/devices_list_response.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';

enum GetDashboardConfigStatus { loading, success, failed }

class GetDashboardConfigState extends Equatable {
  const GetDashboardConfigState(
      {this.status = GetDashboardConfigStatus.loading,
        this.mGetDashboardConfigResponse ,
        this.webResponseFailed});

  final GetDashboardConfigStatus status;
  final GetDashboardConfigResponseNew? mGetDashboardConfigResponse;
  final WebResponseFailed? webResponseFailed;



  GetDashboardConfigState copyWith({
    GetDashboardConfigStatus? status,
    GetDashboardConfigResponseNew? mGetDashboardConfigResponse,
    WebResponseFailed? webResponseFailed
  }) {
    return GetDashboardConfigState(
      status: status ?? this.status,
      mGetDashboardConfigResponse:
      mGetDashboardConfigResponse ?? this.mGetDashboardConfigResponse,
      webResponseFailed:  webResponseFailed ?? this.webResponseFailed,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, GetDashboardConfigResponse: $mGetDashboardConfigResponse }''';
  }

  @override
  List<Object> get props => [
    status,
    mGetDashboardConfigResponse??GetDashboardConfigResponseNew(),
    webResponseFailed ?? WebResponseFailed()
  ];
}
