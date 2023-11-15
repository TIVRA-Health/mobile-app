import 'package:flutter/material.dart';

class ConsultationDetailsModel {
  final BuildContext mContext;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  final Function onRefreshPage;

 ConsultationDetailsModel(this.mContext,this.onRefreshPage);

}
