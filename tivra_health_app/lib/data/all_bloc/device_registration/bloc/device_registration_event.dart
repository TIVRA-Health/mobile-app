import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class DeviceRegistrationEvent extends Equatable {
  const DeviceRegistrationEvent();
}

class DeviceRegistrationClickEvent
    extends DeviceRegistrationEvent {
  final dynamic mDeviceRegistrationListRequest;

  const DeviceRegistrationClickEvent(
      {@required this.mDeviceRegistrationListRequest});

  @override
  List<Object> get props => [mDeviceRegistrationListRequest];
}
