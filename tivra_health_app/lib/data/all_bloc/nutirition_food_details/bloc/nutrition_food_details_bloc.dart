import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tivra_health/data/all_bloc/nutirition_food_details/repo/nutrition_food_details_repo.dart';
import 'package:tivra_health/data/all_bloc/nutirition_food_details/repo/nutrition_food_details_response.dart';
import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';
import 'package:tivra_health/data/remote/web_service.dart';

import 'nutrition_food_details_event.dart';
import 'nutrition_food_details_state.dart';

class NutritionFoodDetailsBloc
    extends Bloc<NutritionFoodDetailsEvent, NutritionFoodDetailsState> {
  final NutritionFoodDetailsRepository repository =
      NutritionFoodDetailsRepository(
          sharedPrefs: SharedPrefs(), webservice: Webservice());

  NutritionFoodDetailsBloc() : super(const NutritionFoodDetailsState()) {
    on<NutritionFoodDetailsClickEvent>(
      (event, emit) async {
        emit(state.copyWith(status: NutritionFoodDetailsStatus.loading));
        try {
          var response =
              await repository.fetchNutritionFoodDetails(event.mNutritionFoodDetailsRequest);

          if (response is NutritionFoodDetailsResponse) {
            emit(state.copyWith(
              status: NutritionFoodDetailsStatus.success,
              mNutritionFoodDetailsResponse: response,
            ));
          } else if (response is WebResponseFailed) {
            emit(state.copyWith(
                status: NutritionFoodDetailsStatus.failed,
                webResponseFailed: response));
          }
        } catch (e) {
          emit(state.copyWith(
              status: NutritionFoodDetailsStatus.failed,
              webResponseFailed: WebResponseFailed(
                  statusMessage: "Unable to process your request right now")));
        }
      },
    );
  }
}
