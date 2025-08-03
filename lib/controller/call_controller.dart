import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sampark_app/model/call_model.dart';
import 'package:sampark_app/model/user_model.dart';
import 'package:sampark_app/pages/callPage/audio_call_page.dart';
import 'package:sampark_app/pages/callPage/video_call_page.dart';
import 'package:uuid/uuid.dart';

class CallController extends GetxController {
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  final uuid = Uuid();

  void onInit() {
    super.onInit();
    getCallsNotification().listen((List<CallModel> callList) {
      if (callList.isNotEmpty) {
        var callData = callList[0];
        if(callData.type=='audio'){
          audioCallNotification(callData);
        } else if(callData.type=='video'){
          videoCallNotification(callData);
        }
      }
    });
  }

  Future<void> audioCallNotification(CallModel callData, ) async{
    Get.snackbar(
          duration: Duration(days: 1),
          barBlur: 0,
          isDismissible: false,
          icon: Icon(Icons.call),
          backgroundColor: Colors.grey,
          onTap: (snack){
            Get.back();
            Get.to(
              AudioCallPage(target: UserModel(
                id: callData.callerUid,
                name: callData.callerName,
                email: callData.callerEmail,
                profileImage: callData.callerPic,
              ))
            );
          },
          callData.callerName!,
          'Incoming Audio Call',
          mainButton: TextButton(onPressed: () {
            endCall(callData);
            Get.back();
          }, child: Text('End Call')),
        );
  }

  Future<void> videoCallNotification(CallModel callData) async {
    Get.snackbar(
          duration: Duration(days: 1),
          barBlur: 0,
          isDismissible: false,
          icon: Icon(Icons.video_call),
          backgroundColor: Colors.grey,
          onTap: (snack){
            Get.back();
            Get.to(
              VideoCallPage(target: UserModel(
                id: callData.callerUid,
                name: callData.callerName,
                email: callData.callerEmail,
                profileImage: callData.callerPic,
              ))
            );
          },
          callData.callerName!,
          'Incoming Video Call',
          mainButton: TextButton(onPressed: () {
            endCall(callData);
            Get.back();
          }, child: Text('End Call')),
        );
  }

  Future<void> callAction(UserModel receiver,String type, UserModel caller) async {
    String id = uuid.v4();
    DateTime timeStamp=DateTime.now();
    String nowTime=DateFormat('hh:mm a').format(timeStamp);
    var newCall = CallModel(
      id: id,
      callerName: caller.name,
      callerPic: caller.profileImage,
      callerUid: caller.id,
      callerEmail: caller.email,
      receiverEmail: receiver.email,
      receiverName: receiver.name,
      receiverPic: receiver.profileImage,
      receiverUid: receiver.id,
      status: 'dialing',
      type: type,
      time: nowTime,
      timeStamp: DateTime.now.toString(),
    );

    try {
      await db
          .collection('notification')
          .doc(receiver.id)
          .collection('call')
          .doc(id)
          .set(newCall.toJson());
      await db
          .collection('users')
          .doc(auth.currentUser!.uid)
          .collection('call')
          .doc(id)
          .set(newCall.toJson());
      await db
          .collection('users')
          .doc(receiver.id)
          .collection('call')
          .doc(id)
          .set(newCall.toJson());

      Future.delayed(Duration(seconds: 20), () {
        endCall(newCall);
      });
    } catch (e) {
      print(e);
    }
  }

  Stream<List<CallModel>> getCallsNotification() {
    return db
        .collection('notification')
        .doc(auth.currentUser!.uid)
        .collection('call')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => CallModel.fromJson(doc.data()))
              .toList(),
        );
  }

  Future<void> endCall(CallModel call) async {
    try {
      await db
          .collection('notification')
          .doc(call.receiverUid)
          .collection('call')
          .doc(call.id)
          .delete();
    } catch (e) {
      print(e);
    }
  }
}
