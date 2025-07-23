import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sampark_app/config/images.dart';
import 'package:sampark_app/controller/chat_controller.dart';
import 'package:sampark_app/model/chat_model.dart';
import 'package:sampark_app/model/user_model.dart';
import 'package:sampark_app/pages/Chat/widgets/chat_bubble.dart';
import 'package:sampark_app/pages/userProfile/user_profile_page.dart';

class ChatPage extends StatelessWidget {
  final UserModel userModel;
  const ChatPage({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth=FirebaseAuth.instance;
    ChatController chatController = Get.put(ChatController());
    TextEditingController messageController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: (){
            Get.to(UserProfilePage(userModel: userModel,));
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Image.asset(AssetsImage.boyPic),
          ),
        ),
        title: InkWell(
          onTap: (){
            Get.to(UserProfilePage(userModel: userModel,));
          },
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userModel.name ?? 'User',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text('Online', style: Theme.of(context).textTheme.labelSmall),
                ],
              ),
            ],
          ),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.phone)),
          IconButton(onPressed: () {}, icon: Icon(Icons.video_call)),
        ],
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Theme.of(context).colorScheme.primaryContainer,
        ),
        child: Row(
          children: [
            Container(
              height: 25,
              width: 25,
              child: SvgPicture.asset(AssetsImage.chatMicSvg),
            ),
            SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: messageController,
                decoration: const InputDecoration(
                  filled: false,
                  hintText: 'Type message ...',
                ),
              ),
            ),
            SizedBox(width: 10),
            Container(
              height: 30,
              width: 30,
              child: SvgPicture.asset(AssetsImage.chatGallerySvg, width: 25),
            ),
            SizedBox(width: 10),
            InkWell(
              onTap: () {
                if (messageController.text.isNotEmpty) {
                  chatController.sendMessage(
                    userModel.id!,
                    messageController.text,
                    userModel
                  );
                  messageController.clear();
                }
              },
              child: Container(
                height: 30,
                width: 30,
                child: SvgPicture.asset(AssetsImage.chatSendSvg, width: 25),
              ),
            ),
          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.only(bottom: 50,top: 10,left: 10,right: 10),
        child: StreamBuilder<List<ChatModel>>(
          stream: chatController.getMessages(userModel.id!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            }
            if (snapshot.data == null) {
              return Center(child: Text('No Messages'));
            } else {
              return ListView.builder(
                reverse: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  DateTime timeStamp= DateTime.parse( snapshot.data![index].timeStamp!);
                  String formattedTime=DateFormat('hh:mm a').format(timeStamp);
                  return ChatBubble(
                    message: snapshot.data![index].message!,
                    isComing: snapshot.data![index].senderId! == auth.currentUser!.uid ?false :true,
                    time: formattedTime,
                    status: 'read',
                    imageUrl: snapshot.data![index].imageUrl ??'',
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
