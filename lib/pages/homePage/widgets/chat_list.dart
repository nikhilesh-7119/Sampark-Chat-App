import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sampark_app/config/images.dart';
import 'package:sampark_app/controller/contactController.dart';
import 'package:sampark_app/controller/profile_controller.dart';
import 'package:sampark_app/model/user_model.dart';
import 'package:sampark_app/pages/Chat/chat_page.dart';
import 'package:sampark_app/pages/homePage/widgets/chat_tile.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    Contactcontroller contactcontroller = Get.put(Contactcontroller());
    ProfileController profileController = Get.put(ProfileController());
    return RefreshIndicator(
      child: Obx(
        () => ListView(
          children: contactcontroller.chatRoomList
              .map(
                (e)  {
                  UserModel send;
                  // UserModel rec;
                  if(e.receiver!.id ==
                                profileController.currentUser.value.id){
                                  send=e.sender!;
                                  // rec=e.receiver!;
                                } else{
                                  send=e.receiver!;
                                  // rec=e.sender!;
                                }
                  return InkWell(
                  onTap: () {
                    Get.to(
                      ChatPage(
                        userModel:
                            (
                            // ? e.sender
                            // : e.receiver
                            send
                            ),
                      ),
                    );
                  },
                  child: ChatTile(
                    name: send.name ?? 'User Name',
                    imageUrl:
                        send.profileImage ??
                        AssetsImage.defaultProfileUrl,
                    lastTime: e.lastMessageTimeStamp ?? 'Last Time',
                    lastChat: e.lastMessage ?? 'Last Message',
                  ),
                );}
              )
              .toList(),
        ),
      ),
      onRefresh: () {
        return contactcontroller.getChatRoomList();
      },
    );
  }
}
