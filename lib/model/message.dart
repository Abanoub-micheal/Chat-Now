class Message{
  static const String collectionName='message';
  String id;
  String roomId;
  String content;
  String senderId;
  String senderName;
  int dateTime;

  Message({ this.id='',required this.roomId,required this.content,required this.senderId,required this.senderName,required this.dateTime});

  factory Message.fromFirebase(Map<String,dynamic> data){
    return Message(id: data['id'] as String,
        roomId: data['room_id'] as String,
        content: data['content'] as String,
        senderId: data['sender_id'] as String,
        senderName: data['senderName'] as String,
        dateTime: data['date_time']as int);
  }
  Map<String,dynamic>toFirebase(){
    return {
      'id':id,
          'room_id':roomId,
          'content':content,
          'sender_id':senderId,
          'senderName':senderName,
          'date_time':dateTime
    };

  }





}