import 'package:flutter/material.dart';

import '../features/astronomy_pictures/presentation/presentation.dart'
    show HomePage, DetailPage;

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        "home": (context) => const HomePage(),
        "detail": (context) => const DetailPage(),
      },
    );
  }
}
