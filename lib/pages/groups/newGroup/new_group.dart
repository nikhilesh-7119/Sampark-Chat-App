import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sampark_app/config/images.dart';
import 'package:sampark_app/controller/contactController.dart';
import 'package:sampark_app/controller/group_controller.dart';
import 'package:sampark_app/pages/groups/newGroup/group_title.dart';
import 'package:sampark_app/pages/groups/newGroup/selected_members_list.dart';
import 'package:sampark_app/pages/homePage/widgets/chat_tile.dart';

class NewGroup extends StatelessWidget {
  const NewGroup({super.key});

  @override
  Widget build(BuildContext context) {
    Contactcontroller contactcontroller = Get.put(Contactcontroller());
    GroupController groupController = Get.put(GroupController());
    return Scaffold(
      appBar: AppBar(title: Text('New Group')),
      floatingActionButton: Obx(
        () => FloatingActionButton(
          backgroundColor: groupController.groupMembers.isEmpty
              ? Colors.grey
              : Theme.of(context).colorScheme.primary,
          onPressed: () {
            if (groupController.groupMembers.isEmpty) {
              Get.snackbar('Error', "Please select atleaast one member");
            } else {
              Get.to(GroupTitle());
            }
          },
          child: Icon(
            Icons.arrow_forward,
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SelectedMembersList(),
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  "Contacts on Sampark",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: StreamBuilder(
                stream: contactcontroller.getContacts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text("error ${snapshot.error}"));
                  }
                  if (snapshot.data == null) {
                    return const Center(child: Text('No Messages'));
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            groupController.selectMember(snapshot.data![index]);
                          },
                          child: ChatTile(
                            name: snapshot.data![index].name ?? 'User',
                            imageUrl:
                                snapshot.data![index].profileImage ??
                                AssetsImage.defaultProfileUrl,
                            lastTime: 'lastTime',
                            lastChat: snapshot.data![index].about ?? 'LastChat',
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
