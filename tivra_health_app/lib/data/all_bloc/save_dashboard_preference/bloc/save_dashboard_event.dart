import 'package:equatable/equatable.dart';

abstract class SaveDashboardPreferenceEvent extends Equatable{
  const SaveDashboardPreferenceEvent();
}

class SaveDashboardPreferenceClickEvent
    extends SaveDashboardPreferenceEvent {

  final dynamic mSaveDashboardPreferenceRequest;
  const SaveDashboardPreferenceClickEvent({required this.mSaveDashboardPreferenceRequest});

  @override
  List<Object> get props => [mSaveDashboardPreferenceRequest];
}
