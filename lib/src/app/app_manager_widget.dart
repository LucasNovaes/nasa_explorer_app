import 'package:flutter/material.dart';
import 'package:nasa_explorer_app/src/features/astronomy_pictures/presentation/presenters/page_presenter.dart';

import '../core/injection/dependency_injection.dart';
import '../features/astronomy_pictures/presentation/presentation.dart'
    show HomePage, DetailPage;

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
