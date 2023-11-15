import 'package:equatable/equatable.dart';
import 'package:tivra_health/data/all_bloc/get_dashboard/repo/get_dashboard_details_response.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';

enum GetDashboardDetailsStatus { loading, success, failed }

class GetDashboardDetailsState extends Equatable {
  const GetDashboardDetailsState(
      {this.status = GetDashboardDetailsStatus.loading,
        this.mGetDashboardDetailsResponse ,
        this.webResponseFailed});

  final GetDashboardDetailsStatus status;
  final GetDashboardDetailsResponse? mGetDashboardDetailsResponse;
  final WebResponseFailed? webResponseFailed;



  GetDashboardDetailsState copyWith({
    GetDashboardDetailsStatus? status,
    GetDashboardDetailsResponse? mGetDashboardDetailsResponse,
    WebResponseFailed? webResponseFailed
  }) {
    return GetDashboardDetailsState(
      status: status ?? this.status,
      mGetDashboardDetailsResponse:
      mGetDashboardDetailsResponse ?? this.mGetDashboardDetailsResponse,
      webResponseFailed:  webResponseFailed ?? this.webResponseFailed,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, GetDashboardDetailsResponse: $mGetDashboardDetailsResponse }''';
  }

  @override
  List<Object> get props => [
    status,
    mGetDashboardDetailsResponse??GetDashboardDetailsResponse(),
    webResponseFailed ?? WebResponseFailed()
  ];
}
