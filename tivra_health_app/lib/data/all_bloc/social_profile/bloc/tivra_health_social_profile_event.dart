import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class TivraHealthSocialProfileEvent extends Equatable {
  const TivraHealthSocialProfileEvent();
}

class TivraHealthSocialProfileClickEvent
    extends TivraHealthSocialProfileEvent {
  final dynamic mTivraHealthRSocialProfileListRequest;

  const TivraHealthSocialProfileClickEvent(
      {@required this.mTivraHealthRSocialProfileListRequest});

  @override
  List<Object> get props => [mTivraHealthRSocialProfileListRequest];
}
