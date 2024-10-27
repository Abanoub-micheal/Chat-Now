import 'package:chat_appame/db_firebase/firebase_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import '../../firebase_errors.dart';
import 'login_navigator.dart';

class LoginScreenViewModel extends ChangeNotifier{

 late LoginNavigator loginNavigator;

  void signInFirebase(String email,String password)async{
    try {
       loginNavigator.showLoading();
      final result = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
       loginNavigator.hideLoading();
       loginNavigator.showMessage('login successful');
     var userObj=await FirebaseUtils.getUserData(result.user?.uid??'');
      if(userObj == null){
        loginNavigator.hideLoading();
        loginNavigator.showMessage('register failed please try again');
      }else{
      loginNavigator.navigateToHome(userObj);
      }

    } on FirebaseAuthException catch (e) {
      loginNavigator.hideLoading();
      if (e.code == FirebaseErrors.userNotFound) {
        loginNavigator.showMessage('No user found for that email.');

      } else if (e.code == FirebaseErrors.wrongPassword) {
        loginNavigator.showMessage('Wrong password provided for that user.');
      }
    }
    catch(e){
     loginNavigator.showMessage(e.toString());
    }


  }










}