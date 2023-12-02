import 'package:get/get.dart';
import 'package:restest/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:restest/app/modules/home/controllers/home_controller.dart';
import 'package:restest/app/modules/splash/controllers/splash_controller.dart';

class SplashBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<SplashController>(SplashController());
    Get.put<HomeController>(HomeController());
    Get.put<AuthenticationController>(AuthenticationController());
  }
}
