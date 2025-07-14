import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sampark_app/config/images.dart';
import 'package:sampark_app/pages/Chat/widgets/chat_bubble.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Image.asset(AssetsImage.boyPic),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nitish Kumar', style: Theme.of(context).textTheme.bodyLarge),
            Text('Online', style: Theme.of(context).textTheme.labelSmall),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.phone)),
          IconButton(onPressed: () {}, icon: Icon(Icons.video_call)),
        ],
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.symmetric(vertical: 5,horizontal: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Theme.of(context).colorScheme.primaryContainer
        ),
        child: Row(
          children: [
            Container(height:25,width: 25,child:  SvgPicture.asset(AssetsImage.chatMicSvg)),
            SizedBox(width: 10,),
            Expanded(child: TextField(
              decoration: InputDecoration(
                filled: false,
                hintText: 'Type message ...'
              ),
            )),
            SizedBox(width: 10,),
            Container(height: 30,width: 30, child: SvgPicture.asset(AssetsImage.chatGallerySvg,width: 25,)),
            SizedBox(width: 10,),
            Container(height: 30,width: 30, child: SvgPicture.asset(AssetsImage.chatSendSvg,width: 25,)),
          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            ChatBubble(
              message: 'hello gello how r u',
              isComing: true,
              time: '10:10 AM',
              status: 'read',
              imageUrl: '',
            ),
            ChatBubble(
              message: 'hello gello how r u',
              isComing: false ,
              time: '10:10 AM',
              status: 'read',
              imageUrl: '',
            ),
            ChatBubble(
              message: 'hello gello how r u',
              isComing: false,
              time: '10:10 AM',
              status: 'read',
              imageUrl: 'https://creatypestudio.co/wp-content/uploads/2021/06/google-fonts.png',
            ),
            ChatBubble(
              message: 'hello gello how r u',
              isComing: true ,
              time: '10:10 AM',
              status: 'read',
              imageUrl: '',
            ),
            ChatBubble(
              message: 'hello gello how r u',
              isComing: true,
              time: '10:10 AM',
              status: 'read',
              imageUrl: 'https://creatypestudio.co/wp-content/uploads/2021/06/google-fonts.png',
            ),
            ChatBubble(
              message: 'hello gello how r u',
              isComing: false ,
              time: '10:10 AM',
              status: 'read',
              imageUrl: '',
            ),
            ChatBubble(
              message: 'hello gello how r u',
              isComing: false,
              time: '10:10 AM',
              status: 'read',
              imageUrl: 'https://creatypestudio.co/wp-content/uploads/2021/06/google-fonts.png',
            ),
          ],
        ),
      ),
    );
  }
}
