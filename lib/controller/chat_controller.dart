import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sampark_app/controller/profile_controller.dart';
import 'package:sampark_app/model/chat_model.dart';
import 'package:sampark_app/model/chat_room_model.dart';
import 'package:sampark_app/model/user_model.dart';
import 'package:uuid/uuid.dart';

class ChatController extends GetxController {
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  RxBool isLoading = false.obs;
  var uuid = Uuid();
  ProfileController profileController = Get.put(ProfileController());

  String getRoomId(String targetUserId) {
    String currentUserId = auth.currentUser!.uid;
    if (currentUserId[0].codeUnitAt(0) > targetUserId[0].codeUnitAt(0)) {
      return currentUserId + targetUserId;
    } else {
      return targetUserId + currentUserId;
    }
  }

  UserModel getSender(UserModel currentUser, UserModel targetUser) {
    String currentUserId = currentUser.id!;
    String targetUserId = targetUser.id!;
    if (currentUserId[0].codeUnitAt(0) > targetUserId[0].codeUnitAt(0)) {
      return currentUser;
    } else {
      return targetUser;
    }
  }

  UserModel getReceiver(UserModel currentUser, UserModel targetUser) {
    String currentUserId = currentUser.id!;
    String targetUserId = targetUser.id!;
    if (currentUserId[0].codeUnitAt(0) > targetUserId[0].codeUnitAt(0)) {
      return targetUser;
    } else {
      return currentUser;
    }
  }

  // Future<void> sendMessage(String targetUserId, String message, UserModel targetUser) async {
  //   isLoading.value = true;
  //   String chatId = uuid.v6();
  //   String roomId = getRoomId(targetUserId);
  //   DateTime timeStamp= DateTime.now();
  //   String nowTime=DateFormat('hh:mm a').format(timeStamp);
  //   var newChat = ChatModel(
  //     message: message,
  //     id: chatId,
  //     senderId: auth.currentUser!.uid,
  //     receiverId: targetUserId,
  //     senderName: profileController.currentUser.value.name,
  //     timeStamp: DateTime.now().toString()
  //   );

  //   var roomDetails=ChatRoomModel(
  //     id: roomId,
  //     lastMessage: message,
  //     lastMessageTimeStamp: nowTime,
  //     sender: profileController.currentUser.value,
  //     receiver: targetUser,
  //     timeStamp: DateTime.now().toString(),
  //     unReadMessNo: 0,
  //   );
  //   try {
  //     await db.collection('chats').doc(roomId).set(roomDetails.toJson());
  //     await db
  //         .collection('chats')
  //         .doc(roomId)
  //         .collection('messages')
  //         .doc(chatId)
  //         .set(newChat.toJson());
  //   } catch (e) {
  //     print(e);
  //   }
  //   isLoading.value = false;
  // }

  Future<void> sendMessage(
    String targetUserId,
    String message,
    UserModel targetUser,
  ) async {
    isLoading.value = true;
    String chatId = uuid.v6();
    String roomId = getRoomId(targetUserId);
    DateTime timeStamp = DateTime.now();
    String nowTime = DateFormat('hh:mm a').format(timeStamp);

    UserModel sender=getSender(profileController.currentUser.value, targetUser);
    UserModel receiver=getReceiver(profileController.currentUser.value, targetUser);
    
    var newChat = ChatModel(
      message: message,
      id: chatId,
      senderId: auth.currentUser!.uid,
      receiverId: targetUserId,
      senderName: profileController.currentUser.value.name,
      timeStamp: DateTime.now().toString(),
    );

    var roomDetails = ChatRoomModel(
      id: roomId,
      lastMessage: message,
      lastMessageTimeStamp: nowTime,
      sender: sender,
      receiver: receiver,
      timeStamp: DateTime.now().toString(),
      unReadMessNo: 0,
    );
    try {
      await db.collection('chats').doc(roomId).set(roomDetails.toJson());
      await db
          .collection('chats')
          .doc(roomId)
          .collection('messages')
          .doc(chatId)
          .set(newChat.toJson());
    } catch (e) {
      print(e);
    }
    isLoading.value = false;
  } 

  Stream<List<ChatModel>> getMessages(String targetUserId) {
    String roomId = getRoomId(targetUserId);
    return db
        .collection('chats')
        .doc(roomId)
        .collection('messages')
        .orderBy('timeStamp', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => ChatModel.fromJson(doc.data()))
              .toList(),
        );
  }
}
