import 'dart:async';
import 'package:chat_appame/my_theme.dart';
import 'package:chat_appame/model/category.dart';
import 'package:chat_appame/ui/add_room/add_room_navigator.dart';
import 'package:chat_appame/ui/add_room/add_room_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat_appame/utils.dart' as utils;

class AddRoom extends StatefulWidget {
  static const String routeName = 'room';
  const AddRoom({super.key});
  @override
  State<AddRoom> createState() => _AddRoomState();
}

class _AddRoomState extends State<AddRoom> implements AddRoomNavigator {
  AddRoomViewModel viewModel = AddRoomViewModel();
  var formKey = GlobalKey<FormState>();
  List categoryList=Category.getCategoryList();
  late Category selectCategory;
  TextEditingController titleController=TextEditingController();
  TextEditingController descController=TextEditingController();
  @override
  void initState() {
    super.initState();
    viewModel.navigator = this;
    selectCategory =categoryList[0];
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
            iconTheme: const IconThemeData(color: Colors.white),
            title: Text(
              'Add Room',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          body: Form(
            key: formKey,
            child: Container(
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
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Create New Room',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    Image.asset(
                      'asset/images/room.png',
                      height: 70,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: titleController,
                      decoration: InputDecoration(
                          hintText: 'Enter Room Name',
                          hintStyle:
                              TextStyle(color: MyTheme.greyColor, fontSize: 20)),
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please Enter Room Name';
                        }
                        return null;
                      },

                    ),
                    const SizedBox(height: 20),
                    DropdownButton<Category>(
                      value: selectCategory,
                      items:categoryList.map((category)=>DropdownMenuItem<Category>(
                        value: category,
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                      Text(category.title,style: TextStyle(color: MyTheme.greyColor),),
                              const SizedBox(width: 50),
                      Image.asset(category.image)
                    ],)) ).toList() ,onChanged: (newCategory) {
                      if(newCategory==null)return;
                      setState(() {
                        selectCategory=newCategory;
                      });
                    },),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: descController,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please Enter Room Description';
                        }
                        return null;
                      },
                      maxLines: 4,
                      minLines: 4,
                      decoration: InputDecoration(
                        hintText: 'Enter Room Description',
                        hintStyle:
                            TextStyle(color: MyTheme.greyColor, fontSize: 20),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(MyTheme.primaryColor)),
                        onPressed: () {
                          validateForm();
                        },
                        child: const Text(
                          'Add Room',
                          style: TextStyle(color: Colors.white),
                        ))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void validateForm() {
    if(formKey.currentState?.validate()==true){

      viewModel.createRoom(titleController.text, descController.text, selectCategory.id);

    }
  }

  @override
  hideLoading() {
   utils.hideLoading(context);
  }

  @override
  showLoading() {
   utils.showLoading(context);
  }

  @override
  showMessage(String message) {
 utils.showMessage(context,message,  'ok' , (context){
   Navigator.pop(context);
 });
  }

  @override
  navigateToHome() {
    Timer(const Duration(seconds: 2),() {
      Navigator.pop(context);
    } );
  }
}
