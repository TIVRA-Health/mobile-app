import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tivra_health/data/all_bloc/all_image/bloc/all_image_data_event.dart';
import 'package:tivra_health/data/all_bloc/all_image/bloc/all_image_data_state.dart';
import 'package:tivra_health/data/all_bloc/all_image/repo/all_image_data_repo.dart';
import 'package:tivra_health/data/all_bloc/all_image/repo/all_image_data_response.dart';
import 'package:tivra_health/data/local/shared_prefs/shared_prefs.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';
import 'package:tivra_health/data/remote/web_service.dart';

class AllImageBloc
    extends Bloc<AllImageEvent, AllImageState> {
  final AllImageRepository repository =
      AllImageRepository(
          sharedPrefs: SharedPrefs(), webservice: Webservice());

  AllImageBloc() : super(const AllImageState()) {
    on<AllImageClickEvent>(
      (event, emit) async {
        emit(state.copyWith(status: AllImageStatus.loading));
        try {
          var response =
              await repository.fetchAllImage(event.mStringRequest);

          if (response is AllImageResponse) {
            emit(state.copyWith(
              status: AllImageStatus.success,
              mAllImageResponse: response,
            ));
          } else if (response is WebResponseFailed) {
            emit(state.copyWith(
                status: AllImageStatus.failed,
                webResponseFailed: response));
          }
        } catch (e) {
          emit(state.copyWith(
              status: AllImageStatus.failed,
              webResponseFailed: WebResponseFailed(
                  statusMessage: "Unable to process your request right now")));
        }
      },
    );
  }
}
