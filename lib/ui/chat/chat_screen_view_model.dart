import 'package:chat_appame/db_firebase/firebase_utils.dart';
import 'package:chat_appame/model/message.dart';
import 'package:chat_appame/model/my_user.dart';
import 'package:chat_appame/model/room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'chat_navigator.dart';

class ChatScreenViewModel extends ChangeNotifier{

  late ChatNavigator navigator;
   late MyUser currentUser;
   late Room room;
   late  Stream<QuerySnapshot<Message>> streamMessages;

void sendMessage(String content)async{

  Message message =Message(
      roomId: room.idRoom,
      content: content,
      senderId: currentUser.id,
      senderName: currentUser.userName,
      dateTime: DateTime.now().microsecondsSinceEpoch);
  try {
   var res= await FirebaseUtils.insertMessage(message);
    navigator.cleanMessage();
  } catch (error) {
   navigator.showMessage(error.toString());
  }

}
  Stream<QuerySnapshot<Message>> listenForUpdateMessages(){
return  FirebaseUtils.retriveMessages(room.idRoom);
}


}