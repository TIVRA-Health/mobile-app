import 'package:equatable/equatable.dart';

abstract class DevicesListEvent extends Equatable{
  const DevicesListEvent();
}

class DevicesListClickEvent
    extends DevicesListEvent {

  final dynamic mStringRequest;
  const DevicesListClickEvent({required this.mStringRequest});

  @override
  List<Object> get props => [mStringRequest];
}
