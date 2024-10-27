
import 'dart:async';
import 'package:chat_appame/model/my_user.dart';
import 'package:chat_appame/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:chat_appame/utils.dart' as Utils;
import 'package:provider/provider.dart';
import '../../validation_utils.dart';
import '../home-screen/home_screen.dart';
import '../register-screen/register_screen.dart';
import '../register-screen/text_form_field_widget.dart';
import 'login_screen_view_model.dart';
import 'login_navigator.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login-screen';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> implements LoginNavigator {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  LoginScreenViewModel viewModel = LoginScreenViewModel();
  @override
  void initState() {
    super.initState();
    viewModel.loginNavigator = this;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(
              'asset/images/background.png',
            ),
          ),
        ),
        child: Scaffold(
          appBar: AppBar(

            title: Text(
              'Log in',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          body: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormFieldWidget(
                        label: 'email',
                        controller: emailController,
                        keyboardType: TextInputType.name,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Please enter Email.';
                          }
                          if(!isValidEmail(text)){
                            return 'Email not Valid.';
                          }
                          return null;
                        },
                      ),
                      TextFormFieldWidget(
                        obscure: true,
                        label: 'Password',
                        controller: passwordController,
                        keyboardType: TextInputType.name,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Please Enter Password.';
                          }
                          if(text.length<6){
                            return'password should at least 6 chars.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                Theme.of(context).primaryColor)),
                        onPressed: () {
                          validateForm();
                        },
                        child: const Text(
                          'Login',
                          style:
                              TextStyle(color: Color(0xffffffff), fontSize: 18),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("don't Have an Account ?"),
                          TextButton(
                              onPressed: () {
                                 Navigator.pushNamed(context, RegisterScreen.routeName);

                              }, child: Text('Register Now',style: TextStyle(color: Theme.of(context).primaryColor)))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void validateForm() {
    if (formKey.currentState?.validate() == true) {
      return
      viewModel.signInFirebase(emailController.text, passwordController.text);
    }
  }

  @override
  hideLoading() {
    Utils.hideLoading(context);
  }

  @override
  showLoading() {
    Utils.showLoading(context);
  }

  @override
  showMessage(String message) {
    Utils.showMessage(context, message, 'ok', (context) {
      Navigator.pop(context);
    });
  }

  @override
  void navigateToHome(MyUser user) {
    var userProvider= Provider.of<UserProvider>(context,listen: false);
    userProvider.user=user;
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);

    });
  }

}
