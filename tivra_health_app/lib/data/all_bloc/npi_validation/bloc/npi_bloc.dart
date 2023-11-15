import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tivra_health/data/all_bloc/npi_validation/repo/npi_repo.dart';
import 'package:tivra_health/data/all_bloc/npi_validation/repo/npi_response.dart';
import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';
import 'package:tivra_health/data/remote/web_service.dart';

import 'npi_event.dart';
import 'npi_state.dart';

class NpiBloc extends Bloc<
    NpiEvent,
    NpiState> {
  final NpiRepository repository =
      NpiRepository(
          sharedPrefs: SharedPrefs(), webservice: Webservice());

  NpiBloc()
      : super( const NpiState()) {
    on<NpiClickEvent>(
      (event, emit) async {
        emit(state.copyWith(
            status: NpiStatus.loading));
        try {
          var response =
              await repository.fetchNpi(event.mNpiListRequest);

          if (response is NpiResponse) {
              emit(state.copyWith(
                status: NpiStatus.success,
                mNpiResponse: response,
              ));

          } else if (response is WebResponseFailed) {
            emit(state.copyWith(
                status: NpiStatus.failed,
                webResponseFailed: response));
          }
        } catch (e) {
          emit(state.copyWith(
              status: NpiStatus.failed,
              webResponseFailed: WebResponseFailed(
                  statusMessage: "Unable to process your request right now")));
        }
      },
    );
  }
}
