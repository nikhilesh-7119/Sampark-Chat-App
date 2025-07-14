import 'package:flutter/material.dart';
import 'package:sampark_app/config/images.dart';

class ChatTile extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String lastTime;
  final String lastChat;
  const ChatTile({super.key, required this.name, required this.imageUrl, required this.lastTime, required this.lastChat});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(imageUrl,width: 70,),
              SizedBox(width: 15,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text(name,style: Theme.of(context).textTheme.bodyLarge,),
                SizedBox(height: 5,),
                Text(lastChat,style: Theme.of(context).textTheme.labelMedium,),
              ],),
            ],
          ),
          Text(lastTime,style: Theme.of(context).textTheme.labelMedium,),
        ],
      ),
    );
  }
}