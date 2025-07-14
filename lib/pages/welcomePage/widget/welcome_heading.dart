import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sampark_app/config/images.dart';
import 'package:sampark_app/config/strings.dart';

class WelcomeHeading extends StatelessWidget {
  const WelcomeHeading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [SvgPicture.asset(AssetsImage.appIconSVG)],
        ),
        SizedBox(height: 20,),
        Text(
          AppString.appName,
          style: Theme.of(context).textTheme.headlineLarge,
        )
      ],
    );
    
  }
}