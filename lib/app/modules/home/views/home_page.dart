import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restest/app/constants/constants.dart';
import 'package:restest/app/models/user_model.dart';
import 'package:restest/app/modules/home/controllers/home_controller.dart';
import 'package:restest/app/utils/utils.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    SharedMethod.systemBarColor(
        AppStyles.colors.transparent, AppStyles.colors.white);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Home",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: <Widget>[
          Container(
            color: Colors.transparent,
            child: IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                SharedMethod.checkConnectionBeforeExecute(functions: controller.readListUsersC);
                
              },
            ),
          ),

          Container(
            color: Colors.transparent,
            padding: EdgeInsets.only(right: 4.0.wp),
            child: IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () {
                SharedMethod.checkConnectionBeforeExecute(functions: controller.logoutC);
               
              },
            ),
          ),
        ],
      ),
      body: SizedBox(
        child: Obx(
          () => (controller.listUsers.isEmpty)
              ? Container()
              : ListView.builder(
                  itemCount: controller.listUsers.length,
                  itemBuilder: (context, index) {
                    User user = controller.listUsers[index];

                    return GestureDetector(
                      onTap: () {
                        SharedMethod.checkConnectionBeforeExecute(
                            functions: () {
                              controller.readUserInfo(user);
                            });
                      },
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(user.avatar),
                        ),
                        title: Text('${user.firstName} ${user.lastName}'),
                        subtitle: Text(user.email),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            VerticalDivider(
                              thickness: .5.wp,
                            ),
                            GestureDetector(
                              onTap: () {
                                SharedMethod.checkConnectionBeforeExecute(
                                    functions: () {
                                      controller.updateUserC(user);
                                    });
                                
                              },
                              child: Container(
                                height: double.infinity,
                                  padding:
                                      EdgeInsets.only(left: 2.5.wp, right: 1.5.wp),
                                  color: Colors.transparent,
                                  child: const Icon(Icons.edit)),
                            ),
                            GestureDetector(
                              onTap: () {
                                if(!Get.isSnackbarOpen){
                                  SharedMethod.checkConnectionBeforeExecute(
                                      functions: () {
                                        controller.deleteUserC(index);
                                      });
                                }
                              
                              },
                              child: Container(
                                  height: double.infinity,
                                  padding:
                                  EdgeInsets.only(left: 1.5.wp, right: 2.5.wp),
                                  color: Colors.transparent,                                  child: const Icon(Icons.delete)),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(right: 3.0.wp, bottom: 6.0.wp),
        child: FloatingActionButton(
          onPressed: () {
            SharedMethod.checkConnectionBeforeExecute(functions: controller.createUserC);
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          tooltip: 'Add User',
          backgroundColor: AppStyles.colors.bgDark,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
