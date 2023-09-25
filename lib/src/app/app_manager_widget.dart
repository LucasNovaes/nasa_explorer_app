import 'package:flutter/material.dart';
import '../core/core.dart' show DependencyInjection;
import '../features/astronomy_pictures/presentation/presentation.dart'
    show HomePage, DetailPage, PagePresenter;

class AppManagerWidget extends StatelessWidget {
  AppManagerWidget({Key? key}) : super(key: key);

  final pagePresenter = DependencyInjection().get<PagePresenter>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        "/": (context) => HomePage(presenter: pagePresenter),
        "/detail": (context) => DetailPage(presenter: pagePresenter),
      },
    );
  }
}
