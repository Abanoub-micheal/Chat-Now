import 'package:flutter/material.dart';
import '../../model/room.dart';
import '../chat/chat_screen.dart';

class RoomWidget extends StatelessWidget {
 final Room room;
   const RoomWidget({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, ChatScreen.routeName,arguments: room);
      },
      child: Container(
        margin: const EdgeInsets.all(15),
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(20),  boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],),
        child: Column(children: [
        Image.asset('asset/images/${room.categoryId}.png',height: 70,),
        const SizedBox(height: 15,),
        Text(room.title,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)
        
      ],),),
    );
  }
}
