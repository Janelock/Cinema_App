class seat{
  String name;
  String status;
  seat(this.name,this.status);

  static seat fromJason(Map<String,dynamic> jason){
    return seat(jason["name"],jason["status"]);
  }

  Map<String,dynamic> toJason() {
    return {
      'Seat': name,
      'Status': status,
    };
  }
}