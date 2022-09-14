class MovieCastModel{
  String name;
  String image;

  MovieCastModel({required this.name,required this.image});

  static MovieCastModel fromJason(Map<String,dynamic> jason){
    return MovieCastModel(name: jason["Name"],image:  jason["image"]);
  }

  Map<String,dynamic> toJason(){
    return {
      'name': name,
      'Image': image,
    };
  }
}