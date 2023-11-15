import 'package:equatable/equatable.dart';

abstract class PaymentMethodsEvent extends Equatable{
  const PaymentMethodsEvent();
}

class PaymentMethodsClickEvent
    extends PaymentMethodsEvent {

  const PaymentMethodsClickEvent();

  @override
  List<Object> get props => [];
}
