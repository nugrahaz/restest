
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restest/app/constants/constants.dart';
import 'package:restest/app/modules/splash/bindings/splash_binding.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      enableLog: false,
      //
      color: AppStyles.colors.bgDark,
      theme: AppStyles.theme.defaultTheme,
      defaultTransition: Transition.fadeIn,
      //
      getPages: AppRoutes.getPages,
      initialRoute: AppRoutes.splashScreen,
      initialBinding: SplashBinding(),
      // initialBinding: SplashBinding(),
      //
    );
  }
}
