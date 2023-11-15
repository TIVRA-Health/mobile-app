import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class InviteUpdateEvent extends Equatable{
  const InviteUpdateEvent();
}

class InviteUpdateClickEvent
    extends InviteUpdateEvent {
  final dynamic mInviteUpdateListRequest;
  const InviteUpdateClickEvent({@required this.mInviteUpdateListRequest});

  @override
  List<Object> get props => [mInviteUpdateListRequest];
}
