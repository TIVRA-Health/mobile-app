import 'package:equatable/equatable.dart';

abstract class NutritionFoodDetailsEvent extends Equatable{
  const NutritionFoodDetailsEvent();
}

class NutritionFoodDetailsClickEvent
    extends NutritionFoodDetailsEvent {

  final dynamic mNutritionFoodDetailsRequest;
  const NutritionFoodDetailsClickEvent({required this.mNutritionFoodDetailsRequest});

  @override
  List<Object> get props => [mNutritionFoodDetailsRequest];
}
