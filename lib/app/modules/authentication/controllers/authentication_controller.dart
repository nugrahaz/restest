import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restest/app/constants/constants.dart';
import 'package:restest/app/repository/authentication_repository.dart';
import 'package:restest/app/service/local/storage_service.dart';
import 'package:restest/app/utils/utils.dart';

class AuthenticationController extends GetxController {
  static final AuthenticationController to =
      Get.find<AuthenticationController>();

  late TextEditingController emailTextEditingController;
  late TextEditingController passwordTextEditingController;
  late TextEditingController retypePasswordTextEditingController;

  late final AuthenticationRepository _authRepository;

  late FocusNode retypePasswordFocus;
  late FocusNode emailFocus;
  late FocusNode passwordFocus;

  RxBool isLoading = false.obs;
  RxBool passwordVisibility = true.obs;
  RxBool isLoginScreen = true.obs;
  late StorageServices _storageServices;

  @override
  void onInit() {
    _authRepository = AuthenticationRepository();
    _storageServices = StorageServices();

    retypePasswordTextEditingController = TextEditingController();
    emailTextEditingController = TextEditingController();
    passwordTextEditingController = TextEditingController();
    retypePasswordFocus = FocusNode();
    emailFocus = FocusNode();
    passwordFocus = FocusNode();
    super.onInit();
  }

  @override
  void onClose() {
    unFocusTextField();
    Get.delete<AuthenticationController>();
    super.onClose();
  }

  void authenticationC() {
    if (!Get.isSnackbarOpen) {
      unFocusTextField();

      if (isLoginScreen.value) {
        SharedMethod.checkConnectionBeforeExecute(functions: loginC);
      } else {
        SharedMethod.checkConnectionBeforeExecute(functions: registrationC);
      }
    }
  }

  void loginC() async {
    if (emailTextEditingController.text.isEmpty) {
      SharedMethod.showSnackBar(
          title: "Your email is still empty'",
          description: "Please fill in these fields");
    } else if (passwordTextEditingController.text.isEmpty) {
      SharedMethod.showSnackBar(
          title: "Your password is still empty",
          description: "Please fill in these fields");
    } else {
      if (!GetUtils.isEmail(emailTextEditingController.text)) {
        SharedMethod.showSnackBar(
            title: 'The email you entered is invalid',
            description: 'Please enter a valid email');
      } else {
        isLoading(true);

        final result = await _authRepository.loginS(
            emailTextEditingController.text.trim(),
            passwordTextEditingController.text.trim());
        result.fold(
          (exception) {
            SharedMethod.showSnackBar(
                title: "Login failed",
                description: "Please check email and password");
          },
          (value) {
            if (kDebugMode) {
              print('Login Success with token: ${value.toString()}');
            }

            /// Handle right
            clearTextField();
            _storageServices
                .setIsLogged(true)
                .then((_) => Get.offAllNamed(AppRoutes.homeScreen));
          },
        );
        Future.delayed(750.milliseconds, () {
          isLoading(false);
        });
      }
    }
  }

  void registrationC() async {
    if (emailTextEditingController.text.isEmpty) {
      SharedMethod.showSnackBar(
          title: "Your email still empty",
          description: "Please fill in these fields");
    } else if (passwordTextEditingController.text.isEmpty) {
      SharedMethod.showSnackBar(
          title: "Your password still empty",
          description: "Please fill in these fields");
    } else if (retypePasswordTextEditingController.text.isEmpty) {
      SharedMethod.showSnackBar(
          title: "Yout Retype password still empty",
          description: "Please fill in these fields");
    } else if (passwordTextEditingController.text !=
        retypePasswordTextEditingController.text) {
      SharedMethod.showSnackBar(
          title: "The password entered isn't same",
          description: "Please check the field again");
    } else {
      isLoading(true);

      final result = await _authRepository.registerS(
          emailTextEditingController.text.trim(),
          passwordTextEditingController.text.trim());
      result.fold(
        (exception) {
          SharedMethod.showSnackBar(
              title: "Registration failed",
              description: "Only defined users succeed registration");
        },
        (value) {
          if (kDebugMode) {
            print('Registration Success with token: ${value.toString()}');
          }

          clearTextField();
          _storageServices
              .setIsLogged(true)
              .then((_) => Get.offAllNamed(AppRoutes.homeScreen));
        },
      );
      Future.delayed(750.milliseconds, () {
        isLoading(false);
      });
    }
    update();
  }

  void switchScreen() {
    isLoginScreen.value = !isLoginScreen.value;
    unFocusTextField(); //memperbaiki auto focus pas di klik back
  }

  void unFocusTextField() {
    emailFocus.unfocus();
    retypePasswordFocus.unfocus();
    passwordFocus.unfocus();
  }

  void clearTextField() {
    emailTextEditingController.clear();
    retypePasswordTextEditingController.clear();
    passwordTextEditingController.clear();
  }

  void checkPasswordVisibility() =>
      passwordVisibility.value = !passwordVisibility.value;
}
