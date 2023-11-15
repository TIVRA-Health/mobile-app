import 'package:equatable/equatable.dart';
import 'package:tivra_health/data/all_bloc/npi_validation/repo/npi_response.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';

enum NpiStatus { loading, success, failed }

class NpiState extends Equatable {
  const NpiState(
      {this.status = NpiStatus.loading,
        this.mNpiResponse ,
        this.webResponseFailed});

  final NpiStatus status;
  final NpiResponse? mNpiResponse;
  final WebResponseFailed? webResponseFailed;


  NpiState copyWith({
    NpiStatus? status,
    NpiResponse? mNpiResponse,
    WebResponseFailed? webResponseFailed
  }) {
    return NpiState(
      status: status ?? this.status,
      mNpiResponse:
      mNpiResponse ?? this.mNpiResponse,
      webResponseFailed: webResponseFailed ?? this.webResponseFailed,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, NpiResponse: $mNpiResponse }''';
  }

  @override
  List<Object> get props => [
    status,
    mNpiResponse??NpiResponse(),
    webResponseFailed ?? WebResponseFailed()
  ];
}
