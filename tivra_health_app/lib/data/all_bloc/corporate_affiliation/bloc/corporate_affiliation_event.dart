import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class CorporateAffiliationEvent extends Equatable {
  const CorporateAffiliationEvent();
}

class CorporateAffiliationClickEvent
    extends CorporateAffiliationEvent {
  final dynamic mCorporateAffiliationListRequest;

  const CorporateAffiliationClickEvent(
      {@required this.mCorporateAffiliationListRequest});

  @override
  List<Object> get props => [mCorporateAffiliationListRequest];
}
