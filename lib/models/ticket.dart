class Ticket{
  String title;
  String image;
  String dateOfBooking;
  int seatCount;

  Ticket({required this.title,required this.image,required this.dateOfBooking,required this.seatCount});

  static Ticket fromJason(Map<String,dynamic> jason){
    return Ticket(title: jason["title"],image: jason["image"],dateOfBooking:jason["dateOfBooking"],seatCount:jason["seatCount"]);
  }

  Map<String,dynamic> toJason() {
    return {
      'title': title,
      'image': image,
      'dateOfBooking': dateOfBooking,
      'seatCount': seatCount,
    };
  }
}