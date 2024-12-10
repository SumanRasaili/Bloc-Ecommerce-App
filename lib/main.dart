import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:oriflamenepal/config/theme/app_theme.dart';
import 'package:oriflamenepal/core/service_locator/serv_locator.dart';
import 'package:oriflamenepal/presentation/screens/splash_screen.dart';
import 'package:sizer/sizer.dart';

Future<void> main() async {
  ServiceLocator();
  await dotenv.load(fileName: ".env");
  runApp(DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) {
        return const MyApp();
      }));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (p0, p1, ScreenType p2) {
        return MaterialApp(
          title: 'Oriflame Nepal',
          theme: AppThemes.lightTheme,
          debugShowCheckedModeBanner: false,
          home: const SplashScreen(),
        );
      },
    );
  }
}
