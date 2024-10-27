import 'package:chat_appame/db_firebase/firebase_utils.dart';
import 'package:chat_appame/model/my_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class UserProvider extends ChangeNotifier{
  MyUser? user;
  User? firebaseUser;
  UserProvider(){
    firebaseUser =FirebaseAuth.instance.currentUser;
    initUser();
  }
  initUser()async{
    if(firebaseUser!=null){
      user= await FirebaseUtils.getUserData(firebaseUser?.uid??'');
    }
  }






}