import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sampark_app/config/images.dart';
import 'package:sampark_app/controller/contactController.dart';
import 'package:sampark_app/pages/Chat/chat_page.dart';
import 'package:sampark_app/pages/homePage/widgets/chat_tile.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    Contactcontroller contactcontroller = Get.put(Contactcontroller());
    return RefreshIndicator(
      child: Obx(
        () => ListView(
          children: contactcontroller.chatRoomList
              .map(
                (e) => InkWell(
                  onTap: () {
                    Get.to(ChatPage(userModel: e.receiver!));
                  },
                  child: ChatTile(
                    name: e.receiver!.name ?? 'User Name',
                    imageUrl: e.receiver!.profileImage ?? AssetsImage.defaultProfileUrl,
                    lastTime: e.lastMessageTimeStamp ?? 'Last Time',
                    lastChat: e.lastMessage ?? 'Last Message',
                  ),
                ),
              )
              .toList(),
        ),
      ),
      onRefresh: (){
        return contactcontroller.getChatRoomList();
      },
    );
  }
}
