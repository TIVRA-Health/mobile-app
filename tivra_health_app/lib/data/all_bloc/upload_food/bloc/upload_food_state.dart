import 'package:equatable/equatable.dart';
import 'package:tivra_health/data/all_bloc/upload_food/repo/upload_food_response.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';

enum UploadFoodStatus { loading, success, failed }

class UploadFoodState extends Equatable {
  const UploadFoodState(
      {this.status = UploadFoodStatus.loading,
        this.mUploadFoodResponse ,
        this.webResponseFailed});

  final UploadFoodStatus status;
  final UploadFoodResponse? mUploadFoodResponse;
  final WebResponseFailed? webResponseFailed;



  UploadFoodState copyWith({
    UploadFoodStatus? status,
    UploadFoodResponse? mUploadFoodResponse,
    WebResponseFailed? webResponseFailed
  }) {
    return UploadFoodState(
      status: status ?? this.status,
      mUploadFoodResponse:
      mUploadFoodResponse ?? this.mUploadFoodResponse,
      webResponseFailed:  webResponseFailed ?? this.webResponseFailed,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, NutririonFoodDetailsResponse: $mUploadFoodResponse }''';
  }

  @override
  List<Object> get props => [
    status,
    mUploadFoodResponse??UploadFoodResponse(),
    webResponseFailed ?? WebResponseFailed()
  ];
}
