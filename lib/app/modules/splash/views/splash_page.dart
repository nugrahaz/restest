
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:restest/app/constants/constants.dart';
import 'package:restest/app/modules/splash/controllers/splash_controller.dart';
import 'package:restest/app/utils/utils.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    SharedMethod.systemBarColor(AppStyles.colors.transparent, AppStyles.colors.bgDark);

    return Scaffold(
      backgroundColor: AppStyles.colors.bgDark,
      body: Stack(
        children: [
          SizedBox(
            height: Get.height,
            width: Get.width,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.0.wp),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 15.0.wp,
                  ),
                  Container(
                    height: 50.0.wp,
                    padding: EdgeInsets.only(bottom: 4.0.wp),
                    child: Lottie.asset(
                      AssetsPath.lotties.key,
                      reverse: false,
                      repeat: false,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(
                    "Restest",
                    style: AppStyles.textStyles.poppinsBold.copyWith(
                        color: AppStyles.colors.white, fontWeight: FontWeight.bold, letterSpacing: 2, wordSpacing: 0.2, fontSize: 5.5.wp),
                  ),
                  SizedBox(
                    height: 30.0.wp,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

