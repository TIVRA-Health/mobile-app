import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tivra_health/data/all_bloc/consultation/repo/consultation_repo.dart';
import 'package:tivra_health/data/all_bloc/consultation/repo/consultation_response.dart';
import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';
import 'package:tivra_health/data/remote/web_service.dart';

import 'consultation_event.dart';
import 'consultation_state.dart';

class ConsultationBloc extends Bloc<
    ConsultationEvent, ConsultationState> {
  final ConsultationRepository repository =
  ConsultationRepository(
          sharedPrefs: SharedPrefs(), webservice: Webservice());

  ConsultationBloc()
      : super(const ConsultationState()) {
    on<ConsultationClickEvent>(
      (event, emit) async {
        emit(
            state.copyWith(status: ConsultationStatus.loading));
        try {
          var response = await repository.mConsultation(
              event.mConsultationListRequest);

          if (response is ConsultationResponse) {
            emit(state.copyWith(
              status: ConsultationStatus.success,
              mTivraHealthRegisterScreenResponse: response,
            ));
          } else if (response is WebResponseFailed) {
            emit(state.copyWith(
                status: ConsultationStatus.failed,
                webResponseFailed: response));
          }
        } catch (e) {
          emit(state.copyWith(
              status: ConsultationStatus.failed,
              webResponseFailed: WebResponseFailed(
                  statusMessage: "Unable to process your request right now")));
        }
      },
    );
  }
}
