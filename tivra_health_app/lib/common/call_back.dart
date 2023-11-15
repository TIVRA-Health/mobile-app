import 'package:flutter/material.dart';

class CallbackModel {
  final ValueChanged<dynamic> returnValueChanged;
  dynamic sValue ;
  List<dynamic> levyArrearsVOList = [];
  CallbackModel(this.returnValueChanged);
}