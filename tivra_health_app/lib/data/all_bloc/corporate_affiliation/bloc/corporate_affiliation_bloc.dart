import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tivra_health/data/all_bloc/corporate_affiliation/repo/corporate_affiliation_repo.dart';
import 'package:tivra_health/data/all_bloc/corporate_affiliation/repo/corporate_affiliation_response.dart';
import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';
import 'package:tivra_health/data/remote/web_service.dart';

import 'corporate_affiliation_event.dart';
import 'corporate_affiliation_state.dart';

class CorporateAffiliationBloc extends Bloc<
    CorporateAffiliationEvent,
    CorporateAffiliationState> {
  final CorporateAffiliationRepository repository =
      CorporateAffiliationRepository(
          sharedPrefs: SharedPrefs(), webservice: Webservice());

  CorporateAffiliationBloc()
      : super( const CorporateAffiliationState()) {
    on<CorporateAffiliationClickEvent>(
      (event, emit) async {
        emit(state.copyWith(
            status: CorporateAffiliationStatus.loading));
        try {
          var response =
              await repository.fetchCorporateAffiliation(event.mCorporateAffiliationListRequest);

          if (response is CorporateAffiliationResponse) {
              emit(state.copyWith(
                status: CorporateAffiliationStatus.success,
                mCorporateAffiliationResponse: response,
              ));

          } else if (response is WebResponseFailed) {
            emit(state.copyWith(
                status: CorporateAffiliationStatus.failed,
                webResponseFailed: response));
          }
        } catch (e) {
          emit(state.copyWith(
              status: CorporateAffiliationStatus.failed,
              webResponseFailed: WebResponseFailed(
                  statusMessage: "Unable to process your request right now")));
        }
      },
    );
  }
}
