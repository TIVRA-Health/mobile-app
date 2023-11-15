import 'package:equatable/equatable.dart';
import 'package:tivra_health/data/all_bloc/nutirition_food_details/repo/nutrition_food_details_response.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';

enum NutritionFoodDetailsStatus { loading, success, failed }

class NutritionFoodDetailsState extends Equatable {
  const NutritionFoodDetailsState(
      {this.status = NutritionFoodDetailsStatus.loading,
        this.mNutritionFoodDetailsResponse ,
        this.webResponseFailed});

  final NutritionFoodDetailsStatus status;
  final NutritionFoodDetailsResponse? mNutritionFoodDetailsResponse;
  final WebResponseFailed? webResponseFailed;



  NutritionFoodDetailsState copyWith({
    NutritionFoodDetailsStatus? status,
    NutritionFoodDetailsResponse? mNutritionFoodDetailsResponse,
    WebResponseFailed? webResponseFailed
  }) {
    return NutritionFoodDetailsState(
      status: status ?? this.status,
      mNutritionFoodDetailsResponse:
      mNutritionFoodDetailsResponse ?? this.mNutritionFoodDetailsResponse,
      webResponseFailed:  webResponseFailed ?? this.webResponseFailed,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, NutririonFoodDetailsResponse: $mNutritionFoodDetailsResponse }''';
  }

  @override
  List<Object> get props => [
    status,
    mNutritionFoodDetailsResponse??NutritionFoodDetailsResponse(),
    webResponseFailed ?? WebResponseFailed()
  ];
}
