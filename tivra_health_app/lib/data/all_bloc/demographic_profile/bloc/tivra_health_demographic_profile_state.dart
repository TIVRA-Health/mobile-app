import 'package:equatable/equatable.dart';
import 'package:tivra_health/data/all_bloc/demographic_profile/repo/tivra_health_demographic_profile_response.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';

enum TivraHealthDemographicProfileStatus { loading, success, failed }

class TivraHealthDemographicProfileState extends Equatable {
  const TivraHealthDemographicProfileState(
      {this.status = TivraHealthDemographicProfileStatus.loading,
        this.mTivraHealthDemographicProfileResponse ,
        this.webResponseFailed});

  final TivraHealthDemographicProfileStatus status;
  final TivraHealthDemographicProfileResponse? mTivraHealthDemographicProfileResponse;
  final WebResponseFailed? webResponseFailed;


  TivraHealthDemographicProfileState copyWith({
    TivraHealthDemographicProfileStatus? status,
    TivraHealthDemographicProfileResponse? mTivraHealthDemographicProfileResponse,
    WebResponseFailed? webResponseFailed
  }) {
    return TivraHealthDemographicProfileState(
      status: status ?? this.status,
      mTivraHealthDemographicProfileResponse:
      mTivraHealthDemographicProfileResponse ?? this.mTivraHealthDemographicProfileResponse,
      webResponseFailed: webResponseFailed ?? this.webResponseFailed,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, TivraHealthRegisterScreenResponse: $mTivraHealthDemographicProfileResponse }''';
  }

  @override
  List<Object> get props => [
    status,
    mTivraHealthDemographicProfileResponse??TivraHealthDemographicProfileResponse(),
    webResponseFailed ?? WebResponseFailed()
  ];
}
