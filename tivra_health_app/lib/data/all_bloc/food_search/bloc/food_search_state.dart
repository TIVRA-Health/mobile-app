import 'package:equatable/equatable.dart';
import 'package:tivra_health/data/all_bloc/food_search/repo/food_search_response.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';

enum FoodSearchStatus { loading, success, failed }

class FoodSearchState extends Equatable {
  const FoodSearchState(
      {this.status = FoodSearchStatus.loading,
        this.mFoodSearchResponse ,
        this.webResponseFailed});

  final FoodSearchStatus status;
  final FoodSearchResponse? mFoodSearchResponse;
  final WebResponseFailed? webResponseFailed;



  FoodSearchState copyWith({
    FoodSearchStatus? status,
    FoodSearchResponse? mFoodSearchResponse,
    WebResponseFailed? webResponseFailed
  }) {
    return FoodSearchState(
      status: status ?? this.status,
      mFoodSearchResponse:
      mFoodSearchResponse ?? this.mFoodSearchResponse,
      webResponseFailed:  webResponseFailed ?? this.webResponseFailed,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, FoodSearchResponse: $mFoodSearchResponse }''';
  }

  @override
  List<Object> get props => [
    status,
    mFoodSearchResponse??FoodSearchResponse(),
    webResponseFailed ?? WebResponseFailed()
  ];
}
