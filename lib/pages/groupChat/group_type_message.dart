import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sampark_app/config/images.dart';
import 'package:sampark_app/controller/chat_controller.dart';
import 'package:sampark_app/controller/group_controller.dart';
import 'package:sampark_app/controller/image_picker.dart';
import 'package:sampark_app/model/group_model.dart';
import 'package:sampark_app/model/user_model.dart';
import 'package:sampark_app/widgets/image_picker_bottom_sheet.dart';

class GroupTypeMessage extends StatelessWidget {
  final GroupModel groupModel;
  const GroupTypeMessage({super.key, required this.groupModel});

  @override
  Widget build(BuildContext context) {
    TextEditingController messageController = TextEditingController();
    RxString message = ''.obs;
    ImagePickerController imagePickerController = Get.put(
      ImagePickerController(),
    );
    GroupController groupController=Get.put(GroupController());

    return Container(
      // margin: EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Row(
        children: [
          Container(
            // height: 25,
            // width: 25,
            child: Icon(Icons.emoji_emotions),
          ),
          SizedBox(width: 10),
          Expanded(
            child: TextField(
              onChanged: (value) {
                message.value = value;
                // print('😂😂😂😂😂'+message.value);
              },
              controller: messageController,
              decoration: const InputDecoration(
                filled: false,
                hintText: 'Type message ...',
              ),
            ),
          ),
          SizedBox(width: 10),
          Obx(
            () => groupController.selectedImagePath.value == ''
                ? InkWell(
                    onTap: () {
                      ImagePickerBottomSheet(
                        context,
                        groupController.selectedImagePath,
                        imagePickerController,
                      );
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      child: SvgPicture.asset(
                        AssetsImage.chatGallerySvg,
                        width: 25,
                      ),
                    ),
                  )
                : SizedBox(),
          ),
          SizedBox(width: 10),

          Obx(
            () =>
                message.value != '' ||
                    groupController.selectedImagePath.value != ''
                ? InkWell(
                    onTap: () {
                      groupController.sendGroupMessage(messageController.text, groupModel.id!, '');
                      messageController.clear();
                      message.value='';
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      child: groupController.isLoading.value
                          ? CircularProgressIndicator()
                          : SvgPicture.asset(
                              AssetsImage.chatSendSvg,
                              width: 25,
                            ),
                    ),
                  )
                : Container(
                    height: 25,
                    width: 25,
                    child: SvgPicture.asset(AssetsImage.chatMicSvg),
                  ),
          ),
        ],
      ),
    );
  }
}
