import 'package:equatable/equatable.dart';

abstract class MyDashboardPreferenceEvent extends Equatable{
  const MyDashboardPreferenceEvent();
}

class MyDashboardPreferenceClickEvent
    extends MyDashboardPreferenceEvent {

  final dynamic mStringRequest;
  const MyDashboardPreferenceClickEvent({required this.mStringRequest});

  @override
  List<Object> get props => [mStringRequest];
}
