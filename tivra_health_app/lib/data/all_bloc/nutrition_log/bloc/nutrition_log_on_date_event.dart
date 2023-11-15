import 'package:equatable/equatable.dart';

abstract class NutritionLogOnDateEvent extends Equatable{
  const NutritionLogOnDateEvent();
}

class NutritionLogOnDateClickEvent
    extends NutritionLogOnDateEvent {

  final dynamic mStringRequest;
  const NutritionLogOnDateClickEvent({required this.mStringRequest});

  @override
  List<Object> get props => [mStringRequest];
}
