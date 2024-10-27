import 'package:chat_appame/my_theme.dart';
import 'package:chat_appame/db_firebase/firebase_utils.dart';
import 'package:chat_appame/model/room.dart';
import 'package:chat_appame/ui/add_room/add_room.dart';
import 'package:chat_appame/ui/home-screen/Home_Screen%20_Navigator.dart';
import 'package:chat_appame/ui/home-screen/home_screen_view_model.dart';
import 'package:chat_appame/ui/home-screen/room_view_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home-screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    implements HomeScreenNavigator {
  var viewModel = HomeScreenViewmodel();

  @override
  void initState() {
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>viewModel,
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
              'Home',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, AddRoom.routeName);
            },
            shape: const StadiumBorder(),
            backgroundColor: MyTheme.primaryColor,
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          body: StreamBuilder<QuerySnapshot<Room>>(
            stream: FirebaseUtils.getRooms(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: CircularProgressIndicator(
                  color: MyTheme.primaryColor,
                ));
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else {
                List<Room> roomList =
                    snapshot.data?.docs.map((doc) => doc.data()).toList()??[];
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8),
                  itemCount: roomList.length,
                  itemBuilder: (context, index) {
                    return RoomWidget(room: roomList[index],);
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
