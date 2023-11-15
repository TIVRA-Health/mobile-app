import 'package:equatable/equatable.dart';
import 'package:tivra_health/data/all_bloc/my_team_list/repo/my_team_list_response.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';

enum MyTeamListStatus { loading, success, failed }

class MyTeamListState extends Equatable {
  const MyTeamListState(
      {this.status = MyTeamListStatus.loading,
        this.mMyTeamListResponse ,
        this.webResponseFailed});

  final MyTeamListStatus status;
  final MyTeamListResponse? mMyTeamListResponse;
  final WebResponseFailed? webResponseFailed;



  MyTeamListState copyWith({
    MyTeamListStatus? status,
    MyTeamListResponse? mMyTeamListResponse,
    WebResponseFailed? webResponseFailed
  }) {
    return MyTeamListState(
      status: status ?? this.status,
      mMyTeamListResponse:
      mMyTeamListResponse ?? this.mMyTeamListResponse,
      webResponseFailed:  webResponseFailed ?? this.webResponseFailed,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, MyTeamListResponse: $mMyTeamListResponse }''';
  }

  @override
  List<Object> get props => [
    status,
    mMyTeamListResponse??MyTeamListResponse(),
    webResponseFailed ?? WebResponseFailed()
  ];
}
