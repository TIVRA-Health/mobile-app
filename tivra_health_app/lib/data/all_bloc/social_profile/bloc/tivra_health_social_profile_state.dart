import 'package:equatable/equatable.dart';
import 'package:tivra_health/data/all_bloc/social_profile/repo/tivra_health_social_profile_response.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';

enum TivraHealthSocialProfileStatus { loading, success, failed }

class TivraHealthSocialProfileState extends Equatable {
  const TivraHealthSocialProfileState(
      {this.status = TivraHealthSocialProfileStatus.loading,
        this.mTivraHealthSocialProfileResponse ,
        this.webResponseFailed});

  final TivraHealthSocialProfileStatus status;
  final TivraHealthSocialProfileResponse? mTivraHealthSocialProfileResponse;
  final WebResponseFailed? webResponseFailed;


  TivraHealthSocialProfileState copyWith({
    TivraHealthSocialProfileStatus? status,
    TivraHealthSocialProfileResponse? mTivraHealthSocialProfileResponse,
    WebResponseFailed? webResponseFailed
  }) {
    return TivraHealthSocialProfileState(
      status: status ?? this.status,
      mTivraHealthSocialProfileResponse:
      mTivraHealthSocialProfileResponse ?? this.mTivraHealthSocialProfileResponse,
      webResponseFailed: webResponseFailed ?? this.webResponseFailed,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, TivraHealthSocialProfileResponse: $mTivraHealthSocialProfileResponse }''';
  }

  @override
  List<Object> get props => [
    status,
    mTivraHealthSocialProfileResponse??TivraHealthSocialProfileResponse(),
    webResponseFailed ?? WebResponseFailed()
  ];
}
