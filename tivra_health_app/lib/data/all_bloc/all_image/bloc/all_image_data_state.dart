import 'package:equatable/equatable.dart';
import 'package:tivra_health/data/all_bloc/all_image/repo/all_image_data_response.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';

enum AllImageStatus { loading, success, failed }

class AllImageState extends Equatable {
  const AllImageState(
      {this.status = AllImageStatus.loading,
        this.mAllImageResponse ,
        this.webResponseFailed});

  final AllImageStatus status;
  final AllImageResponse? mAllImageResponse;
  final WebResponseFailed? webResponseFailed;



  AllImageState copyWith({
    AllImageStatus? status,
    AllImageResponse? mAllImageResponse,
    WebResponseFailed? webResponseFailed
  }) {
    return AllImageState(
      status: status ?? this.status,
      mAllImageResponse:
      mAllImageResponse ?? this.mAllImageResponse,
      webResponseFailed:  webResponseFailed ?? this.webResponseFailed,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, AllImageResponse: $mAllImageResponse }''';
  }

  @override
  List<Object> get props => [
    status,
    mAllImageResponse??AllImageResponse(),
    webResponseFailed ?? WebResponseFailed()
  ];
}
