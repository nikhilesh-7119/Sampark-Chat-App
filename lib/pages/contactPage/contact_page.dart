import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sampark_app/config/images.dart';
import 'package:sampark_app/controller/chat_controller.dart';
import 'package:sampark_app/controller/contactController.dart';
import 'package:sampark_app/pages/Chat/chat_page.dart';
import 'package:sampark_app/pages/contactPage/widgets/contact_search.dart';
import 'package:sampark_app/pages/contactPage/widgets/new_contact_tile.dart';
import 'package:sampark_app/pages/homePage/widgets/chat_tile.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    RxBool isSearchEnabled = false.obs;
    Contactcontroller contactcontroller = Get.put(Contactcontroller());
    ChatController chatController=Get.put(ChatController());

    return Scaffold(
      appBar: AppBar(
        title: Text('Select contact'),
        actions: [
          Obx(
            () => IconButton(
              onPressed: () {
                isSearchEnabled.value = !isSearchEnabled.value;
              },
              icon: isSearchEnabled.value
                  ? Icon(Icons.close)
                  : Icon(Icons.search),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            Obx(() => isSearchEnabled.value ? ContactSearch() : SizedBox()),
            NewContactTile(
              btnName: 'New Contact',
              icon: Icons.person_add,
              onTap: () {},
            ),
            SizedBox(height: 10),
            NewContactTile(
              btnName: 'New Group',
              icon: Icons.group_add,
              onTap: () {},
            ),
            SizedBox(height: 20),
            Row(children: [Text('Contacts on Sampark')]),
            SizedBox(height: 20),
            Obx(
              () => Column(
                children: contactcontroller.userList
                    .map(
                      (e) => InkWell(
                        onTap: () {
                          Get.to(ChatPage(userModel: e));
                        },
                        
                        child: ChatTile(
                          name: e.name ?? 'User',
                          imageUrl: e.profileImage ?? AssetsImage.defaultProfileUrl,
                          lastTime: e.email == chatController.auth.currentUser!.email ?'You' : '10:00',
                          lastChat: e.about ?? 'Hey there',
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
