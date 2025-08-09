import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class AppController extends GetxController {

  RxString oldVersion=''.obs;
  RxString currentVersion=''.obs;
  RxString newAppUrl=''.obs;

  void onInit() async{
    super.onInit();
    PackageInfo packageInfo=await PackageInfo.fromPlatform();
    currentVersion.value=packageInfo.version;
    // print(currentVersion.value);
    checkLatestVersion();
  }


  void checkUpdate() {
    Get.rawSnackbar(
      duration: Duration(days: 1),
      message: 'New update Available',
      mainButton: TextButton(
        onPressed: () {
          launchUrl(Uri.parse(newAppUrl.value),
          mode: LaunchMode.externalApplication);
          Get.back();
        },
        child: Text('Update Now'),
      ),
      icon: Icon(Icons.update_sharp),
      snackStyle: SnackStyle.FLOATING,
      barBlur: 20,
      leftBarIndicatorColor: Colors.blue,
    );
  }

  Future<void> checkLatestVersion() async {
    const repositoryOwner = 'nikhilesh-7119';
    const repositoryName = 'Sampark-Chat-App';
    final response = await http.get(
      Uri.parse(
        'https://api.github.com/repos/$repositoryOwner/$repositoryName/releases/latest',
      ),
    );
    if(response.statusCode == 200){
      final Map<String,dynamic> data=json.decode(response.body);
      final tagName=data['tag_name'];
      oldVersion.value=tagName;
      // print(oldVersion.value);
      final assets=data['assets'] as List<dynamic>;
      for(final asset in assets){
        final assetName=asset['name'];
        final assetDownloadUrl=asset['browser_download_url'];
        newAppUrl.value=assetDownloadUrl;
      }
      if(oldVersion.value!=currentVersion.value){
        checkUpdate();
      }
      // else{
      //   noUpdateFound();
      // }
      // checkUpdate();
    }else{
      print('Failed to fetch Github release info. Status code: ${response.statusCode}');
    }
  }

  // void noUpdateFound() {
  //   Get.rawSnackbar(
  //     duration: Duration(days: 1),
  //     title: 'You Are updated',
  //     message: 'Check Update',
  //     mainButton: TextButton(
  //       onPressed: () {
  //         Get.back();
  //       },
  //       child: Text('Update Now'),
  //     ),
  //   );
  // }

}
