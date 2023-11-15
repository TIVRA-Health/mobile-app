import 'package:equatable/equatable.dart';

abstract class InviteReceiveEvent extends Equatable{
  const InviteReceiveEvent();
}

class InviteReceiveClickEvent
    extends InviteReceiveEvent {

  final dynamic mStringRequest;
  const InviteReceiveClickEvent({required this.mStringRequest});

  @override
  List<Object> get props => [mStringRequest];
}
