import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sampark_app/config/images.dart';
import 'package:sampark_app/controller/chat_controller.dart';
import 'package:sampark_app/pages/homePage/widgets/chat_tile.dart';

class CallHistory extends StatelessWidget {
  const CallHistory({super.key});

  @override
  Widget build(BuildContext context) {
    ChatController chatController = Get.put(ChatController());
    return StreamBuilder(
      stream: chatController.getCalls(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return ChatTile(
                name: snapshot.data![index].callerName ?? '...',
                imageUrl:
                    snapshot.data![index].callerPic ??
                    AssetsImage.defaultProfileUrl,
                lastTime: snapshot.data![index].time ?? '...',
                lastChat: '${snapshot.data![index].receiverName}' + ' ${snapshot.data![index].type}' ?? '....',
              );
            },
            itemCount: snapshot.data!.length,
          );
        } else{
          return Center(child: Container(width: 200,height: 200,child: CircularProgressIndicator()));
        }
      },
    );
  }
}
