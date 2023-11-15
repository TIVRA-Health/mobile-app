import 'package:equatable/equatable.dart';

abstract class FoodSearchEvent extends Equatable{
  const FoodSearchEvent();
}

class FoodSearchClickEvent
    extends FoodSearchEvent {

  final dynamic mStringRequest;
  const FoodSearchClickEvent({required this.mStringRequest});

  @override
  List<Object> get props => [mStringRequest];
}
