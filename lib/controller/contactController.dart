import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:sampark_app/model/chat_room_model.dart';
import 'package:sampark_app/model/user_model.dart';

class Contactcontroller extends GetxController {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  RxBool isLoading = false.obs;
  RxList<UserModel> userList = <UserModel>[].obs;
  RxList<ChatRoomModel> chatRoomList = <ChatRoomModel>[].obs;

  void onInit() async {
    super.onInit();
    await getUserList();
    await getChatRoomList();
  }

  Future<void> getUserList() async {
    isLoading.value = true;
    try {
      userList.clear();
      await db
          .collection('users')
          .get()
          .then(
            (value) => {
              userList.value = value.docs
                  .map((e) => UserModel.fromJson(e.data()))
                  .toList(),
            },
          );
    } catch (e) {
      print(e);
    }
    isLoading.value = false;
  }

  Future<void> getChatRoomList() async {
    List<ChatRoomModel> tempChatRoom = [];
    await db.collection('chats').get().then((value) {
      tempChatRoom = value.docs
          .map((e) => ChatRoomModel.fromJson(e.data()))
          .toList();
    });
    chatRoomList.value=tempChatRoom.where((e)=> e.id!.contains(auth.currentUser!.uid)).toList();
  }
}
