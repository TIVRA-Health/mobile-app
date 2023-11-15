import 'package:equatable/equatable.dart';

abstract class UploadFoodEvent extends Equatable{
  const UploadFoodEvent();
}

class UploadFoodClickEvent
    extends UploadFoodEvent {

  final dynamic mUploadFoodRequest;
  const UploadFoodClickEvent({required this.mUploadFoodRequest});

  @override
  List<Object> get props => [mUploadFoodRequest];
}
