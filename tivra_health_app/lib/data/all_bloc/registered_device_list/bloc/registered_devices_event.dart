import 'package:equatable/equatable.dart';

abstract class RegisteredDevicesEvent extends Equatable{
  const RegisteredDevicesEvent();
}

class RegisteredDevicesClickEvent
    extends RegisteredDevicesEvent {

  final dynamic mStringRequest;
  const RegisteredDevicesClickEvent({required this.mStringRequest});

  @override
  List<Object> get props => [mStringRequest];
}
