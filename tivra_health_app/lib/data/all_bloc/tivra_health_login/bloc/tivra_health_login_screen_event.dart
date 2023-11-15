import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class TivraHealthLoginScreenEvent extends Equatable{
  const TivraHealthLoginScreenEvent();
}

class TivraHealthLoginScreenClickEvent
    extends TivraHealthLoginScreenEvent {
  final dynamic mTivraHealthLoginScreenListRequest;
  const TivraHealthLoginScreenClickEvent({@required this.mTivraHealthLoginScreenListRequest});

  @override
  List<Object> get props => [mTivraHealthLoginScreenListRequest];
}
