class MyUser{
  static const String collection='MyUser';
String id;
String userName;
String fullName;
String email;

MyUser({required this.id,required this.userName,required this.fullName,required this.email});

factory MyUser.fromJson(Map<String,dynamic>  json){
  return MyUser(id: json['id'], userName: json['userName'], fullName: json['fullName'], email: json['email']);

}

Map<String,dynamic>toJson(){
  return {
    'id':id,
    'userName':userName,
    'fullName':fullName,
    'email':email
  };
}









}