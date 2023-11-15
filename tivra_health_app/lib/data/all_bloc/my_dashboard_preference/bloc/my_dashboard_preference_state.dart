import 'package:equatable/equatable.dart';
import 'package:tivra_health/data/all_bloc/my_dashboard_preference/repo/my_dashboard_preference_response.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';

enum MyDashboardPreferenceStatus { loading, success, failed }

class MyDashboardPreferenceState extends Equatable {
  const MyDashboardPreferenceState(
      {this.status = MyDashboardPreferenceStatus.loading,
        this.mMyDashboardPreferenceResponse ,
        this.webResponseFailed});

  final MyDashboardPreferenceStatus status;
  final MyDashboardPreferenceResponse? mMyDashboardPreferenceResponse;
  final WebResponseFailed? webResponseFailed;



  MyDashboardPreferenceState copyWith({
    MyDashboardPreferenceStatus? status,
    MyDashboardPreferenceResponse? mMyDashboardPreferenceResponse,
    WebResponseFailed? webResponseFailed
  }) {
    return MyDashboardPreferenceState(
      status: status ?? this.status,
      mMyDashboardPreferenceResponse:
      mMyDashboardPreferenceResponse ?? this.mMyDashboardPreferenceResponse,
      webResponseFailed:  webResponseFailed ?? this.webResponseFailed,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, MyDashboardPreferenceResponse: $mMyDashboardPreferenceResponse }''';
  }

  @override
  List<Object> get props => [
    status,
    mMyDashboardPreferenceResponse??MyDashboardPreferenceResponse(),
    webResponseFailed ?? WebResponseFailed()
  ];
}
