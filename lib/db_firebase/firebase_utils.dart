import 'package:chat_appame/model/my_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/message.dart';
import '../model/room.dart';

class FirebaseUtils {
  static CollectionReference<MyUser> getUserCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collection)
        .withConverter<MyUser>(
          fromFirestore: (snapshot, options) =>
              MyUser.fromJson(snapshot.data()!),
          toFirestore: (user, options) => user.toJson(),
        );
  }

  static CollectionReference<Room> getRoomCollection() {
    return FirebaseFirestore.instance
        .collection(Room.collectionName)
        .withConverter<Room>(
          fromFirestore: (snapshot, options) =>
              Room.fromFirebase(snapshot.data()!),
          toFirestore: (room, options) => room.toFirebase(),
        );
  }

  static CollectionReference<Message> getMessageCollection(String roomId) {
    return FirebaseFirestore.instance
        .collection(Room.collectionName)
        .doc(roomId)
        .collection(Message.collectionName)
        .withConverter(
      fromFirestore: (snapshot, options) {
        return Message.fromFirebase(snapshot.data()!);
      },
      toFirestore: (message, options) {
        return message.toFirebase();
      },
    );
  }

  static Future<void> registerUser(MyUser user) async {
    return getUserCollection().doc(user.id).set(user);
  }

  static Future<MyUser?> getUserData(String userId) async {
    var documentSnapshot = await getUserCollection().doc(userId).get();
    return documentSnapshot.data();
  }

  static Future<void> addRoom(Room room) {
    var docRef = getRoomCollection().doc();
    room.idRoom = docRef.id;
    return docRef.set(room);
  }

  static Stream<QuerySnapshot<Room>> getRooms() {
    var streamQuery = getRoomCollection().snapshots();
    return streamQuery;
  }

  static Future <void> insertMessage(Message message)async{
    var messageCollection= getMessageCollection(message.roomId);
    var docRef=messageCollection.doc();
    message.id= docRef.id;
   return docRef.set(message);
  }
  
  static Stream<QuerySnapshot<Message>>retriveMessages(String roomId){
   return  getMessageCollection(roomId).orderBy('date_time').snapshots();
    

  }
}
