import 'package:equatable/equatable.dart';
import 'package:tivra_health/data/all_bloc/my_team_preference/repo/my_team_preference_response.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';

enum MyTeamPreferenceStatus { loading, success, failed }

class MyTeamPreferenceState extends Equatable {
  const MyTeamPreferenceState(
      {this.status = MyTeamPreferenceStatus.loading,
        this.mMyTeamPreferenceResponse ,
        this.webResponseFailed});

  final MyTeamPreferenceStatus status;
  final MyTeamPreferenceResponse? mMyTeamPreferenceResponse;
  final WebResponseFailed? webResponseFailed;



  MyTeamPreferenceState copyWith({
    MyTeamPreferenceStatus? status,
    MyTeamPreferenceResponse? mMyTeamPreferenceResponse,
    WebResponseFailed? webResponseFailed
  }) {
    return MyTeamPreferenceState(
      status: status ?? this.status,
      mMyTeamPreferenceResponse:
      mMyTeamPreferenceResponse ?? this.mMyTeamPreferenceResponse,
      webResponseFailed:  webResponseFailed ?? this.webResponseFailed,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, MyTeamPreferenceResponse: $mMyTeamPreferenceResponse }''';
  }

  @override
  List<Object> get props => [
    status,
    mMyTeamPreferenceResponse??MyTeamPreferenceResponse(),
    webResponseFailed ?? WebResponseFailed()
  ];
}
