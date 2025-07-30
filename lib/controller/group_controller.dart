import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:sampark_app/config/custom_message.dart';
import 'package:sampark_app/controller/profile_controller.dart';
import 'package:sampark_app/model/chat_model.dart';
import 'package:sampark_app/model/group_model.dart';
import 'package:sampark_app/model/user_model.dart';
import 'package:sampark_app/pages/homePage/home_page.dart';
import 'package:uuid/uuid.dart';

class GroupController extends GetxController {
  RxList<UserModel> groupMembers = <UserModel>[].obs;
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  var uuid = Uuid();
  ProfileController profileController = Get.put(ProfileController());
  RxBool isLoading = false.obs;
  RxList<GroupModel> groupList = <GroupModel>[].obs;
  RxString selectedImagePath=''.obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    // DocumentSnapshot doc = await db
    //     .collection('users')
    //     .doc(auth.currentUser!.uid)
    //     .get();
    // UserModel userModel = UserModel.fromJson(
    //   doc.data() as Map<String, dynamic>,
    // );
    // groupMembers.add(userModel);
    getGroups();
  }

  void selectMember(UserModel user) {
    if (groupMembers.contains(user)) {
      groupMembers.remove(user);
    } else {
      groupMembers.add(user);
    }
  }

  Future<void> createGroup(String groupName, String imagePath) async {
    isLoading.value = true;

    String groupId = uuid.v6();
    groupMembers.add(
    UserModel(
      id: auth.currentUser!.uid,
      name: auth.currentUser!.displayName,
      profileImage: auth.currentUser!.photoURL,
      email: auth.currentUser!.email,
      role: 'Admin'
    ),
  );
    try {
      String imageUrl = await profileController.uploadFileToSupabase(imagePath);

      await db.collection('groups').doc(groupId).set({
        "id": groupId,
        "name": groupName,
        "profileUrl": imageUrl,
        "members": groupMembers.map((e) => e.toJson()).toList(),
        "createdAt": DateTime.now().toString(),
        "createdBy": auth.currentUser!.uid,
        "timeStamp": DateTime.now().toString(),
      });
      //group created
      getGroups();
      successMessage('Group Created');
      // Get.snackbar('Group created', 'group created successfully');
      Get.offAll(HomePage());
      isLoading.value = false;
    } catch (e) {
      print(e);
    }
  }

  Future<void> getGroups() async {
    isLoading.value = true;
    List<GroupModel> tempGroup = [];
    await db
        .collection('groups')
        .get()
        .then(
          (value) => tempGroup = value.docs
              .map((e) => GroupModel.fromJson(e.data()))
              .toList(),
        );
    groupList.clear();
    groupList.value = tempGroup
        .where(
          (e) =>
              e.members!.any((element) => element.id == auth.currentUser!.uid),
        )
        .toList();
    isLoading.value = false;
  }

  Future<void> sendGroupMessage(
    String message,
    String groupId,
    String imagePath,
  ) async {
    var chatId = uuid.v6();
    String imageUrl = await profileController.uploadFileToSupabase(imagePath);
    var newChat = ChatModel(
      id: chatId,
      message: message,
      imageUrl: imageUrl,
      senderId: auth.currentUser!.uid,
      senderName: profileController.currentUser.value.name,
      timeStamp: DateTime.now().toString(),
    );

    await db
        .collection('groups')
        .doc(groupId)
        .collection('messages')
        .doc(chatId)
        .set(newChat.toJson());
  }

  Stream<List<ChatModel>> getGroupMessages(String groupId) {
    return db
        .collection('groups')
        .doc(groupId)
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
