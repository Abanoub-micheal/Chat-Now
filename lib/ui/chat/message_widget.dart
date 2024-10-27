import 'package:chat_appame/my_theme.dart';
import 'package:chat_appame/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../model/message.dart';


class MessageWidget extends StatelessWidget {
 final Message message;
  const MessageWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProvider>(context);
    return provider.user?.id==message.senderId?SentMessage(message: message):ReceiveMessage(message: message);
  }
}

class SentMessage extends StatelessWidget {
 final Message message;

  const SentMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    var time =DateTime.fromMicrosecondsSinceEpoch(message.dateTime);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          decoration: BoxDecoration(
              color: MyTheme.primaryColor,
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(12),
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12))),
          child: Text(message.content,style: const TextStyle(color: Colors.white),),
        ),

        Text(DateFormat(' hh:mm').format(time))
      ],
    );
  }
}
class ReceiveMessage extends StatelessWidget {
final Message message;

  const ReceiveMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    var time =DateTime.fromMicrosecondsSinceEpoch(message.dateTime);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 10),
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          decoration: BoxDecoration(
              color: MyTheme.greyColor,
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(12),
                  topLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12))),
          child: Text(message.content,style: const TextStyle(color: Colors.black),),
        ),

        Text(DateFormat(' hh:mm').format(time))
      ],
    );
  }
}
