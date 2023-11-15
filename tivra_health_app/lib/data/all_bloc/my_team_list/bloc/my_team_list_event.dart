import 'package:equatable/equatable.dart';

abstract class MyTeamListEvent extends Equatable{
  const MyTeamListEvent();
}

class MyTeamListClickEvent
    extends MyTeamListEvent {

  final dynamic mStringRequest;
  const MyTeamListClickEvent({required this.mStringRequest});

  @override
  List<Object> get props => [mStringRequest];
}
