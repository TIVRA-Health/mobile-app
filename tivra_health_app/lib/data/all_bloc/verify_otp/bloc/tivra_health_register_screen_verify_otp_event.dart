import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class TivraHealthRegisterScreenVerifyOTPEvent extends Equatable {
  const TivraHealthRegisterScreenVerifyOTPEvent();
}

class TivraHealthRegisterScreenClickVerifyOTPEvent
    extends TivraHealthRegisterScreenVerifyOTPEvent {
  final dynamic mTivraHealthRegisterScreenVerifyOTPListRequest;

  const TivraHealthRegisterScreenClickVerifyOTPEvent(
      {@required this.mTivraHealthRegisterScreenVerifyOTPListRequest});

  @override
  List<Object> get props => [mTivraHealthRegisterScreenVerifyOTPListRequest];
}
