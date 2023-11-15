import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tivra_health/data/all_bloc/my_team_list/bloc/my_team_list_event.dart';
import 'package:tivra_health/data/all_bloc/my_team_list/bloc/my_team_list_state.dart';
import 'package:tivra_health/data/all_bloc/my_team_list/repo/my_team_list_repo.dart';
import 'package:tivra_health/data/all_bloc/my_team_list/repo/my_team_list_response.dart';
import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';
import 'package:tivra_health/data/remote/web_service.dart';

class MyTeamListBloc
    extends Bloc<MyTeamListEvent, MyTeamListState> {
  final MyTeamListRepository repository =
      MyTeamListRepository(
          sharedPrefs: SharedPrefs(), webservice: Webservice());

  MyTeamListBloc() : super(const MyTeamListState()) {
    on<MyTeamListClickEvent>(
      (event, emit) async {
        emit(state.copyWith(status: MyTeamListStatus.loading));
        try {
          var response =
              await repository.fetchMyTeamList(event.mStringRequest);

          if (response is MyTeamListResponse) {
            emit(state.copyWith(
              status: MyTeamListStatus.success,
              mMyTeamListResponse: response,
            ));
          } else if (response is WebResponseFailed) {
            emit(state.copyWith(
                status: MyTeamListStatus.failed,
                webResponseFailed: response));
          }
        } catch (e) {
          emit(state.copyWith(
              status: MyTeamListStatus.failed,
              webResponseFailed: WebResponseFailed(
                  statusMessage: "Unable to process your request right now")));
        }
      },
    );
  }
}
