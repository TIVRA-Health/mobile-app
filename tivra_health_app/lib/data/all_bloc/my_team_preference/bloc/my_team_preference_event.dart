import 'package:equatable/equatable.dart';

abstract class MyTeamPreferenceEvent extends Equatable{
  const MyTeamPreferenceEvent();
}

class MyTeamPreferenceClickEvent
    extends MyTeamPreferenceEvent {

  final dynamic mStringRequest;
  const MyTeamPreferenceClickEvent({required this.mStringRequest});

  @override
  List<Object> get props => [mStringRequest];
}
