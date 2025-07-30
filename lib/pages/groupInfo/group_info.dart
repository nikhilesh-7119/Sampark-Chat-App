import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sampark_app/config/images.dart';
import 'package:sampark_app/model/group_model.dart';
import 'package:sampark_app/pages/groupInfo/group_member_info.dart';
import 'package:sampark_app/pages/homePage/widgets/chat_tile.dart';

class GroupInfo extends StatelessWidget {
  final GroupModel groupModel;
  const GroupInfo({super.key, required this.groupModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(groupModel.name!),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            GroupMemberInfo(
              groupId: groupModel.id!,
              profileImage: groupModel.profileUrl == ''
                  ? AssetsImage.defaultProfileUrl
                  : groupModel.profileUrl!,
              userName: groupModel.name ?? "Group",
              userEmail: groupModel.description ?? "No description available",
            ),
            SizedBox(height: 20),
            Text('Members', style: Theme.of(context).textTheme.labelMedium),
            SizedBox(height: 10),
            Column(
              children: groupModel.members!
                  .map(
                    (member) => ChatTile(
                      name: member.name ?? 'User',
                      imageUrl:
                          member.profileImage ?? AssetsImage.defaultProfileUrl,
                      lastTime: member.role == 'Admin' ? 'Admin' :'User',
                      lastChat: member.email!,
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
