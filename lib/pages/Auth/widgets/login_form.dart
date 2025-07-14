import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sampark_app/controller/auth_controller.dart';
import 'package:sampark_app/widgets/primary_button.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController email=TextEditingController();
    TextEditingController password=TextEditingController();
    AuthController authController=Get.put(AuthController());
    return Column(
      children: [
        SizedBox(height: 40),
        TextField(
          controller: email,
          decoration: InputDecoration(
            hintText: 'Email',
            prefixIcon: Icon(Icons.alternate_email_rounded),
          ),
        ),
        SizedBox(height: 30),
        TextField(
          controller: password,
          decoration: InputDecoration(
            hintText: 'Password',
            prefixIcon: Icon(Icons.password_outlined),
          ),
        ),
        SizedBox(height: 60),
        Obx(()=>
           authController.isLoading.value ? Center(child: CircularProgressIndicator())
          : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PrimaryButton(
                onTap: () {
                  authController.login(email.text, password.text);
                  // Get.offAllNamed('/homePage');
                },
                btnName: 'LOGIN',
                icon: Icons.lock_open_outlined,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
