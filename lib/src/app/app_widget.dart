import 'package:flutter/material.dart';

import '../features/detail/detail.dart';
import '../features/home/home.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        "home": (context) => HomePage(),
        "detail": (context) => DetailPage(),
      },
    );
  }
}
