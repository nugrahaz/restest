part of '../constants.dart';

class AppRoutes {
  
  static const authenticationScreen = '/authenticationScreen';
  static const homeScreen = '/homeScreen';
  static const splashScreen = '/splashScreen';

  static final getPages = [

    GetPage(
      name: AppRoutes.homeScreen,
      page: () => const HomePage(),
      binding: HomeBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.authenticationScreen,
      page: () => const AuthenticationPage(),
      transition: Transition.noTransition,
      binding: AuthenticationBinding(),
    ),
    GetPage(
      name: AppRoutes.splashScreen,
      page: () => const SplashPage(),
      transition: Transition.noTransition,
      binding: SplashBinding(),
    ),
  ];
}
