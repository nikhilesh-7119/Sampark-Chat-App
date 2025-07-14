import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sampark_app/config/images.dart';
import 'package:sampark_app/pages/homePage/widgets/chat_tile.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        InkWell(
          onTap: (){
            Get.toNamed('/chatPage');
          },
          child: ChatTile(
            name: 'SSSA KUMARI',
            imageUrl: AssetsImage.girlPic,
            lastTime: '09:23 PM',
            lastChat: 'Bad me baat karta hun',
          ),
        ),
      ],
    );
  }
}
