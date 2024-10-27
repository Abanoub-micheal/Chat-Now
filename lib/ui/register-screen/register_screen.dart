import 'dart:async';
import 'package:chat_appame/model/my_user.dart';
import 'package:chat_appame/provider/user_provider.dart';
import 'package:chat_appame/ui/home-screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat_appame/utils.dart' as Utils;
import '../../validation_utils.dart';
import 'register_screen_view_model.dart';
import 'register_navigator.dart';
import 'text_form_field_widget.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'register-screen';

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    implements RegisterNavigator {
  TextEditingController userNameController = TextEditingController();

  TextEditingController fullNameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController passwordConfirmationController =
      TextEditingController();

  var formKey = GlobalKey<FormState>();

  RegisterScreenViewModel viewModel = RegisterScreenViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.registerNavigator = this;
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
                'Create Account',
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
                          label: 'User Name',
                          controller: userNameController,
                          keyboardType: TextInputType.name,
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return 'Please Enter user name.';
                            }
                            return null;
                          },
                        ),
                        TextFormFieldWidget(
                          label: 'Full Name',
                          controller: fullNameController,
                          keyboardType: TextInputType.name,
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return 'Please Enter full name.';
                            }
                            return null;
                          },
                        ),
                        TextFormFieldWidget(
                          label: 'Email',
                          controller: emailController,
                          keyboardType: TextInputType.name,
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return 'Please Enter Email.';
                            }
                            if (!isValidEmail(text)) {
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
                            if (text.length < 6) {
                              return 'password should at least 6 chars.';
                            }
                            return null;
                          },
                        ),
                        TextFormFieldWidget(
                          obscure: true,
                          label: 'Confirm Password ',
                          controller: passwordConfirmationController,
                          keyboardType: TextInputType.name,
                          validator: (text) {
                           if (text == null || text.trim().isEmpty) {
                              return 'Please enter password';
                            }
                            if (text != passwordController.text) {
                              return "password doesn't match";
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
                            'Create',
                            style: TextStyle(
                                color: Color(0xffffffff), fontSize: 18),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                          const Text('you Have an Account ?'),
                          TextButton(onPressed: () {
                            Navigator.pop(context);

                          }, child: Text('Login',style: TextStyle(color: Theme.of(context).primaryColor),))
                        ],),
                      ],
                    ),
                  ),
                ),
              ),
            )),
      ),
    );
  }

  void validateForm() async {
    if (formKey.currentState?.validate() == true) {
      return viewModel.registerFirebaseAuth(
          emailController.text, passwordController.text,userNameController.text,fullNameController.text);
    }
  }

  @override
  void hideLoading() {
    Utils.hideLoading(context);
  }

  @override
  void showLoading() {
    Utils.showLoading(context);
  }

  @override
  void showMessage(String message) {
    Utils.showMessage(context, message, 'ok', (context) {
     Navigator.pop(context);
    });
  }

  @override
  void navigateToHome(MyUser user) {
    var userProvider=Provider.of<UserProvider>(context);
    userProvider.user=user;
   Timer(const Duration(seconds: 3), () {
     Navigator.pushReplacementNamed(context, HomeScreen.routeName);

   });
  }

}
