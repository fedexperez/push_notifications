import 'package:flutter/material.dart';

import 'package:notifications/screens/screens.dart';

class AppRoutes {
  static const initialRoute = 'home';

  static final Map<String, Widget Function(BuildContext)> routes = {
    'home': (BuildContext context) => const HomeScreen(),
    'message': (BuildContext context) => const MessageScreen(),
  };
}
