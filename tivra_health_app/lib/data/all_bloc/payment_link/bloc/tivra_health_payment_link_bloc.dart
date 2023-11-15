import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tivra_health/data/all_bloc/payment_link/bloc/tivra_health_payment_link_event.dart';
import 'package:tivra_health/data/all_bloc/payment_link/bloc/tivra_health_payment_link_state.dart';
import 'package:tivra_health/data/all_bloc/payment_link/repo/tivra_health_payment_link_repo.dart';
import 'package:tivra_health/data/all_bloc/payment_link/repo/tivra_health_payment_link_response.dart';
import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';
import 'package:tivra_health/data/remote/web_service.dart';

class TivraHealthPaymentLinkBloc extends Bloc<
    TivraHealthPaymentLinkEvent,
    TivraHealthPaymentLinkState> {
  final TivraHealthPaymentLinkRepository repository =
      TivraHealthPaymentLinkRepository(
          sharedPrefs: SharedPrefs(), webservice: Webservice());

  TivraHealthPaymentLinkBloc()
      : super( const TivraHealthPaymentLinkState()) {
    on<TivraHealthPaymentLinkClickEvent>(
      (event, emit) async {
        emit(state.copyWith(
            status: TivraHealthPaymentLinkStatus.loading));
        try {
          var response =
              await repository.fetchTivraHealthPaymentLink(event.mTivraHealthPaymentLinkListRequest);

          if (response is TivraHealthPaymentLinkResponse) {
              emit(state.copyWith(
                status: TivraHealthPaymentLinkStatus.success,
                mTivraHealthPaymentLinkResponse: response,
              ));

          } else if (response is WebResponseFailed) {
            emit(state.copyWith(
                status: TivraHealthPaymentLinkStatus.failed,
                webResponseFailed: response));
          }
        } catch (e) {
          emit(state.copyWith(
              status: TivraHealthPaymentLinkStatus.failed,
              webResponseFailed: WebResponseFailed(
                  statusMessage: "Unable to process your request right now")));
        }
      },
    );
  }
}
