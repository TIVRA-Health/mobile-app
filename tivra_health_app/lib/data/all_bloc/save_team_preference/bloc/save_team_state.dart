import 'package:equatable/equatable.dart';
import 'package:tivra_health/data/all_bloc/save_team_preference/repo/save_team_response.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';

enum SaveTeamPreferenceStatus { loading, success, failed }

class SaveTeamPreferenceState extends Equatable {
  const SaveTeamPreferenceState(
      {this.status = SaveTeamPreferenceStatus.loading,
        this.mSaveTeamPreferenceResponse ,
        this.webResponseFailed});

  final SaveTeamPreferenceStatus status;
  final SaveTeamPreferenceResponse? mSaveTeamPreferenceResponse;
  final WebResponseFailed? webResponseFailed;



  SaveTeamPreferenceState copyWith({
    SaveTeamPreferenceStatus? status,
    SaveTeamPreferenceResponse? mSaveTeamPreferenceResponse,
    WebResponseFailed? webResponseFailed
  }) {
    return SaveTeamPreferenceState(
      status: status ?? this.status,
      mSaveTeamPreferenceResponse:
      mSaveTeamPreferenceResponse ?? this.mSaveTeamPreferenceResponse,
      webResponseFailed:  webResponseFailed ?? this.webResponseFailed,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, NutririonFoodDetailsResponse: $mSaveTeamPreferenceResponse }''';
  }

  @override
  List<Object> get props => [
    status,
    mSaveTeamPreferenceResponse??SaveTeamPreferenceResponse(),
    webResponseFailed ?? WebResponseFailed()
  ];
}
