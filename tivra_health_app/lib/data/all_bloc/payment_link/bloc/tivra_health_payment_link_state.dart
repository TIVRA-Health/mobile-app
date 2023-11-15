import 'package:equatable/equatable.dart';
import 'package:tivra_health/data/all_bloc/payment_link/repo/tivra_health_payment_link_response.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';

enum TivraHealthPaymentLinkStatus { loading, success, failed }

class TivraHealthPaymentLinkState extends Equatable {
  const TivraHealthPaymentLinkState(
      {this.status = TivraHealthPaymentLinkStatus.loading,
        this.mTivraHealthPaymentLinkResponse ,
        this.webResponseFailed});

  final TivraHealthPaymentLinkStatus status;
  final TivraHealthPaymentLinkResponse? mTivraHealthPaymentLinkResponse;
  final WebResponseFailed? webResponseFailed;



  TivraHealthPaymentLinkState copyWith({
    TivraHealthPaymentLinkStatus? status,
    TivraHealthPaymentLinkResponse? mTivraHealthPaymentLinkResponse,
    WebResponseFailed? webResponseFailed
  }) {
    return TivraHealthPaymentLinkState(
      status: status ?? this.status,
      mTivraHealthPaymentLinkResponse:
      mTivraHealthPaymentLinkResponse ?? this.mTivraHealthPaymentLinkResponse,
      webResponseFailed: webResponseFailed ?? this.webResponseFailed,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, TivraHealthPaymentLinkResponse: $mTivraHealthPaymentLinkResponse }''';
  }

  @override
  List<Object> get props => [
    status,
    mTivraHealthPaymentLinkResponse??TivraHealthPaymentLinkResponse(),
    webResponseFailed ?? WebResponseFailed()
  ];
}
