import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sampark_app/config/images.dart';
import 'package:sampark_app/controller/group_controller.dart';
import 'package:sampark_app/model/user_model.dart';

class GroupMemberInfo extends StatelessWidget {
  final String profileImage;
  final String userName;
  final String userEmail;
  final String groupId;
  const GroupMemberInfo({
    super.key,
    required this.profileImage,
    required this.userName,
    required this.userEmail, required this.groupId,
  });

  @override
  Widget build(BuildContext context) {
    GroupController groupController = Get.put(GroupController());

    return Container(
      padding: EdgeInsets.all(20),
      // height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: CachedNetworkImage(imageUrl: profileImage==''?AssetsImage.defaultProfileUrl : profileImage,fit: BoxFit.cover,
                        placeholder: (context,url)=>CircularProgressIndicator(),
                        errorWidget: (context,url,error)=>Icon(Icons.error),)
                        
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      userName,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      userEmail,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      child: Container(
                        height: 50,
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Theme.of(context).colorScheme.background,
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.phone, color: Colors.green),
                            SizedBox(width: 10),
                            Text('Call', style: TextStyle(color: Colors.green)),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      child: Container(
                        height: 50,
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Theme.of(context).colorScheme.background,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.video_call,
                              color: Colors.amber,
                              size: 25,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Video',
                              style: TextStyle(color: Colors.amber),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        var newMember=UserModel(
                          email: 'test3@gmail.com',
                          name: 'test3',
                          profileImage: '',
                          role: 'admin'
                        );
                        groupController.addMemberToGroup(groupId, newMember);
                      },
                      child: Container(
                        height: 50,
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Theme.of(context).colorScheme.background,
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(AssetsImage.groupAddUser,width: 25,),
                            SizedBox(width: 10),
                            Text(
                              'Add',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
