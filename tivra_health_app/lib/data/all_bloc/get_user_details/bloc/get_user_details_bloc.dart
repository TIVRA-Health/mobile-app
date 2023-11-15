import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tivra_health/data/all_bloc/get_user_details/bloc/get_user_details_event.dart';
import 'package:tivra_health/data/all_bloc/get_user_details/bloc/get_user_details_state.dart';
import 'package:tivra_health/data/all_bloc/get_user_details/repo/get_user_details_repo.dart';
import 'package:tivra_health/data/all_bloc/get_user_details/repo/get_user_details_response.dart';
import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';
import 'package:tivra_health/data/remote/web_service.dart';

class GetUserDetailsBloc
    extends Bloc<GetUserDetailsEvent, GetUserDetailsState> {
  final GetUserDetailsRepository repository =
      GetUserDetailsRepository(
          sharedPrefs: SharedPrefs(), webservice: Webservice());

  GetUserDetailsBloc() : super(const GetUserDetailsState()) {
    on<GetUserDetailsClickEvent>(
      (event, emit) async {
        emit(state.copyWith(status: GetUserDetailsStatus.loading));
        try {
          var response =
              await repository.fetchGetUserDetails(event.mStringRequest);

          if (response is GetUserDetailsResponse) {
            emit(state.copyWith(
              status: GetUserDetailsStatus.success,
              mGetUserDetailsResponse: response,
            ));
          } else if (response is WebResponseFailed) {
            emit(state.copyWith(
                status: GetUserDetailsStatus.failed,
                webResponseFailed: response));
          }
        } catch (e) {
          emit(state.copyWith(
              status: GetUserDetailsStatus.failed,
              webResponseFailed: WebResponseFailed(
                  statusMessage: "Unable to process your request right now")));
        }
      },
    );
  }
}
