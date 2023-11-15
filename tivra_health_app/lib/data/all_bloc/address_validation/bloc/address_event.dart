import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class AddressEvent extends Equatable {
  const AddressEvent();
}

class AddressClickEvent
    extends AddressEvent {
  final dynamic mAddressListRequest;

  const AddressClickEvent(
      {@required this.mAddressListRequest});

  @override
  List<Object> get props => [mAddressListRequest];
}
