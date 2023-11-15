import 'package:equatable/equatable.dart';

abstract class SaveTeamPreferenceEvent extends Equatable{
  const SaveTeamPreferenceEvent();
}

class SaveTeamPreferenceClickEvent
    extends SaveTeamPreferenceEvent {

  final dynamic mSaveTeamPreferenceRequest;
  const SaveTeamPreferenceClickEvent({required this.mSaveTeamPreferenceRequest});

  @override
  List<Object> get props => [mSaveTeamPreferenceRequest];
}
