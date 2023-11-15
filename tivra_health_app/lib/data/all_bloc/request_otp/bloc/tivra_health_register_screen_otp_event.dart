import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class TivraHealthRegisterScreenOTPEvent extends Equatable {
  const TivraHealthRegisterScreenOTPEvent();
}

class TivraHealthRegisterScreenClickOTPEvent
    extends TivraHealthRegisterScreenOTPEvent {
  final dynamic mTivraHealthRegisterScreenOTPListRequest;

  const TivraHealthRegisterScreenClickOTPEvent(
      {@required this.mTivraHealthRegisterScreenOTPListRequest});

  @override
  List<Object> get props => [mTivraHealthRegisterScreenOTPListRequest];
}
