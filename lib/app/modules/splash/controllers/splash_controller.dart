import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:restest/app/constants/constants.dart';
import 'package:restest/app/service/local/storage_service.dart';

class SplashController extends GetxController {
  static SplashController to = Get.find();
  RxBool isLogged = false.obs;

  @override
  void onInit() {
    super.onInit();
    openStartPage();
  }


  openStartPage() async {
    isLogged.value = await StorageServices().getIsLogged();
    Timer(3.3.seconds, ()
    async {
      if (kDebugMode) {
        print(isLogged.value);
      }

      if (isLogged.value == true) {
        Get.offAllNamed(AppRoutes.homeScreen);
      } else {
        Get.offAllNamed(AppRoutes.authenticationScreen);
      }
    
  }

  );
}}
