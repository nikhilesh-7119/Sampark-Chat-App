import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sampark_app/controller/auth_controller.dart';
import 'package:sampark_app/controller/image_picker.dart';
import 'package:sampark_app/controller/profile_controller.dart';
import 'package:sampark_app/widgets/primary_button.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    RxBool isEdit = false.obs;
    ProfileController profileController = Get.put(ProfileController());
    TextEditingController name = TextEditingController(
      text: profileController.currentUser.value.name,
    );
    TextEditingController email = TextEditingController(
      text: profileController.currentUser.value.email,
    );
    TextEditingController about = TextEditingController(
      text: profileController.currentUser.value.about,
    );
    TextEditingController phone = TextEditingController(
      text: profileController.currentUser.value.phoneNumber,
    );
    ImagePickerController imagePickerController = Get.put(
      ImagePickerController(),
    );
    RxString imagePath = ''.obs;

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(AuthController().logoutUser());
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Container(
              // height: 300,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Obx(
                              () => isEdit.value
                                  ? InkWell(
                                      onTap: () async {
                                        imagePath.value =
                                            await imagePickerController
                                                .pickImage();

                                        // print("image Picked" + imagePath.value);
                                      },
                                      child: Container(
                                        height: 200,
                                        width: 200,
                                        decoration: BoxDecoration(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.background,
                                          borderRadius: BorderRadius.circular(
                                            100,
                                          ),
                                        ),
                                        child: imagePath.value == ''
                                            ? Icon(Icons.add)
                                            : ClipRRect(
                                                child: Image.file(
                                                  File(imagePath.value),
                                                  fit: BoxFit.cover,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                              ),
                                      ),
                                    )
                                  : Container(
                                      height: 200,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.background,
                                        borderRadius: BorderRadius.circular(
                                          100,
                                        ),
                                      ),
                                      child:
                                          profileController
                                                  .currentUser
                                                  .value
                                                  .profileImage ==
                                              null
                                          ? Icon(Icons.image)
                                          : ClipRRect(
                                            borderRadius: BorderRadius.circular(100),
                                              child: CachedNetworkImage(
                                                imageUrl: profileController
                                                    .currentUser
                                                    .value
                                                    .profileImage!,
                                                fit: BoxFit.cover,
                                                placeholder: (context,url)=>CircularProgressIndicator(),
                                                errorWidget: (context,url,error)=>Icon(Icons.error),
                                              ),
                                            ),
                                    ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Obx(
                          () => TextField(
                            controller: name,
                            style: TextStyle(color: Colors.white),
                            enabled: isEdit.value,
                            decoration: InputDecoration(
                              filled: isEdit.value,
                              labelText: 'Name',
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        // SizedBox(height: 20),
                        TextField(
                          controller: email,
                          style: TextStyle(color: Colors.white),
                          enabled: false,
                          decoration: InputDecoration(
                            filled: isEdit.value,
                            labelText: 'Email',
                            prefixIcon: Icon(
                              Icons.alternate_email,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        // SizedBox(height: 20),
                        Obx(
                          () => TextField(
                            controller: about,
                            style: TextStyle(color: Colors.white),
                            enabled: isEdit.value,
                            decoration: InputDecoration(
                              filled: isEdit.value,
                              labelText: 'About',
                              prefixIcon: Icon(Icons.info, color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Obx(
                          () => TextField(
                            controller: phone,
                            style: TextStyle(color: Colors.white),
                            enabled: isEdit.value,
                            decoration: InputDecoration(
                              filled: isEdit.value,
                              labelText: 'Number',
                              prefixIcon: Icon(
                                Icons.phone,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Obx(
                          () => profileController.isLoading.value
                              ? Center(child: CircularProgressIndicator())
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    isEdit.value
                                        ? PrimaryButton(
                                            btnName: 'SAVE',
                                            icon: Icons.save,
                                            onTap: () async {
                                              await profileController
                                                  .updateProfile(
                                                    imagePath.value,
                                                    name.text,
                                                    about.text,
                                                    phone.text,
                                                  );
                                              isEdit.value = false;
                                            },
                                          )
                                        : PrimaryButton(
                                            btnName: 'EDIT',
                                            icon: Icons.edit,
                                            onTap: () {
                                              isEdit.value = true;
                                            },
                                          ),
                                  ],
                                ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
