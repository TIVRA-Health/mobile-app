import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tivra_health/data/all_bloc/payment_methods/bloc/payment_methods_event.dart';
import 'package:tivra_health/data/all_bloc/payment_methods/bloc/payment_methods_state.dart';
import 'package:tivra_health/data/all_bloc/payment_methods/repo/payment_methods_repo.dart';
import 'package:tivra_health/data/all_bloc/payment_methods/repo/payment_methods_response.dart';
import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';
import 'package:tivra_health/data/remote/web_service.dart';

class PaymentMethodsBloc
    extends Bloc<PaymentMethodsEvent, PaymentMethodsState> {
  final PaymentMethodsRepository repository =
      PaymentMethodsRepository(
          sharedPrefs: SharedPrefs(), webservice: Webservice());

  PaymentMethodsBloc() : super(const PaymentMethodsState()) {
    on<PaymentMethodsClickEvent>(
      (event, emit) async {
        emit(state.copyWith(status: PaymentMethodsStatus.loading));
        try {
          var response =
              await repository.fetchPaymentMethods();

          if (response is PaymentMethodsResponse) {
            emit(state.copyWith(
              status: PaymentMethodsStatus.success,
              mPaymentMethodsResponse: response,
            ));
          } else if (response is WebResponseFailed) {
            emit(state.copyWith(
                status: PaymentMethodsStatus.failed,
                webResponseFailed: response));
          }
        } catch (e) {
          emit(state.copyWith(
              status: PaymentMethodsStatus.failed,
              webResponseFailed: WebResponseFailed(
                  statusMessage: "Unable to process your request right now")));
        }
      },
    );
  }
}
