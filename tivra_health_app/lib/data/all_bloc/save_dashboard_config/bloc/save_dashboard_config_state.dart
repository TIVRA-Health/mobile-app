import 'package:equatable/equatable.dart';
import 'package:tivra_health/data/all_bloc/save_dashboard_config/repo/save_dashboard_config_response.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';

enum SaveDashboardConfigStatus { loading, success, failed }

class SaveDashboardConfigState extends Equatable {
  const SaveDashboardConfigState(
      {this.status = SaveDashboardConfigStatus.loading,
        this.mSaveDashboardConfigResponse ,
        this.webResponseFailed});

  final SaveDashboardConfigStatus status;
  final SaveDashboardConfigResponse? mSaveDashboardConfigResponse;
  final WebResponseFailed? webResponseFailed;



  SaveDashboardConfigState copyWith({
    SaveDashboardConfigStatus? status,
    SaveDashboardConfigResponse? mSaveDashboardConfigResponse,
    WebResponseFailed? webResponseFailed
  }) {
    return SaveDashboardConfigState(
      status: status ?? this.status,
      mSaveDashboardConfigResponse:
      mSaveDashboardConfigResponse ?? this.mSaveDashboardConfigResponse,
      webResponseFailed:  webResponseFailed ?? this.webResponseFailed,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, MyTeamPreferenceResponse: $mSaveDashboardConfigResponse }''';
  }

  @override
  List<Object> get props => [
    status,
    mSaveDashboardConfigResponse??SaveDashboardConfigResponse(),
    webResponseFailed ?? WebResponseFailed()
  ];
}
