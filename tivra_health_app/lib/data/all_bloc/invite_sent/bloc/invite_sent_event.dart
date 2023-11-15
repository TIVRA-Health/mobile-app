import 'package:equatable/equatable.dart';

abstract class InviteSentEvent extends Equatable{
  const InviteSentEvent();
}

class InviteSentClickEvent
    extends InviteSentEvent {

  final dynamic mStringRequest;
  const InviteSentClickEvent({required this.mStringRequest});

  @override
  List<Object> get props => [mStringRequest];
}
