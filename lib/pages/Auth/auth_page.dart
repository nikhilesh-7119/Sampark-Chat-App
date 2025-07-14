import 'package:flutter/material.dart';
import 'package:sampark_app/pages/Auth/widgets/auth_page_body.dart';
import 'package:sampark_app/pages/welcomePage/widget/welcome_heading.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                WelcomeHeading(),
                SizedBox(height: 40),
                AuthPageBody(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
