import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tivra_health/data/remote/web_http_overrides.dart';
import 'package:tivra_health/modules/app/view/tivra_health_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = WebHttpOverrides();
  runApp(const TivraHealthApp());
}
