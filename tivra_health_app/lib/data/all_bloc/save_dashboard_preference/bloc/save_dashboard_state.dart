import 'package:equatable/equatable.dart';
import 'package:tivra_health/data/all_bloc/nutirition_food_details/repo/nutrition_food_details_response.dart';
import 'package:tivra_health/data/all_bloc/save_dashboard_preference/repo/save_dashboard_response.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';

enum SaveDashboardPreferenceStatus { loading, success, failed }

class SaveDashboardPreferenceState extends Equatable {
  const SaveDashboardPreferenceState(
      {this.status = SaveDashboardPreferenceStatus.loading,
        this.mSaveDashboardPreferenceResponse ,
        this.webResponseFailed});

  final SaveDashboardPreferenceStatus status;
  final SaveDashboardPreferenceResponse? mSaveDashboardPreferenceResponse;
  final WebResponseFailed? webResponseFailed;



  SaveDashboardPreferenceState copyWith({
    SaveDashboardPreferenceStatus? status,
    SaveDashboardPreferenceResponse? mSaveDashboardPreferenceResponse,
    WebResponseFailed? webResponseFailed
  }) {
    return SaveDashboardPreferenceState(
      status: status ?? this.status,
      mSaveDashboardPreferenceResponse:
      mSaveDashboardPreferenceResponse ?? this.mSaveDashboardPreferenceResponse,
      webResponseFailed:  webResponseFailed ?? this.webResponseFailed,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, NutririonFoodDetailsResponse: $mSaveDashboardPreferenceResponse }''';
  }

  @override
  List<Object> get props => [
    status,
    mSaveDashboardPreferenceResponse??SaveDashboardPreferenceResponse(),
    webResponseFailed ?? WebResponseFailed()
  ];
}
