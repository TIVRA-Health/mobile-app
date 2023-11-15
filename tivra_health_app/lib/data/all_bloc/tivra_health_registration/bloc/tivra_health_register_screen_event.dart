import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class TivraHealthRegisterScreenEvent extends Equatable {
  const TivraHealthRegisterScreenEvent();
}

class TivraHealthRegisterScreenClickEvent
    extends TivraHealthRegisterScreenEvent {
  final dynamic mTivraHealthRegisterScreenListRequest;

  const TivraHealthRegisterScreenClickEvent(
      {@required this.mTivraHealthRegisterScreenListRequest});

  @override
  List<Object> get props => [mTivraHealthRegisterScreenListRequest];
}
