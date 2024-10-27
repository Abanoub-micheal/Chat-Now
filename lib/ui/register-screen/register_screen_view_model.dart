import 'package:chat_appame/db_firebase/firebase_utils.dart';
import 'package:chat_appame/model/my_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import '../../firebase_errors.dart';
import 'register_navigator.dart';

class RegisterScreenViewModel extends ChangeNotifier {
  late RegisterNavigator registerNavigator;

  void registerFirebaseAuth(
      String email, String password, String userName, String fullName) async {
    try {
      registerNavigator.showLoading();
      final result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      var user = MyUser(
          id: result.user!.uid,
          userName: userName,
          fullName: fullName,
          email: email);
       await FirebaseUtils.registerUser(user);
      registerNavigator.hideLoading();
      registerNavigator.showMessage('Register successful');
      registerNavigator.navigateToHome(user);
    } on FirebaseAuthException catch (e) {
      registerNavigator.hideLoading();
      if (e.code == FirebaseErrors.weakPassword) {
        registerNavigator.showMessage('The password provided is too weak.');
      } else if (e.code == FirebaseErrors.emailAlreadyInUse) {
        registerNavigator
            .showMessage('The account already exists for that email.');
      }
    } catch (e) {
      registerNavigator.showMessage(e.toString());
    }
  }
}
