import 'package:equatable/equatable.dart';

abstract class GetUserDetailsEvent extends Equatable{
  const GetUserDetailsEvent();
}

class GetUserDetailsClickEvent
    extends GetUserDetailsEvent {

  final dynamic mStringRequest;
  const GetUserDetailsClickEvent({required this.mStringRequest});

  @override
  List<Object> get props => [mStringRequest];
}
