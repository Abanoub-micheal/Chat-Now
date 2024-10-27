class Room {
  static const String collectionName= 'rooms';
  String idRoom;
  String title;
  String description;
  String categoryId;
  Room(
      {required this.idRoom,
      required this.title,
      required this.description,
      required this.categoryId});

  factory Room.fromFirebase(Map<String, dynamic> room) {
    return Room(
        idRoom: room['idRoom'],
        title: room['title'],
        description: room['description'],
        categoryId: room['categoryId']);
  }
  Map<String,dynamic>toFirebase(){
    return {
      'idRoom': idRoom,
      'title':title,
      'description':description,
      'categoryId':categoryId
    };
  }
}
