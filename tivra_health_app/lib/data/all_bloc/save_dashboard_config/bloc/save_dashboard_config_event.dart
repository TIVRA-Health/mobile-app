import 'package:equatable/equatable.dart';

abstract class SaveDashboardConfigEvent extends Equatable{
  const SaveDashboardConfigEvent();
}

class SaveDashboardConfigClickEvent
    extends SaveDashboardConfigEvent {

  final dynamic mSaveDashboardConfigRequest;
  const SaveDashboardConfigClickEvent({required this.mSaveDashboardConfigRequest});

  @override
  List<Object> get props => [mSaveDashboardConfigRequest];
}
