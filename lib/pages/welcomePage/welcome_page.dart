import 'package:flutter/material.dart';
import 'package:sampark_app/pages/welcomePage/widget/welcome_body.dart';
import 'package:sampark_app/pages/welcomePage/widget/welcome_footer.dart';
import 'package:sampark_app/pages/welcomePage/widget/welcome_heading.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              WelcomeHeading(),
              WelcomeBody(),
              WelcomeFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
