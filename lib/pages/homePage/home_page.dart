import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sampark_app/config/images.dart';
import 'package:sampark_app/config/strings.dart';
import 'package:sampark_app/controller/contactController.dart';
import 'package:sampark_app/controller/image_picker.dart';
import 'package:sampark_app/controller/profile_controller.dart';
import 'package:sampark_app/controller/status_controller.dart';
import 'package:sampark_app/pages/groups/groups_page.dart';
import 'package:sampark_app/pages/homePage/widgets/chat_list.dart';
import 'package:sampark_app/pages/homePage/widgets/tabBar.dart';
import 'package:sampark_app/pages/profilePage/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 3, vsync: this);
    Contactcontroller contactcontroller=Get.put(Contactcontroller());
    ProfileController profileController = Get.put(ProfileController());
    ImagePickerController image=Get.put(ImagePickerController());
    StatusController statusController=Get.put(StatusController());
    


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: Text(
          AppString.appName,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(AssetsImage.appIconSVG),
        ),
        actions: [
          IconButton(onPressed: () {
            contactcontroller.getChatRoomList();
          }, icon: Icon(Icons.search)),
          IconButton(
            onPressed: () {
              Get.to(ProfilePage());
            },
            icon: Icon(Icons.more_vert),
          ),
        ],
        bottom: myTabBar(tabController, context),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed('/contactPage');
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.onBackground,
          size: 32,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: TabBarView(
          controller: tabController,
          children: [
            ChatList(),
            GroupsPage(),
            ListView(children: [ListTile(title: Text('nik'))]),
          ],
        ),
      ),
    );
  }
}
