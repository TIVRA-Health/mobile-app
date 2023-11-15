import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tivra_health/data/all_bloc/address_validation/repo/address_repo.dart';
import 'package:tivra_health/data/all_bloc/address_validation/repo/address_response.dart';
import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';
import 'package:tivra_health/data/remote/web_service.dart';

import 'address_event.dart';
import 'address_state.dart';

class AddressBloc extends Bloc<
    AddressEvent,
    AddressState> {
  final AddressRepository repository =
      AddressRepository(
          sharedPrefs: SharedPrefs(), webservice: Webservice());

  AddressBloc()
      : super( const AddressState()) {
    on<AddressClickEvent>(
      (event, emit) async {
        emit(state.copyWith(
            status: AddressStatus.loading));
        try {
          var response =
              await repository.fetchAddress(event.mAddressListRequest);

          if (response is AddressResponse) {
              emit(state.copyWith(
                status: AddressStatus.success,
                mAddressResponse: response,
              ));

          } else if (response is WebResponseFailed) {
            emit(state.copyWith(
                status: AddressStatus.failed,
                webResponseFailed: response));
          }
        } catch (e) {
          emit(state.copyWith(
              status: AddressStatus.failed,
              webResponseFailed: WebResponseFailed(
                  statusMessage: "Unable to process your request right now")));
        }
      },
    );
  }
}
