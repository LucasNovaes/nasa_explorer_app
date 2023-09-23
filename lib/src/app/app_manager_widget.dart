import 'package:flutter/material.dart';
import 'package:nasa_explorer_app/src/features/astronomy_pictures/presentation/presenters/home_presenter.dart';

import '../core/injection/dependency_injection.dart';
import '../features/astronomy_pictures/presentation/presentation.dart'
    show HomePage, DetailPage;

class AppManagerWidget extends StatelessWidget {
  AppManagerWidget({Key? key}) : super(key: key);

  final homePresenter = DependencyInjection().get<HomePresenter>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        "home": (context) => HomePage(homePresenter: homePresenter),
        "detail": (context) => const DetailPage(),
      },
    );
  }
}
