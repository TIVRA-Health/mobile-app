import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class NpiEvent extends Equatable {
  const NpiEvent();
}

class NpiClickEvent
    extends NpiEvent {
  final dynamic mNpiListRequest;

  const NpiClickEvent(
      {@required this.mNpiListRequest});

  @override
  List<Object> get props => [mNpiListRequest];
}
