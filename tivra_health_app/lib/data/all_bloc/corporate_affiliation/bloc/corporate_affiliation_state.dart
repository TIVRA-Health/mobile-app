import 'package:equatable/equatable.dart';
import 'package:tivra_health/data/all_bloc/corporate_affiliation/repo/corporate_affiliation_response.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';

enum CorporateAffiliationStatus { loading, success, failed }

class CorporateAffiliationState extends Equatable {
  const CorporateAffiliationState(
      {this.status = CorporateAffiliationStatus.loading,
        this.mCorporateAffiliationResponse ,
        this.webResponseFailed});

  final CorporateAffiliationStatus status;
  final CorporateAffiliationResponse? mCorporateAffiliationResponse;
  final WebResponseFailed? webResponseFailed;


  CorporateAffiliationState copyWith({
    CorporateAffiliationStatus? status,
    CorporateAffiliationResponse? mCorporateAffiliationResponse,
    WebResponseFailed? webResponseFailed
  }) {
    return CorporateAffiliationState(
      status: status ?? this.status,
      mCorporateAffiliationResponse:
      mCorporateAffiliationResponse ?? this.mCorporateAffiliationResponse,
      webResponseFailed: webResponseFailed ?? this.webResponseFailed,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, CorporateAffiliationResponse: $mCorporateAffiliationResponse }''';
  }

  @override
  List<Object> get props => [
    status,
    mCorporateAffiliationResponse??CorporateAffiliationResponse(),
    webResponseFailed ?? WebResponseFailed()
  ];
}
