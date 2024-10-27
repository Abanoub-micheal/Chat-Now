import 'package:chat_appame/db_firebase/firebase_utils.dart';
import 'package:chat_appame/model/room.dart';
import 'package:chat_appame/ui/add_room/add_room_navigator.dart';
import 'package:flutter/foundation.dart';

class AddRoomViewModel extends ChangeNotifier {
  late AddRoomNavigator navigator;

  createRoom(String title, String description, String categoryId) async {
    Room room = Room(
        idRoom: '',
        title: title,
        description: description,
        categoryId: categoryId);
    try {
     navigator.showLoading();
   var createRoom= await  FirebaseUtils.addRoom(room);
      navigator.hideLoading();
      navigator.showMessage('room was created Successful');
      navigator.navigateToHome();
    }
    catch (e) {
      navigator.hideLoading();
      navigator.showMessage(e.toString());
    }
  }
}
