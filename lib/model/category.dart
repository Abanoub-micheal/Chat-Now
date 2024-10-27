class Category {
  static const String sportId='sports';
  static const String musicId='music';
  static const String moviesId='movies';
  String id;
  late String title;
  late String image;

  Category({required this.id,required this.title,required this.image});

  Category.formId(this.id){
   if(id==sportId){
     title='Sports';
     image='asset/images/sports.png';

   }
   else if(id == moviesId){
     title='Movies';
     image= 'asset/images/movies.png';
   }
   else{

     title='Music';
     image= 'asset/images/music.png';
   }
  }

  static List<Category>getCategoryList(){
   return [
     Category.formId(sportId),
     Category.formId(moviesId),
     Category.formId(musicId),
   ] ;

  }






}