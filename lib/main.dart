import 'package:flutter/material.dart';

import 'package:notifications/routes/app_routes.dart';
import 'package:notifications/services/services.dart';

//d24cYyD4SraP7dl5DZvKfF:APA91bFsbKiOlGuZ3vGF8V1yFA6B_B3qIPQTrnQos3OsMLDtINGjhkbRlSJLDW_Mueq-Z1N6WdivVjhH_LXmQZENPtBTNjma0-2fcEBZd-VNGly1lg12TrJbqHVeoFvAraojQxgy6C7B

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //Key inside of the state
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();

    NotificationService.messagesStream.listen((message) {
      navigatorKey.currentState?.pushNamed('message', arguments: message);

      final snackBar = SnackBar(content: Text(message));
      messengerKey.currentState?.showSnackBar(snackBar);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notifications App',
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      scaffoldMessengerKey: messengerKey,
      initialRoute: AppRoutes.initialRoute,
      routes: AppRoutes.routes,
    );
  }
}
