import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restest/app/constants/constants.dart';
import 'package:restest/app/models/user_model.dart';
import 'package:restest/app/utils/task_enum.dart';
import 'package:restest/app/utils/utils.dart';
import 'package:restest/app/widgets/input_field.dart';

class TaskDialog extends StatefulWidget {
  final Task task; //enum
  final User user;

  const TaskDialog({
    super.key,
    required this.task,
    required this.user,
  });

  @override
  TaskDialogState createState() => TaskDialogState();
}

class TaskDialogState extends State<TaskDialog> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController(
        text: (widget.task == Task.create) ? "" : widget.user.firstName);
    lastNameController = TextEditingController(
        text: (widget.task == Task.create) ? "" : widget.user.lastName);
    emailController = TextEditingController(
        text: (widget.task == Task.create) ? "" : widget.user.email);
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppStyles.colors.bgDark,
      title: Center(
        child: Text(
          (widget.task == Task.read)
              ? 'Read User'
              : (widget.task == Task.create)
                  ? "Create User"
                  : "Update User",
          style: TextStyle(
              color: AppStyles.colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 5.0.wp),
        ),
      ),
      content: SizedBox(
        width: 80.0.wp,
        height: null,
        child: ListView(
          shrinkWrap: true,
          children: [
            (widget.task != Task.read)
                ? const SizedBox()
                : Container(
                    padding: EdgeInsets.symmetric(vertical: 2.0.wp),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 21.0.wp,
                      child: CircleAvatar(
                        radius: 20.0.wp,
                        backgroundImage: NetworkImage(
                          widget.user.avatar,
                        ),
                      ),
                    ),
                  ),
            SizedBox(
              height: 4.0.wp,
            ),
            InputField(
                isReadOnly: (widget.task == Task.read) ? true : false,
                textEditingController: firstNameController,
                labelText: 'First Name'),
            SizedBox(
              height: 4.0.wp,
            ),
            InputField(
                isReadOnly: (widget.task == Task.read) ? true : false,
                textEditingController: lastNameController,
                labelText: 'Last Name'),
            SizedBox(
              height: 4.0.wp,
            ),
            InputField(
                isReadOnly: (widget.task == Task.read) ? true : false,
                textEditingController: emailController,
                labelText: 'Email'),
          
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: const Text('Close', style: TextStyle(color: Colors.white),),
        ),
        (widget.task == Task.read)
            ? const SizedBox()
            : TextButton(
                onPressed: () {
                  Get.back(result: {
                    'id': widget.user.id,
                    'firstName': firstNameController.text,
                    'lastName': lastNameController.text,
                    'email': emailController.text,
                    'avatar': (widget.task != Task.create)
                        ? widget.user.avatar
                        : 'https://reqres.in/img/faces/1-image.jpg', //bebas
                  });
                },
                child: const Text('Save', style: TextStyle(color: Colors.white)),
              ),
      ],
    );
  }
}
