import 'package:cinema_application/data/profileData.dart';
import 'package:cinema_application/models/ticket.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookedTicketsScreen extends StatefulWidget {
  @override
  State<BookedTicketsScreen> createState() => _BookedTicketsScreenState();
}

class _BookedTicketsScreenState extends State<BookedTicketsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              title: const Text("Booked Tickets"),
              leading: IconButton(
                  onPressed:() {
                  },
                  icon:const Icon(Icons.arrow_back)),
            ),
            backgroundColor: Colors.grey[900],
            body: SingleChildScrollView(
              child: StreamBuilder<List<Ticket>>(
                stream: readTickets(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text("Something went wrong");
                  }
                  else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    final tickets = snapshot.data!;
                    return Column(
                      children:
                      tickets.map(buildTicket).toList(),
                    );
                  }
                  else {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:const [
                          SizedBox(height: 270,),
                           Text("No Tickets", style: TextStyle(color: Colors.white,fontSize: 50, fontWeight: FontWeight.bold),),
                      ]),
                    );
                  }
                },
              ),
            ),
          );
        }
  }

  Widget buildTicket(Ticket ticket) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          color: Colors.grey[800],),
        height: 125,
        child: Row(
          children: [
            ClipRRect(
              child: Image.network(ticket.image),
            ),
            const SizedBox(width: 25,),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Text(ticket.title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2, textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.white, fontSize: 25),),
                    ),
                  ),
                  const SizedBox(height: 15,),
                  Expanded(flex: 1, child: Center(
                    child: Text(ticket.dateOfBooking,
                      style: const TextStyle(color: Colors.white, fontSize: 20),),
                  ),)
                ],
              ),
            ),
            const SizedBox(width: 40,),
            Column(
              children: [
                Container(
                  color: Colors.orangeAccent,
                  height: 20,
                  width: 5,
                ),
                const SizedBox(height: 6,),
                Container(
                  color: Colors.orangeAccent,
                  height: 20,
                  width: 5,
                ),
                const SizedBox(height: 6,),
                Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Color(0xffff5983), Colors.orangeAccent,],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter)
                  ),
                  height: 20,
                  width: 5,
                ),
                const SizedBox(height: 6,),
                Container(
                  color: const Color(0xffff5983),
                  height: 20,
                  width: 5,
                ),
                const SizedBox(height: 6,),
                Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.deepOrangeAccent, Color(0xffff5983),],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter)
                  ),
                  height: 20,
                  width: 5,
                ),
              ],
            ),
            Expanded(child: Center(child: Text(ticket.seatCount.toString(),
              style: const TextStyle(color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold),)),

            ),
            Container(
              height: 60,
              width: 20,
              decoration: BoxDecoration(borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  topLeft: Radius.circular(30)),
                color: Colors.grey[900],),
            )
          ],
        ),
      ),
    );
  }

Stream<List<Ticket>>readTickets(){
  return FirebaseFirestore.instance.collection(emailAddress +" Tickets").snapshots().map((snapshot) => snapshot.docs.map((doc)=>Ticket.fromJason(doc.data())).toList());
}
