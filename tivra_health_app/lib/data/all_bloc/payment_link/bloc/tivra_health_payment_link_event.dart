import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class TivraHealthPaymentLinkEvent extends Equatable{
  const TivraHealthPaymentLinkEvent();
}

class TivraHealthPaymentLinkClickEvent
    extends TivraHealthPaymentLinkEvent {
  final dynamic mTivraHealthPaymentLinkListRequest;
  const TivraHealthPaymentLinkClickEvent({@required this.mTivraHealthPaymentLinkListRequest});

  @override
  List<Object> get props => [mTivraHealthPaymentLinkListRequest];
}
