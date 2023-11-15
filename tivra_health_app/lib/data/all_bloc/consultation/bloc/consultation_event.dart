import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ConsultationEvent extends Equatable {
  const ConsultationEvent();
}

class ConsultationClickEvent
    extends ConsultationEvent {
  final dynamic mConsultationListRequest;

  const ConsultationClickEvent(
      {@required this.mConsultationListRequest});

  @override
  List<Object> get props => [mConsultationListRequest];
}
