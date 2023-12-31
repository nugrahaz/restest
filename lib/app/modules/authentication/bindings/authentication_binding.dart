import 'package:get/get.dart';
import 'package:restest/app/modules/authentication/controllers/authentication_controller.dart';

class AuthenticationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthenticationController>(() => AuthenticationController());
  }
}
