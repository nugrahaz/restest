import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:restest/app/constants/constants.dart';
import 'package:restest/app/models/user_model.dart';
import 'package:restest/app/modules/authentication/views/authentication_page.dart';
import 'package:restest/app/modules/home/views/component/task_dialog.dart';
import 'package:restest/app/repository/authentication_repository.dart';
import 'package:restest/app/repository/user_repository.dart';
import 'package:restest/app/service/local/storage_service.dart';
import 'package:restest/app/utils/task_enum.dart';
import 'package:restest/app/utils/utils.dart';

class HomeController extends GetxController {
  late User newUser;
  RxList<User> listUsers = <User>[].obs;
  late final UserRepository userRepository;

  @override
  void onInit() {
    super.onInit();
    userRepository = UserRepository();
    if (listUsers.isEmpty) {
      readListUsersC();
    }
  }

  void logoutC() async {
    //xxxxx
    final AuthenticationRepository authService = AuthenticationRepository();
    await authService.logoutS().then((value) {
      if (value.isRight() == true) {
        StorageServices storageServices = StorageServices();
        storageServices
            .clearUserData()
            .then((value) => Get.offAll(const AuthenticationPage()));
        //fix color navbar
        SharedMethod.systemBarColor(
            AppStyles.colors.transparent, AppStyles.colors.bgDark);
      } else {
        SharedMethod.showSnackBar(
            title: "Operation Failed", description: "Failed to logout");
      }
    });
  }

  void createUserC() async {
    newUser = User(
        id: int.parse(DateTime.now().millisecondsSinceEpoch.toString()),
        email: "",
        firstName: "",
        lastName: "",
        avatar: "");

    final data = await Get.dialog(TaskDialog(task: Task.create, user: newUser));

    if (data != null) {
      //
      if (data['firstName'].toString().isEmpty ||
          data['lastName'].toString().isEmpty ||
          data['email'].toString().isEmpty) {
        SharedMethod.showSnackBar(
            title: "Your input invalid",
            description: "because there are empty fields");
      } else {
        newUser = User(
          firstName: data['firstName'],
          lastName: data['lastName'],
          email: data['email'],
          avatar: data['avatar'],
          id: data['id'],
        );

        final result = await userRepository.createUserS(newUser);
        result.fold(
          (exception) {
            SharedMethod.showSnackBar(
                title: "Create failed", description: exception.message);
          },
          (value) {
            if (kDebugMode) {
              print('Create Success');
            }
            listUsers.add(newUser);
          },
        );
      }
    }
  }

  Future<void> readListUsersC() async {
    var result = await userRepository.readListUserS();
    result.fold(
      (exception) {
        SharedMethod.showSnackBar(
            title: "Read failed", description: exception.message);
      },
      (value) {
        
        listUsers.value = value;
        listUsers.refresh();
      },
    );
  }

  void updateUserC(User user) async {
    final data = await Get.dialog(TaskDialog(task: Task.update, user: user));

    if (data != null) {
      final result = await userRepository.updateUserS(user);
      result.fold(
        (exception) {
          SharedMethod.showSnackBar(
              title: "Update Failed", description: exception.message);
        },
        (value) {
          if (kDebugMode) {
            print('Update Success');
          }
          newUser = User(
            firstName: data['firstName'],
            lastName: data['lastName'],
            email: data['email'],
            avatar: data['avatar'],
            id: data['id'],
          );

          int index = listUsers.indexWhere((obj) => obj.id == user.id);
          if (index != -1) {
            listUsers[index] = User(
                id: newUser.id,
                firstName: newUser.firstName,
                lastName: newUser.lastName,
                email: newUser.email,
                avatar: newUser.avatar);
          }
          listUsers.refresh();
        },
      );
    }
  }

  void deleteUserC(int index) async {
    final result = await userRepository.deleteUserS(index);
    result.fold(
      (exception) {
        SharedMethod.showSnackBar(
            title: "Delete Failed", description: exception.message);
      },
      (value) {
        if (kDebugMode) {
          print('Delete Success');
        }
        if (index >= 0 && index < listUsers.length) {
          listUsers.removeAt(index);
        }
        listUsers.refresh();

        SharedMethod.showSnackBar(
            title: "Operation Success", description: "Success delete user");
      },
    );
  }

  void readUserInfo(User user) {
    Get.dialog(TaskDialog(task: Task.read, user: user));
  }
}
