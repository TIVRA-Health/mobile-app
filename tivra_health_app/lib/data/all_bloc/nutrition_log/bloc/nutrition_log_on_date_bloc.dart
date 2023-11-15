import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tivra_health/data/all_bloc/nutrition_log/repo/nutrition_log_on_date_repo.dart';
import 'package:tivra_health/data/all_bloc/nutrition_log/repo/nutrition_log_on_date_response.dart';
import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';
import 'package:tivra_health/data/remote/web_service.dart';
import 'nutrition_log_on_date_event.dart';
import 'nutrition_log_on_date_state.dart';

class NutritionLogOnDateBloc
    extends Bloc<NutritionLogOnDateEvent, NutritionLogOnDateState> {
  final NutritionLogOnDateRepository repository =
      NutritionLogOnDateRepository(
          sharedPrefs: SharedPrefs(), webservice: Webservice());

  NutritionLogOnDateBloc() : super(const NutritionLogOnDateState()) {
    on<NutritionLogOnDateClickEvent>(
      (event, emit) async {
        emit(state.copyWith(status: NutritionLogOnDateStatus.loading));
        try {
          var response =
              await repository.fetchNutritionLogOnDate(event.mStringRequest);

          if (response is NutritionLogOnDateResponse) {
            emit(state.copyWith(
              status: NutritionLogOnDateStatus.success,
              mNutritionLogOnDateResponse: response,
            ));
          } else if (response is WebResponseFailed) {
            emit(state.copyWith(
                status: NutritionLogOnDateStatus.failed,
                webResponseFailed: response));
          }
        } catch (e) {
          emit(state.copyWith(
              status: NutritionLogOnDateStatus.failed,
              webResponseFailed: WebResponseFailed(
                  statusMessage: "Unable to process your request right now")));
        }
      },
    );
  }
}
