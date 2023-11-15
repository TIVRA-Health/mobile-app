import 'package:equatable/equatable.dart';

abstract class GetDashboardConfigEvent extends Equatable{
  const GetDashboardConfigEvent();
}

class GetDashboardConfigClickEvent
    extends GetDashboardConfigEvent {

  final dynamic mStringRequest;
  const GetDashboardConfigClickEvent({required this.mStringRequest});

  @override
  List<Object> get props => [mStringRequest];
}
