import 'dart:async';

import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:supercycle/app/app.dart';
import 'package:supercycle/config/properties.dart';

import 'config/flavors.dart';

Future<void> main() async {
  runZonedGuarded(() async {
    // 웹 환경에서 카카오 로그인을 정상적으로 완료하려면 runApp() 호출 전 아래 메서드 호출 필요
    WidgetsFlutterBinding.ensureInitialized();

    F.appFlavor = Flavor.dev;
    Properties(F.appFlavor);

    final kakao = Properties.instance.kakao;
    KakaoSdk.init(
      nativeAppKey: kakao.nativeAppKey,
      javaScriptAppKey: kakao.javaScriptAppKey,
      customScheme: kakao.customScheme,
    );

    FacebookAppEvents facebookAppEvents = FacebookAppEvents();
    await facebookAppEvents.setAdvertiserTracking(enabled: true);
    await facebookAppEvents.setAutoLogAppEventsEnabled(true);

    facebookAppEvents.logEvent(name: "runApp", parameters: {"app": "supercycle"});
    facebookAppEvents.setUserID("logan");
    facebookAppEvents.logEvent(name: "button_clicked", parameters: {"button_id": "login_button"});
    facebookAppEvents.setUserData(
      email: 'betheproud@gmail.com',
      firstName: 'betheproud',
      dateOfBirth: '2019-10-19',
      city: 'Seoul',
      country: 'South Korea',
    );
    facebookAppEvents.logAddToCart(id: "1", type: "goods", currency: "dollar", price: 59000);
    facebookAppEvents.logViewContent(id: "123", type: "goods");
    facebookAppEvents.logViewContent(id: "456", type: "banner");
    facebookAppEvents.logAdClick(adType: "adType");
    facebookAppEvents.logEvent(name: "REPLACE", parameters: {"from": "old", "to": "new"});

    if (!kDebugMode) {
      await SentryFlutter.init(
        (options) {
          options.dsn = "sentryDsn";
          options.attachStacktrace = true;
          options.environment = F.appFlavor?.name;
        },
        appRunner: () => runApp(const App()),
      );
    } else {
      runApp(const App());
    }
  }, (exception, stackTrace) async {
    Sentry.captureException(exception, stackTrace: stackTrace);
  });
}
