import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class InviteEvent extends Equatable{
  const InviteEvent();
}

class InviteClickEvent
    extends InviteEvent {
  final dynamic mInviteListRequest;
  const InviteClickEvent({@required this.mInviteListRequest});

  @override
  List<Object> get props => [mInviteListRequest];
}
