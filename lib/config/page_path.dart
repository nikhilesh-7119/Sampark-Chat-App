import 'package:get/get.dart';
import 'package:sampark_app/pages/Auth/auth_page.dart';
import 'package:sampark_app/pages/Chat/chat_page.dart';
import 'package:sampark_app/pages/homePage/home_page.dart';
import 'package:sampark_app/pages/userProfile/user_profile_page.dart';
import 'package:sampark_app/pages/userProfile/user_update_profile.dart';

var pagePath = [
  GetPage(
    name: '/authPage',
    page: () => AuthPage(),
    transition: Transition.rightToLeftWithFade,
    transitionDuration: Duration(milliseconds: 500)
  ),
  GetPage(
    name: '/homePage',
    page: () => HomePage(),
    transition: Transition.rightToLeftWithFade,
    transitionDuration: Duration(milliseconds: 500)
  ),
  GetPage(
    name: '/chatPage',
    page: () => ChatPage(),
    transition: Transition.rightToLeftWithFade,
    transitionDuration: Duration(milliseconds: 500)
  ),
  // GetPage(
  //   name: '/profilePage',
  //   page: () => UserProfilePage(),
  //   transition: Transition.rightToLeftWithFade,
  //   transitionDuration: Duration(milliseconds: 500)
  // ),
  // GetPage(
  //   name: '/updateProfilePage',
  //   page: () => UserProfilePage(),
  //   transition: Transition.rightToLeftWithFade,
  //   transitionDuration: Duration(milliseconds: 500)
  // ),
];
