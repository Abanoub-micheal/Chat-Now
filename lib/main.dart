import 'package:chat_appame/my_theme.dart';
import 'package:chat_appame/provider/user_provider.dart';
import 'package:chat_appame/ui/add_room/add_room.dart';
import 'package:chat_appame/ui/chat/chat_screen.dart';
import 'package:chat_appame/ui/home-screen/home_screen.dart';
import 'package:chat_appame/ui/login-screen/login_screen.dart';
import 'package:chat_appame/ui/register-screen/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(create: (context) => UserProvider(),child: const MyApp()));

}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var userProvider=Provider.of<UserProvider>(context);
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: MyTheme.lightMode,

      initialRoute:userProvider.firebaseUser==null?LoginScreen.routeName:HomeScreen.routeName,
      routes: {
        RegisterScreen.routeName:(context) => const RegisterScreen(),
        LoginScreen.routeName:(context) => const LoginScreen(),
        HomeScreen.routeName:(context) =>  const HomeScreen(),
        AddRoom.routeName : (context) =>   const AddRoom(),
       ChatScreen.routeName : (context) =>   const ChatScreen(),

      },


    );
  }
}
