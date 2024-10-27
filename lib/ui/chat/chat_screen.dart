import 'package:chat_appame/model/message.dart';
import 'package:chat_appame/my_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat_appame/utils.dart' as utils;
import '../../model/room.dart';
import '../../provider/user_provider.dart';
import 'chat_navigator.dart';
import 'chat_screen_view_model.dart';
import 'message_widget.dart';

class ChatScreen extends StatefulWidget {
  static const String routeName = 'chat';
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> implements ChatNavigator{
  ChatScreenViewModel viewModel = ChatScreenViewModel();
  TextEditingController controller= TextEditingController();
  @override
  void initState() {
    super.initState();
    viewModel.navigator=this;
  }

  @override
  Widget build(BuildContext context) {

    var args = ModalRoute.of(context)?.settings.arguments as Room;
    var provider= Provider.of<UserProvider>(context);
    viewModel.room = args;
    viewModel.currentUser=provider.user!;
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
            automaticallyImplyLeading: false,
            title: Text(
              args.title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          body: Container(
            margin: const EdgeInsets.only(top: 5,bottom: 40,right: 15,left: 15),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              children: [
                Expanded(child: StreamBuilder<QuerySnapshot<Message>>(stream: viewModel.listenForUpdateMessages(),builder:(context,asyncSnapshot){
                     if(asyncSnapshot.connectionState==ConnectionState.waiting){
                       return const Center(child: CircularProgressIndicator());
                     }
                     else if(asyncSnapshot.hasError){

                       return Text(asyncSnapshot.error.toString());
                     }
                     else{
                       List<Message> listMessage=asyncSnapshot.data?.docs.map((doc)=> doc.data()).toList()??[];
                      return ListView.builder(itemCount: listMessage.length,itemBuilder: (context, index) {
                         return MessageWidget( message: listMessage[index],);
                       },);

                     }


                } ,)),
                Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                          controller: controller,
                      decoration: InputDecoration(focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: MyTheme.primaryColor)),
                          contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: MyTheme.primaryColor,width: 2),
                            borderRadius:
                                const BorderRadius.only(topRight: Radius.circular(20)),
                          ),
                          hintText: 'Type a message',
                          hintStyle: const TextStyle(fontSize: 15)),
                    )),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(

                      highlightColor:MyTheme.greyColor ,
                      splashColor: MyTheme.whiteColor,
                      onTap: () {
                        viewModel.sendMessage(controller.text);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: MyTheme.primaryColor),
                        child: const Row(
                          children: [
                            Text(
                              'send',
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.send_sharp,
                              color: Colors.white,
                              size: 18,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),

        ),
      ),
    );
  }


  @override
  void cleanMessage() {
   controller.clear();
  }

  @override
  void showMessage(String message) {
    utils.showMessage(context,
        message,
        'ok'
        , (context){
      Navigator.pop(context);
        });
  }
}
