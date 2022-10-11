import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  //SHA1 15:9C:7D:25:7A:D1:4A:7D:8F:AD:ED:4C:B8:F9:A9:DD:37:DB:0A:09

  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static final StreamController<String> _messageStreamController =
      StreamController.broadcast();

  static Stream<String> get messagesStream => _messageStreamController.stream;

  //Personal Implementation
  static Future<void> _onBackgroundHandler(RemoteMessage message) async {
    print('On Background Handler');
    print(message.data);
    _messageStreamController.add(message.data['product'] ?? 'No data');
  }

  static Future<void> _onMessageHandler(RemoteMessage message) async {
    print('On Message Handler');
    print(message.data);
    _messageStreamController.add(message.data['product'] ?? 'No data');
  }

  static Future<void> _onMessageOpenApp(RemoteMessage message) async {
    print('Background Handler');
    print(message.data);
    _messageStreamController.add(message.data['product'] ?? 'No data');
  }

  static Future initializeApp() async {
    //Push notification
    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();
    print(token);

    //Handlers
    FirebaseMessaging.onBackgroundMessage(_onBackgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);

    //Local notification
  }

  static closeStreams() {
    _messageStreamController.close();
  }
}
