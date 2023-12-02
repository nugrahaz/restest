import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:restest/app/constants/constants.dart';
import 'package:restest/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:restest/app/utils/utils.dart';
import 'package:restest/app/widgets/widgets.dart';

class AuthenticationPage extends GetView<AuthenticationController> {
   const AuthenticationPage({Key? key}) : super(key: key);
   
  @override
  Widget build(BuildContext context) {
    SharedMethod.systemBarColor(AppStyles.colors.transparent, AppStyles.colors.bgDark);

    bool isKeyboardShowing = MediaQuery.of(context).viewInsets.vertical > 0;

    return PopScope(
      canPop: true,
      onPopInvoked: (_) {
        controller.unFocusTextField();
        SharedMethod.customDialog(
          colorStatusBar: AppStyles.colors.transparent,
          colorNavigationBar: AppStyles.colors.bgDark,
        );
        return;
      },
      child: Scaffold(
        backgroundColor: AppStyles.colors.bgDark,
        drawerScrimColor: AppStyles.colors.bgDark,
        body: Stack(
          children: [
            //gambar pojok kiri atas
            Positioned(
              top: -2.5.hp,
              left: -7.0.wp,
              child: Image.asset(
                AssetsPath.images.flowTop,
                color: AppStyles.colors.cyan.withOpacity(0.2),
                width: 35.0.wp,
              ),
            ),
            //gambar pojok kanan bawah
            Positioned(
              bottom: -2.0.hp,
              right: -7.0.wp,
              child: Image.asset(
                AssetsPath.images.flowBottom,
                width: 40.0.wp,
                color: AppStyles.colors.cyan.withOpacity(0.2),
              ),
            ),

            Obx(() => Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.0.wp),
                  child: Center(
                    child: SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: 3.0.hp),
                          AnimatedContainer(
                            duration: 200.milliseconds,
                            height: (controller.isLoginScreen.value)
                                ? 65.0.wp
                                : !isKeyboardShowing
                                    ? 55.0.wp
                                    : 35.0.wp,
                            child: Lottie.asset(
                              AssetsPath.lotties.key,
                              reverse: false,
                              fit: BoxFit.cover,
                            ),
                          ),
                          AnimatedContainer(
                              duration: 400.milliseconds,
                              height: isKeyboardShowing ? 1.0.hp : 2.5.hp),
                          CustomTextField(
                            controller:
                                controller.emailTextEditingController,
                            icon: Icons.email_outlined,
                            hintText: "Email",
                            colorIcon: AppStyles.colors.cyan,
                            currentNode: controller.emailFocus,
                            nextNode: controller.passwordFocus,
                            useSuffixIcon: false,
                            filteringTextInputFormatter: [
                              FilteringTextInputFormatter.deny(
                                  RegExp(r"\s\b|\b\s"))
                            ],
                          ),
                          CustomTextField(
                            controller:
                                controller.passwordTextEditingController,
                            hintText: "Password",
                            visibility:
                                controller.passwordVisibility.value,
                            currentNode: controller.passwordFocus,
                            icon: Icons.lock_rounded,
                            colorIcon: AppStyles.colors.cyan,
                            useSuffixIcon: true,
                            iconSuffix:
                                controller.passwordVisibility.value ==
                                        false
                                    ? Icons.remove_red_eye_outlined
                                    : Icons.remove_red_eye,
                            function: () {
                              controller.checkPasswordVisibility();
                            },
                            filteringTextInputFormatter: [
                              FilteringTextInputFormatter.deny(
                                  RegExp(r"\s\b|\b\s"))
                            ],
                            nextNode: null,
                          ),
                          AnimatedContainer(
                            duration: 200.milliseconds,
                            height:
                                (controller.isLoginScreen.value == false)
                                    ? 20.0.wp
                                    : 0,
                            child: (controller.isLoginScreen.value ==
                                    false)
                                ? CustomTextField(
                                    controller: controller
                                        .retypePasswordTextEditingController,
                                    hintText: "Retype Password",
                                    visibility: controller
                                        .passwordVisibility.value,
                                    currentNode: controller.retypePasswordFocus,
                                    icon: Icons.lock_clock_rounded,
                                    colorIcon: AppStyles.colors.cyan,
                                    useSuffixIcon: true,
                                    iconSuffix: controller
                                                .passwordVisibility.value ==
                                            false
                                        ? Icons.remove_red_eye_outlined
                                        : Icons.remove_red_eye,
                                    function: () {
                                      controller.checkPasswordVisibility();
                                    },
                                    filteringTextInputFormatter: [
                                      FilteringTextInputFormatter.deny(
                                          RegExp(r"\s\b|\b\s"))
                                    ],
                                    nextNode: null,
                                  )
                                : Container(),
                          ),

                          SizedBox(
                            height: 1.5.hp,
                          ),
                          //awalnya pake widget visibility
                          //cuman berhubung A13 menyisipkan
                          //soft animation di keyboard jadi janky
                          AnimatedContainer(
                            duration: 200.milliseconds,
                            height: isKeyboardShowing ? 0 : 27.0.wp,
                            child: Container(
                              color: AppStyles.colors.transparent,
                              child: SingleChildScrollView(
                                physics: const NeverScrollableScrollPhysics(),
                                // fix scroll
                                child: Column(
                                  children: [
                                    (controller.isLoading.value)
                                        ? SizedBox(
                                            height: 14.0.wp,
                                            child: Center(
                                              child: SpinKitWave(
                                                color: AppStyles.colors.white,
                                                size: 6.0.wp,
                                              ),
                                            ),
                                          )
                                        : CustomButton(
                                            onlyIcon: false,
                                            borderRadius: 12,
                                            height: 14.0.wp,
                                            color: AppStyles.colors.cyan,
                                            borderColor: AppStyles.colors.cyan,
                                            titleColor: AppStyles.colors.bgDark,
                                            title: (controller
                                                    .isLoginScreen.value)
                                                ? "Login"
                                                : "Registration",
                                            function: () async {
                                              controller.authenticationC();
                                            }),
                                    SizedBox(height: 4.0.wp),
                                    GestureDetector(
                                      onTap: () {
                                        controller.switchScreen();
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(3.0.wp),
                                        color: AppStyles.colors.transparent,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                                (controller
                                                        .isLoginScreen.value)
                                                    ? "Dont Have An Account? "
                                                    : "Already Have An Account? ",
                                                style: AppStyles
                                                    .textStyles.poppinsMedium
                                                    .copyWith(
                                                        color: AppStyles
                                                            .colors.white,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        letterSpacing: 0.3,
                                                        wordSpacing: 0.3,
                                                        fontSize: 3.4.wp)),
                                            Text(
                                              (controller
                                                      .isLoginScreen.value)
                                                  ? " Registration"
                                                  : " Login",
                                              style: AppStyles
                                                  .textStyles.poppinsMedium
                                                  .copyWith(
                                                      color:
                                                          AppStyles.colors.cyan,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      letterSpacing: 0.3,
                                                      wordSpacing: 0.3,
                                                      fontSize: 3.4.wp),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
