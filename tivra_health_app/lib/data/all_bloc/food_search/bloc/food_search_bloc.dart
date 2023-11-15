import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tivra_health/data/all_bloc/food_search/repo/food_search_repo.dart';
import 'package:tivra_health/data/all_bloc/food_search/repo/food_search_response.dart';
import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';
import 'package:tivra_health/data/remote/web_service.dart';
import 'food_search_event.dart';
import 'food_search_state.dart';

class FoodSearchBloc
    extends Bloc<FoodSearchEvent, FoodSearchState> {
  final FoodSearchRepository repository =
      FoodSearchRepository(
          sharedPrefs: SharedPrefs(), webservice: Webservice());

  FoodSearchBloc() : super(const FoodSearchState()) {
    on<FoodSearchClickEvent>(
      (event, emit) async {
        emit(state.copyWith(status: FoodSearchStatus.loading));
        try {
          var response =
              await repository.fetchFoodSearch(event.mStringRequest);

          if (response is FoodSearchResponse) {
            emit(state.copyWith(
              status: FoodSearchStatus.success,
              mFoodSearchResponse: response,
            ));
          } else if (response is WebResponseFailed) {
            emit(state.copyWith(
                status: FoodSearchStatus.failed,
                webResponseFailed: response));
          }
        } catch (e) {
          emit(state.copyWith(
              status: FoodSearchStatus.failed,
              webResponseFailed: WebResponseFailed(
                  statusMessage: "Unable to process your request right now")));
        }
      },
    );
  }
}
