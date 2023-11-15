import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ResetPasswordEvent extends Equatable {
  const ResetPasswordEvent();
}

class ResetPasswordClickEvent
    extends ResetPasswordEvent {
  final dynamic mResetPasswordListRequest;

  const ResetPasswordClickEvent(
      {@required this.mResetPasswordListRequest});

  @override
  List<Object> get props => [mResetPasswordListRequest];
}
