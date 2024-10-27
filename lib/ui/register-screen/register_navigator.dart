import 'package:chat_appame/model/my_user.dart';

abstract class RegisterNavigator{
  void showLoading();
  void hideLoading();
  void showMessage(String message);
  void navigateToHome(MyUser user);
}