import 'package:equatable/equatable.dart';
import 'package:tivra_health/data/all_bloc/payment_methods/repo/payment_methods_response.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';

enum PaymentMethodsStatus { loading, success, failed }

class PaymentMethodsState extends Equatable {
  const PaymentMethodsState(
      {this.status = PaymentMethodsStatus.loading,
        this.mPaymentMethodsResponse ,
        this.webResponseFailed});

  final PaymentMethodsStatus status;
  final PaymentMethodsResponse? mPaymentMethodsResponse;
  final WebResponseFailed? webResponseFailed;



  PaymentMethodsState copyWith({
    PaymentMethodsStatus? status,
    PaymentMethodsResponse? mPaymentMethodsResponse,
    WebResponseFailed? webResponseFailed
  }) {
    return PaymentMethodsState(
      status: status ?? this.status,
      mPaymentMethodsResponse:
      mPaymentMethodsResponse ?? this.mPaymentMethodsResponse,
      webResponseFailed:  webResponseFailed ?? this.webResponseFailed,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, PaymentMethodsResponse: $mPaymentMethodsResponse }''';
  }

  @override
  List<Object> get props => [
    status,
    mPaymentMethodsResponse??PaymentMethodsResponse(),
    webResponseFailed ?? WebResponseFailed()
  ];
}
