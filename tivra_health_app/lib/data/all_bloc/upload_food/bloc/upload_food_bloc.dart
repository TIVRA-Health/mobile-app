import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tivra_health/data/all_bloc/upload_food/bloc/upload_food_event.dart';
import 'package:tivra_health/data/all_bloc/upload_food/bloc/upload_food_state.dart';
import 'package:tivra_health/data/all_bloc/upload_food/repo/upload_food_repo.dart';
import 'package:tivra_health/data/all_bloc/upload_food/repo/upload_food_response.dart';
import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';
import 'package:tivra_health/data/remote/web_service.dart';

class UploadFoodBloc
    extends Bloc<UploadFoodEvent, UploadFoodState> {
  final UploadFoodRepository repository =
      UploadFoodRepository(
          sharedPrefs: SharedPrefs(), webservice: Webservice());

  UploadFoodBloc() : super(const UploadFoodState()) {
    on<UploadFoodClickEvent>(
      (event, emit) async {
        emit(state.copyWith(status: UploadFoodStatus.loading));
        try {
          var response =
              await repository.fetchUploadFood(event.mUploadFoodRequest);

          if (response is UploadFoodResponse) {
            emit(state.copyWith(
              status: UploadFoodStatus.success,
              mUploadFoodResponse: response,
            ));
          } else if (response is WebResponseFailed) {
            emit(state.copyWith(
                status: UploadFoodStatus.failed,
                webResponseFailed: response));
          }
        } catch (e) {
          emit(state.copyWith(
              status: UploadFoodStatus.failed,
              webResponseFailed: WebResponseFailed(
                  statusMessage: "Unable to process your request right now")));
        }
      },
    );
  }
}
