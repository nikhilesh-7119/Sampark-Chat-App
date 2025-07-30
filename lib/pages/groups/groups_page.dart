import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sampark_app/config/images.dart';
import 'package:sampark_app/controller/group_controller.dart';
import 'package:sampark_app/pages/groupChat/group_chat.dart';
import 'package:sampark_app/pages/homePage/widgets/chat_tile.dart';

class GroupsPage extends StatelessWidget {
  const GroupsPage({super.key});

  @override
  Widget build(BuildContext context) {
    GroupController groupController = Get.put(GroupController());
    return Obx(
      () => ListView(
        children: groupController.groupList
            .map(
              (group) => InkWell(
                onTap: () {
                  Get.to(GroupChatPage(groupModel: group));
                },
                child: ChatTile(
                  name: group.name!,
                  imageUrl: group.profileUrl == ''
                      ? AssetsImage.defaultProfileUrl
                      : group.profileUrl!,
                  lastTime: 'JustNow',
                  lastChat: "Group Created",
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
