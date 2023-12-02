import 'package:get/get.dart';
import 'package:restest/app/modules/home/controllers/home_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(HomeController());
  }
}
