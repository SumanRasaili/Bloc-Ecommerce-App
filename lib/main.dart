import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:oriflamenepal/config/theme/app_theme.dart';
import 'package:oriflamenepal/core/dio/dio_manager.dart';
import 'package:oriflamenepal/core/notification/local_notification.dart';
import 'package:oriflamenepal/core/service_locator/serv_locator.dart';
import 'package:oriflamenepal/features/products/bloc/cart/cart_bloc.dart';
import 'package:oriflamenepal/features/products/bloc/product_detail_bloc.dart';
import 'package:oriflamenepal/features/products/bloc/products_bloc.dart';
import 'package:oriflamenepal/features/products/presentation/screens/splash_screen.dart';
import 'package:oriflamenepal/features/products/repository/product_repository.dart';
import 'package:sizer/sizer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterLocalNotificationManager.instance.init();
  await dotenv.load(fileName: ".env");
  final servLocator = ServiceLocator();
  servLocator.init();

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) {
        return const MyApp();
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (p0, p1, ScreenType p2) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (context) => ProductsBloc(
                      ProductRepository(
                        dioManager: DioManager(),
                      ),
                    )),
            BlocProvider(
              create: (context) => ProductDetailBloc(
                productRepository: ProductRepository(
                  dioManager: DioManager(),
                ),
              ),
            ),
            BlocProvider(
              create: (context) => CartBloc(),
            )
          ],
          child: MaterialApp(
            title: 'Oriflame Nepal',
            theme: AppThemes.lightTheme,
            debugShowCheckedModeBanner: false,
            home: const SplashScreen(),
          ),
        );
      },
    );
  }
}
