import 'package:equatable/equatable.dart';

abstract class AllImageEvent extends Equatable{
  const AllImageEvent();
}

class AllImageClickEvent
    extends AllImageEvent {

  final dynamic mStringRequest;
  const AllImageClickEvent({required this.mStringRequest});

  @override
  List<Object> get props => [mStringRequest];
}
