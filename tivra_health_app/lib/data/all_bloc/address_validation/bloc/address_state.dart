import 'package:equatable/equatable.dart';
import 'package:tivra_health/data/all_bloc/address_validation/repo/address_response.dart';
import 'package:tivra_health/data/remote/web_response_failed.dart';

enum AddressStatus { loading, success, failed }

class AddressState extends Equatable {
  const AddressState(
      {this.status = AddressStatus.loading,
        this.mAddressResponse ,
        this.webResponseFailed});

  final AddressStatus status;
  final AddressResponse? mAddressResponse;
  final WebResponseFailed? webResponseFailed;


  AddressState copyWith({
    AddressStatus? status,
    AddressResponse? mAddressResponse,
    WebResponseFailed? webResponseFailed
  }) {
    return AddressState(
      status: status ?? this.status,
      mAddressResponse:
      mAddressResponse ?? this.mAddressResponse,
      webResponseFailed: webResponseFailed ?? this.webResponseFailed,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, AddressResponse: $mAddressResponse }''';
  }

  @override
  List<Object> get props => [
    status,
    mAddressResponse??AddressResponse(),
    webResponseFailed ?? WebResponseFailed()
  ];
}
