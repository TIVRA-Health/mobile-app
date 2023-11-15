import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class TivraHealthDemographicProfileEvent extends Equatable {
  const TivraHealthDemographicProfileEvent();
}

class TivraHealthDemographicProfileClickEvent
    extends TivraHealthDemographicProfileEvent {
  final dynamic mTivraHealthDemographicProfileListRequest;

  const TivraHealthDemographicProfileClickEvent(
      {@required this.mTivraHealthDemographicProfileListRequest});

  @override
  List<Object> get props => [mTivraHealthDemographicProfileListRequest];
}
