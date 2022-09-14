import 'package:cinema_application/Screens/payment.dart';
import 'package:cinema_application/data/Selected%20Seats.dart';
import 'package:cinema_application/models/movie_model.dart';
import 'package:cinema_application/models/seat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../components/gradient_button.dart';


class MultiSelectscreen extends StatefulWidget{
  MovieModel movie;
  String titleDateParty;

  MultiSelectscreen({required this.movie,required this.titleDateParty});

  @override
  State<MultiSelectscreen> createState() => _MultiSelectscreenState();
}

class _MultiSelectscreenState extends State<MultiSelectscreen> {
  bool selected=true;
  List<seat>seats=[];




  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return WillPopScope(
      onWillPop: (){
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              for (int i=0;i<selectedSeats.length;i++){
                FirebaseFirestore.instance.collection(widget.titleDateParty).doc(selectedSeats[i]).update({"status":"free"});
              }
              selectedSeats.clear();
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          title: const Text(
            "Seats", style: TextStyle(color: Colors.white),),),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 50,),
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      height: 40,
                      width: size.width * 0.65,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50),
                          ),
                          gradient: LinearGradient(
                            colors: [
                              Colors.white, Colors.transparent
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: [0, 1],
                          )
                      ),
                    ),
                    Container(
                      height: 40,
                      width: size.width * 0.55,
                      decoration: const BoxDecoration(
                        border: Border(
                            top: BorderSide(
                                width: 6,
                                color: Colors.white
                            )
                        ),
                      ),
                    ),
                  ],
                ),


                const SizedBox(height: 60,),


                StreamBuilder<List<seat>>(
                    stream: readSeats(widget.titleDateParty),
                    builder: (context, snapshot) {

                      if (snapshot.hasError) {

                        return const Padding(
                            padding: EdgeInsets.fromLTRB(30, 0, 0, 10),
                            child: Text("Something went wrong")
                        );
                      }
                      else if(snapshot.data!=null && snapshot.data!.isEmpty){
                        for (int i = 1; i <= 5; i++) {
                          int c = "a".codeUnitAt(0);
                          int end = "h".codeUnitAt(0);
                          while (c <= end) {
                            FirebaseFirestore.instance.collection(widget.titleDateParty).doc(i.toString() + String.fromCharCode(c)).set({
                              "name": i.toString() + String.fromCharCode(c),
                              "status": "free"
                            });
                            c++;
                          }
                        }
                        seats = snapshot.data!;

                      }
                      else if( snapshot.data!=null && snapshot.data!.isNotEmpty){
                        seats = snapshot.data!;

                      }
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: SizedBox(
                            height: 270,
                            child: seats.isNotEmpty? GridView(
                                primary: true,
                                addAutomaticKeepAlives: true,
                                shrinkWrap: true,
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 8,
                                  crossAxisSpacing: 2,),
                                children: seats.map(buildSeat).toList()):Center(child: CircularProgressIndicator(),)

                        ),
                      );
                    }),


                const SizedBox(height: 10,),
                const Divider(endIndent: 30,
                    indent: 30,
                    color: Colors.white,
                    thickness: 3),
                Padding(padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.circle, color: Colors.orangeAccent,
                              size: 10,),
                            Text(" Selected", style: TextStyle(
                              color: Colors.orangeAccent, fontSize: 25,),),
                          ],
                        ),
                        SizedBox(height: 20,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [

                            Icon(Icons.circle, color: Color(0xffff5983), size: 10,),
                            Text(" Taken", style: TextStyle(
                              color: Color(0xffff5983), fontSize: 25,),),
                          ],
                        ),

                      ],
                    )),
                const SizedBox(height: 30,),
                gradientButton(width: 300,
                    fontWeight: FontWeight.bold,
                    radius: 30,
                    textColor: Colors.white,
                    first: const Color(0xffff5983),
                    second: Colors.orangeAccent,
                    text: "Confirm Tickets",
                    function: () {
                      if (selectedSeats.isEmpty) {
                        selected=false;
                        setState(() {});
                      }
                      else {
                        selected=true;
                        setState(() {});
                        showModalBottomSheet(

                            isScrollControlled: true,
                            context: context,
                            builder: (context) =>
                                paymentSheet(
                                  titleDateParty: widget.titleDateParty,
                                    movie: widget.movie,
                                    countTickets: selectedSeats.length)
                        ).whenComplete((){
                          check=false;
                        });
                      }
                    }),
                const SizedBox(height: 20,),
                selected==false ? const Text("No Seats Are Selected",
                  style: TextStyle(color: Colors.redAccent, fontSize: 20),)
                    : const SizedBox(),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSeat(seat seat) {
    Color getColor() {
      if (seat.status == "free") {
        return Colors.grey.shade800;
      }
      else if (seat.status == "selected") {
        return Colors.orangeAccent;
      }
      else {
        return const Color(0xffff5983);
      }
    }
    return Card(
      child: Container(
        color: Colors.grey[900],
        child: InkWell(
          onTap: (){
            if (seat.status == "free") {
              FirebaseFirestore.instance.collection(widget.titleDateParty).doc(seat.name).update({"status": "selected"});
              selectedSeats.add(seat.name);
            }
            else if (seat.status == "selected") {
              FirebaseFirestore.instance.collection(widget.titleDateParty).doc(seat.name).update({"status": "free"});
              selectedSeats.remove(seat.name);
            }
            setState(() {});
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5)),
              color: getColor(),
            ),
           child: Center(
             child:Text(seat.name,style: const TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),)
           ),
          ),
        ),
      ),
    );
  }
}

Stream<List<seat>>readSeats(String titleDateParty) {
  return FirebaseFirestore.instance.collection(titleDateParty).snapshots().map((snapshot) => snapshot.docs.map((doc)=>seat.fromJason(doc.data())).toList());

}

