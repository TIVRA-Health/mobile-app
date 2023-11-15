import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class TivraHealthHealthAndFitnessEvent extends Equatable {
  const TivraHealthHealthAndFitnessEvent();
}

class TivraHealthHealthAndFitnessClickEvent
    extends TivraHealthHealthAndFitnessEvent {
  final dynamic mTivraHealthHealthAndFitnessListRequest;

  const TivraHealthHealthAndFitnessClickEvent(
      {@required this.mTivraHealthHealthAndFitnessListRequest});

  @override
  List<Object> get props => [mTivraHealthHealthAndFitnessListRequest];
}
