import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_danilo/src/app_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb || Platform.isAndroid || Platform.isIOS) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
    FirebaseAnalyticsObserver(analytics: analytics);

    await FirebaseAnalytics.instance.logBeginCheckout(
        value: 10.0,
        currency: 'USD',
        items: [
          AnalyticsEventItem(
              itemName: 'Socks', itemId: 'xjw73ndnw', price: 10.0),
        ],
        coupon: '10PERCENTOFF');
  }

  runApp(const AppWidget());
}
