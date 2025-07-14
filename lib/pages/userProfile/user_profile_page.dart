import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sampark_app/controller/auth_controller.dart';
import 'package:sampark_app/controller/profile_controller.dart';
import 'package:sampark_app/pages/userProfile/widgets/user_info.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController authController=Get.put(AuthController());
    ProfileController profileController = Get.put(ProfileController());
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed('/updateProfilePage');
            },
            icon: Icon(Icons.edit),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            LoginUserInfo(),
            Spacer(),
            ElevatedButton(onPressed: () {
              authController.logoutUser();
            }, child: Text('Logout')),
          ],
        ),
      ),
    );
  }
}
