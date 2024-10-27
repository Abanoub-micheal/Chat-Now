import 'package:chat_appame/model/my_user.dart';

abstract class LoginNavigator{
 void showLoading();
  void showMessage(String message);
  void hideLoading();
  void navigateToHome(MyUser user);
}