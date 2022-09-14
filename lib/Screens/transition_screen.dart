import 'package:cinema_application/Screens/profile.dart';
import 'package:cinema_application/providers/movie_models.api.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'booked_screen.dart';
import 'main_movies.dart';

class TransitionScreen extends StatefulWidget {

  TransitionScreen({Key? key}) : super(key: key);

  @override
  _TransitionScreenState createState() => _TransitionScreenState();
}

class _TransitionScreenState extends State<TransitionScreen> {
  int selectedIndex=1;
  late List screens;
  var ctime;

  @override

  void initState() {
    super.initState();
    screens=[ProfileScreen(), MainMovies(),BookedTicketsScreen()];
  }



  @override
  Widget build(BuildContext context) {
   return WillPopScope(

     onWillPop: () {
       DateTime now = DateTime.now();
       if (ctime == null || now.difference(ctime) > Duration(seconds: 2)) {
         //add duration of press gap
         ctime = now;
         ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(backgroundColor:Colors.grey.shade900,content: Text('Press Back Button Again to Exit',style: TextStyle(color: Colors.white),))
         ); //scaffold message, you can show Toast message too.
         return Future.value(false);
       }

       return Future.value(true);
     },
     child: Scaffold(
       extendBody: true,
          body: Provider.of<MovieModelApi>(context).loading==true? screens[selectedIndex]:const Center(child: CircularProgressIndicator()),
          bottomNavigationBar: CurvedNavigationBar(
            animationDuration: Duration(milliseconds: 400),

            index: selectedIndex,
            backgroundColor: Colors.transparent,
            color: Colors.grey.shade800,
            height: 50,
            items: const <Widget>[
                Icon(Icons.person,color: Colors.white,),
                Icon(Icons.movie,color: Colors.white),
                Icon(Icons.bookmark,color: Colors.white),
            ],
            onTap: (index)=>setState(() {
              selectedIndex=index;
            }),
          ),
        ),
   );
  }
}
