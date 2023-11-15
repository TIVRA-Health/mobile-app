import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class TivraHealthCreateAccountEvent extends Equatable {
  const TivraHealthCreateAccountEvent();
}

class TivraHealthCreateAccountClickEvent
    extends TivraHealthCreateAccountEvent {
  final dynamic mTivraHealthCreateAccountListRequest;

  const TivraHealthCreateAccountClickEvent(
      {@required this.mTivraHealthCreateAccountListRequest});

  @override
  List<Object> get props => [mTivraHealthCreateAccountListRequest];
}
