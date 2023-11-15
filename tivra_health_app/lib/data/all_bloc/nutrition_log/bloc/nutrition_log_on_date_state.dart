import 'package:equatable/equatable.dart';
import 'package:tivra_health/data/all_bloc/nutrition_log/repo/nutrition_log_on_date_response.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';

enum NutritionLogOnDateStatus { loading, success, failed }

class NutritionLogOnDateState extends Equatable {
  const NutritionLogOnDateState(
      {this.status = NutritionLogOnDateStatus.loading,
        this.mNutritionLogOnDateResponse ,
        this.webResponseFailed});

  final NutritionLogOnDateStatus status;
  final NutritionLogOnDateResponse? mNutritionLogOnDateResponse;
  final WebResponseFailed? webResponseFailed;



  NutritionLogOnDateState copyWith({
    NutritionLogOnDateStatus? status,
    NutritionLogOnDateResponse? mNutritionLogOnDateResponse,
    WebResponseFailed? webResponseFailed
  }) {
    return NutritionLogOnDateState(
      status: status ?? this.status,
      mNutritionLogOnDateResponse:
      mNutritionLogOnDateResponse ?? this.mNutritionLogOnDateResponse,
      webResponseFailed:  webResponseFailed ?? this.webResponseFailed,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, NutritionLogOnDateResponse: $mNutritionLogOnDateResponse }''';
  }

  @override
  List<Object> get props => [
    status,
    mNutritionLogOnDateResponse??NutritionLogOnDateResponse(),
    webResponseFailed ?? WebResponseFailed()
  ];
}
