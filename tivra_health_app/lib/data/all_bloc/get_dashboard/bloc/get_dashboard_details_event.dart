import 'package:equatable/equatable.dart';

abstract class GetDashboardDetailsEvent extends Equatable{
  const GetDashboardDetailsEvent();
}

class GetDashboardDetailsClickEvent
    extends GetDashboardDetailsEvent {

  final dynamic mStringRequest;
  const GetDashboardDetailsClickEvent({required this.mStringRequest});

  @override
  List<Object> get props => [mStringRequest];
}
