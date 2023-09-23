import 'package:flutter/material.dart';
import 'package:nasa_explorer_app/src/app/app_dependency_injection.dart';

import 'src/app/app_manager_widget.dart';

Future<void> main() async {
  AppDependencyInjection().setup();
  runApp(AppManagerWidget());
}
