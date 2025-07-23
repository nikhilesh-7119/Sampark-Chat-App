import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sampark_app/model/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileController extends GetxController {
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  final ImagePicker imagePicker = ImagePicker();
  final store = Supabase.instance.client;

  Rx<UserModel> currentUser = UserModel().obs;
  RxBool isLoading = false.obs;

  void onInit() {
    super.onInit();
    getUserDetails();
  }

  Future<void> getUserDetails() async {
    await db
        .collection('users')
        .doc(auth.currentUser!.uid)
        .get()
        .then(
          (value) => {currentUser.value = UserModel.fromJson(value.data()!)},
        );
  }

  Future<void> updateProfile(
    String imageUrl,
    String name,
    String about,
    String number,
  ) async {
    // print(imageUrl+'--------------');
    isLoading.value = true;
    try{
      final imageLink= await uploadFileToSupabase(imageUrl);

    final updatedUserModel=UserModel(
      id:auth.currentUser!.uid,
      email: auth.currentUser!.email,
      name: name,
      about: about,
      profileImage: imageUrl=='' ? currentUser.value.profileImage : imageLink,
      phoneNumber: number,
    );

    await db.collection('users').doc(auth.currentUser!.uid).set(
      updatedUserModel.toJson(),
    );

    await getUserDetails();

    } catch(e){
      print(e.toString());
    }
    isLoading.value=false;

    
  }

  Future<String> uploadFileToSupabase(String imageUrl) async{
    // final path = '$imageUrl';
    final file = File(imageUrl);

    if(imageUrl==null){
    return '';}

    try{
      final response = await store.storage.from('files').upload(imageUrl, file);
      // print(response);
      final downloadUrl = store.storage.from('files').getPublicUrl(imageUrl);
      // print(downloadUrl+'😂😂');
      return downloadUrl;
    } catch(e){
      // print(e.toString());
      return '';
    }
  }
}

// class StorageMethods {
//   final SupabaseClient _storage = Supabase.instance.client;
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   Future<String> uploadImagetoStorage(String childname, Uint8List file,bool isPost) async {
//     final String uid = _auth.currentUser!.uid;

//     // Path inside the bucket (folder structure): uid/image.jpg
//     String filePath = '$uid/image.jpg';

//     if(isPost){
//       filePath='$uid/${Uuid().v1()}.jpg';
//     }

//     // Use the `childname` as the BUCKET NAME
//     final response = await _storage.storage
//         .from(childname)
//         .uploadBinary(
//           filePath,
//           file,
//           fileOptions: const FileOptions(upsert: true),
//         );

//     final String downloadUrl = _storage.storage
//         .from(childname)
//         .getPublicUrl(filePath);
//     return downloadUrl;
//   }
// }
