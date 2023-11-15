import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class TivraHealthUserRoleEvent extends Equatable {
  const TivraHealthUserRoleEvent();
}

class TivraHealthUserRoleClickEvent
    extends TivraHealthUserRoleEvent {
  final dynamic mTivraHealthRUserRoleListRequest;

  const TivraHealthUserRoleClickEvent(
      {@required this.mTivraHealthRUserRoleListRequest});

  @override
  List<Object> get props => [mTivraHealthRUserRoleListRequest];
}
