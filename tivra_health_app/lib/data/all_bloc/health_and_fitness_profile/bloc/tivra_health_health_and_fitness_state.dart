import 'package:equatable/equatable.dart';
import 'package:tivra_health/data/all_bloc/health_and_fitness_profile/repo/tivra_health_health_and_fitness_profile_response.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';

enum TivraHealthHealthAndFitnessStatus { loading, success, failed }

class TivraHealthHealthAndFitnessState extends Equatable {
  const TivraHealthHealthAndFitnessState(
      {this.status = TivraHealthHealthAndFitnessStatus.loading,
        this.mTivraHealthHealthAndFitnessResponse ,
        this.webResponseFailed});

  final TivraHealthHealthAndFitnessStatus status;
  final TivraHealthHealthAndFitnessResponse? mTivraHealthHealthAndFitnessResponse;
  final WebResponseFailed? webResponseFailed;


  TivraHealthHealthAndFitnessState copyWith({
    TivraHealthHealthAndFitnessStatus? status,
    TivraHealthHealthAndFitnessResponse? mTivraHealthHealthAndFitnessResponse,
    WebResponseFailed? webResponseFailed
  }) {
    return TivraHealthHealthAndFitnessState(
      status: status ?? this.status,
      mTivraHealthHealthAndFitnessResponse:
      mTivraHealthHealthAndFitnessResponse ?? this.mTivraHealthHealthAndFitnessResponse,
      webResponseFailed: webResponseFailed ?? this.webResponseFailed,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, TivraHealthHealthAndFitnessResponse: $mTivraHealthHealthAndFitnessResponse }''';
  }

  @override
  List<Object> get props => [
    status,
    mTivraHealthHealthAndFitnessResponse??TivraHealthHealthAndFitnessResponse(),
    webResponseFailed ?? WebResponseFailed()
  ];
}
