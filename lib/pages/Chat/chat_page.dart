import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sampark_app/config/images.dart';
import 'package:sampark_app/controller/call_controller.dart';
import 'package:sampark_app/controller/chat_controller.dart';
import 'package:sampark_app/controller/profile_controller.dart';
import 'package:sampark_app/model/chat_model.dart';
import 'package:sampark_app/model/user_model.dart';
import 'package:sampark_app/pages/Chat/widgets/chat_bubble.dart';
import 'package:sampark_app/pages/Chat/widgets/type_message.dart';
import 'package:sampark_app/pages/userProfile/user_profile_page.dart';

class ChatPage extends StatelessWidget {
  final UserModel userModel;
  const ChatPage({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    ChatController chatController = Get.put(ChatController());
    CallController callController=Get.put(CallController());
    ProfileController profileController=Get.put(ProfileController());

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            Get.to(UserProfilePage(userModel: userModel));
          },
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Container(
              height: 50,
              width: 50,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: CachedNetworkImage(
                  imageUrl:
                      userModel.profileImage ?? AssetsImage.defaultProfileUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          ),
        ),
        title: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            Get.to(UserProfilePage(userModel: userModel));
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
                  StreamBuilder(
                    stream: chatController.getStatus(userModel.id!),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text('. . . .');
                      } else {
                        return Text(
                          snapshot.data!.status ?? 'null',
                          style: TextStyle(
                            fontSize: 12,
                            color: snapshot.data!.status == 'online'
                                ? Colors.green
                                : Colors.grey,
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          IconButton(onPressed: () {
            callController.callAction(userModel, profileController.currentUser.value);
          }, icon: Icon(Icons.phone)),
          IconButton(onPressed: () {}, icon: Icon(Icons.video_call)),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.only(bottom: 5, top: 10, left: 10, right: 10),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  StreamBuilder<List<ChatModel>>(
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
                            DateTime timeStamp = DateTime.parse(
                              snapshot.data![index].timeStamp!,
                            );
                            String formattedTime = DateFormat(
                              'hh:mm a',
                            ).format(timeStamp);
                            return ChatBubble(
                              message: snapshot.data![index].message!,
                              isComing:
                                  snapshot.data![index].senderId! ==
                                      auth.currentUser!.uid
                                  ? false
                                  : true,
                              time: formattedTime,
                              status: 'read',
                              imageUrl: snapshot.data![index].imageUrl ?? '',
                            );
                          },
                        );
                      }
                    },
                  ),
                  Obx(
                    () => (chatController.selectedImagePath.value != '')
                        ? Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Stack(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: FileImage(
                                        File(
                                          chatController
                                              .selectedImagePath
                                              .value,
                                        ),
                                      ),
                                      fit: BoxFit.contain,
                                    ),
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primaryContainer,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  height: 500,
                                ),
                                Positioned(
                                  right: 0,
                                  child: IconButton(
                                    onPressed: () {
                                      chatController.selectedImagePath.value =
                                          '';
                                    },
                                    icon: Icon(Icons.close),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(),
                  ),
                ],
              ),
            ),

            TypeMessage(userModel: userModel),
          ],
        ),
      ),
    );
  }
}
