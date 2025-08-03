import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sampark_app/config/strings.dart';
import 'package:sampark_app/controller/chat_controller.dart';
import 'package:sampark_app/controller/profile_controller.dart';
import 'package:sampark_app/model/user_model.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class AudioCallPage extends StatelessWidget {
  final UserModel target;
  const AudioCallPage({super.key, required this.target});

  @override
  Widget build(BuildContext context) {
    ProfileController profileController=Get.put(ProfileController());
    ChatController chatController=Get.put(ChatController());
    var callId=chatController.getRoomId(target.id!);
    return ZegoUIKitPrebuiltCall(
    appID: ZegoCloudConfig.appId, // your AppID,
    appSign: ZegoCloudConfig.appSign,
    userID: profileController.currentUser.value.id ?? 'root',
    userName: profileController.currentUser.value.name ?? 'root',
    callID: callId,
    config: ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall(),
  );
  }
}