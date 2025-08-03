import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StatusController extends GetxController with WidgetsBindingObserver {
  final db=FirebaseFirestore.instance;
  final auth=FirebaseAuth.instance;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    await db.collection('users').doc(auth.currentUser!.uid).update({
        'status':'online'
      }); 
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    print('AppLifeCycleStatu: $state');
    if(state==AppLifecycleState.inactive){
      print('Offline');
      await db.collection('users').doc(auth.currentUser!.uid).update({
        'status':'offline'
      });
    } else if(state==AppLifecycleState.resumed){
      print('onLine');
      await db.collection('users').doc(auth.currentUser!.uid).update({
        'status':'online'
      });
    }
  }

  @override
  void onClose() async {
    final user = auth.currentUser;
    if (user != null) {
      await db.collection('users').doc(user.uid).update({
        'status': 'offline'
      });
    }
    // await db.collection('users').doc(auth.currentUser!.uid).update({
    //     'status':'offline'
    //   });
    WidgetsBinding.instance.removeObserver(this);
    
    super.onClose();
  }
}