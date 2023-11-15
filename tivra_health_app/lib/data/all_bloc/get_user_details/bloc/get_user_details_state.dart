import 'package:equatable/equatable.dart';
import 'package:tivra_health/data/all_bloc/get_dashboard/repo/get_dashboard_details_response.dart';
import 'package:tivra_health/data/all_bloc/get_user_details/repo/get_user_details_response.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';

enum GetUserDetailsStatus { loading, success, failed }

class GetUserDetailsState extends Equatable {
  const GetUserDetailsState(
      {this.status = GetUserDetailsStatus.loading,
        this.mGetUserDetailsResponse ,
        this.webResponseFailed});

  final GetUserDetailsStatus status;
  final GetUserDetailsResponse? mGetUserDetailsResponse;
  final WebResponseFailed? webResponseFailed;



  GetUserDetailsState copyWith({
    GetUserDetailsStatus? status,
    GetUserDetailsResponse? mGetUserDetailsResponse,
    WebResponseFailed? webResponseFailed
  }) {
    return GetUserDetailsState(
      status: status ?? this.status,
      mGetUserDetailsResponse:
      mGetUserDetailsResponse ?? this.mGetUserDetailsResponse,
      webResponseFailed:  webResponseFailed ?? this.webResponseFailed,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, GetUserDetailsResponse: $mGetUserDetailsResponse }''';
  }

  @override
  List<Object> get props => [
    status,
    mGetUserDetailsResponse??GetUserDetailsResponse(),
    webResponseFailed ?? WebResponseFailed()
  ];
}
