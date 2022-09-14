import 'package:cinema_application/Screens/MultiSelect.dart';
import 'package:cinema_application/components/default_border.dart';
import 'package:cinema_application/models/cast_model.dart';
import 'package:cinema_application/models/movie_model.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_scroll_to_top/flutter_scroll_to_top.dart';
import 'package:cinema_application/components/gradient_button.dart';
import 'package:cinema_application/models/review.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:profanity_filter/profanity_filter.dart';
import '../data/profileData.dart';

class MovieScreen extends StatefulWidget {
  final String title;
  final String image;
  final num rating;
  final String genre;
  final String description;
  final String id;
  final String runtime;
  final String url;


  const MovieScreen(
      {Key? key,required this.url, required this.runtime, required this.id, required this.title, required this.image, required this.rating, required this.genre, required this.description,})
      : super(key: key);

  @override
  State<MovieScreen> createState() => _MovieScreenState();

}

class _MovieScreenState extends State<MovieScreen> {

  final DateRangePickerController _controller = DateRangePickerController();
  String Error = "";
  bool s1 = false;
  bool s2 = false;
  bool s3 = false;
  late String time;
  final revKey = GlobalKey<FormFieldState>();
  final controller = TextEditingController();
  final filter = ProfanityFilter();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(
          widget.title.toString(),
          style: const TextStyle(color: Colors.white),),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Stack(
        children: [
          Container(
            child: Image.network(widget.image,
              fit: BoxFit.fill,
            ),
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.image),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.6), BlendMode.dstATop),
                  //image: widget.image,
                )
            ),
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Colors.black.withAlpha(0),
                  Colors.black12,
                  Colors.black45,
                  Colors.black54,
                  Colors.black,
                  Colors.black,
                ],
              ),
            ),
          ),
          SafeArea(
            child: ScrollWrapper(
              scrollOffsetUntilVisible: 20,
              scrollOffsetUntilHide: 10,
              promptAnimationType: PromptAnimation.scale,
              promptAlignment: Alignment.topCenter,
              builder: (context, properties) =>
                  ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 15, 15, 20.0),
                        child: Container(
                          child: Image.network(widget.image),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(
                                40.0)),
                          ),
                          height: 300,
                          width: 250,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.star, size: 20, color: Colors.orangeAccent,),
                          Text(widget.rating.toString() + " | ",
                            style: const TextStyle(
                                color: Colors.white60, fontSize: 20),),
                          const Icon(
                            Icons.timer, size: 20, color: Colors.white60,),
                          const Text("148""Minutes | ", style: TextStyle(
                              color: Colors.white60, fontSize: 20)),
                          const Icon(
                            Icons.movie, size: 20, color: Colors.white60,),
                          Text(widget.genre.toString(), style: const TextStyle(
                              color: Colors.white60, fontSize: 20)),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          gradientButton(
                            radius:30,
                            first: const Color(0xffff5983),
                            second: Colors.orangeAccent,
                            text: "Book Ticket",
                            textColor: Colors.white,
                            fontSize: 15,
                            function: () {
                              var movie = MovieModel(title: widget.title,
                                  genre: widget.genre,
                                  id: widget.id,
                                  rating: widget.rating,
                                  runtime: widget.runtime,
                                  storyLine: widget.description,
                                  image: widget.image);

                              showDialog(context: context,
                                  builder: (context) =>
                                      StatefulBuilder(
                                          builder: (context, setState) =>
                                              AlertDialog(
                                                backgroundColor: Colors.grey[800],
                                                  content:
                                              Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const Text("Date and Party",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight
                                                            .bold,
                                                        fontSize: 30),),
                                                  const SizedBox(height: 5,),
                                                  SizedBox(
                                                    height: 300,
                                                    width: 400,
                                                    child: SfDateRangePicker(
                                                      controller: _controller,
                                                      view: DateRangePickerView.month,
                                                      minDate: DateTime(
                                                          2022, 08, 30),
                                                      maxDate: DateTime(
                                                          2022, 09, 30),
                                                      enablePastDates: false,
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: InkWell(
                                                          onTap: () {
                                                            s1 = true;
                                                            s2 = false;
                                                            s3 = false;
                                                            time = "10:30";
                                                            setState(() {});
                                                          },
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius
                                                                    .circular(
                                                                    5),
                                                                color: s1 ==
                                                                    false
                                                                    ? Colors
                                                                    .orangeAccent
                                                                    : const Color(
                                                                    0xffff5983)),
                                                            height: 50,
                                                            width: 100,
                                                            child: const Center(
                                                              child: Text(
                                                                "10:30",
                                                                style: TextStyle(
                                                                    fontWeight: FontWeight
                                                                        .bold),),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(width: 8),
                                                      Expanded(
                                                        child: InkWell(
                                                          onTap: () {
                                                            s2 = true;
                                                            s1 = false;
                                                            s3 = false;
                                                            time = "1:30";
                                                            setState(() {});
                                                          },
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius
                                                                    .circular(
                                                                    5),
                                                                color: s2 ==
                                                                    false
                                                                    ? Colors
                                                                    .orangeAccent
                                                                    : const Color(
                                                                    0xffff5983)),
                                                            height: 50,
                                                            width: 100,
                                                            child: const Center(
                                                              child: Text(
                                                                "1:30",
                                                                style: TextStyle(
                                                                    fontWeight: FontWeight
                                                                        .bold),),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(width: 8),
                                                      Expanded(
                                                        child: InkWell(
                                                          onTap: () {
                                                            s3 = true;
                                                            s2 = false;
                                                            s1 = false;
                                                            time = "4:30";
                                                            setState(() {});
                                                          },
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius
                                                                    .circular(
                                                                    5),
                                                                color: s3 ==
                                                                    false
                                                                    ? Colors
                                                                    .orangeAccent
                                                                    : const Color(
                                                                    0xffff5983)),
                                                            height: 50,
                                                            width: 100,
                                                            child: const Center(
                                                              child: Text(
                                                                "4:30",
                                                                style: TextStyle(
                                                                    fontWeight: FontWeight
                                                                        .bold),),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 10,),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 3,
                                                        child: Text(Error,
                                                          style: const TextStyle(
                                                              color: Colors.red,
                                                              fontWeight: FontWeight
                                                                  .bold),),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Padding(
                                                          padding: const EdgeInsets
                                                              .fromLTRB(
                                                              17, 0, 0, 0),
                                                          child: IconButton(
                                                            onPressed: () {
                                                              if (s1 == false &&
                                                                  s2 == false &&
                                                                  s3 == false &&
                                                                  _controller
                                                                      .selectedDate
                                                                      .toString() ==
                                                                      "null") {
                                                                Error =
                                                                " Choose a Date and a Party";
                                                                setState(() {});
                                                              }
                                                              else
                                                              if (_controller
                                                                  .selectedDate
                                                                  .toString() ==
                                                                  "null") {
                                                                Error =
                                                                " Choose a Date";
                                                                setState(() {});
                                                              }
                                                              else
                                                              if (s1 == false &&
                                                                  s2 == false &&
                                                                  s3 == false) {
                                                                Error =
                                                                " Choose a Party";
                                                                setState(() {});
                                                              }
                                                              else {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (
                                                                            context) =>
                                                                            MultiSelectscreen(
                                                                                movie: movie,
                                                                                titleDateParty: movie
                                                                                    .title +
                                                                                    " " +
                                                                                    _controller
                                                                                        .selectedDate
                                                                                        .toString() +
                                                                                    " " +
                                                                                    time)
                                                                    ));
                                                              }
                                                            },
                                                            icon: const Icon(
                                                                Icons
                                                                    .arrow_circle_right_outlined),
                                                            iconSize: 50,),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              )
                                              )
                                      ));
                            },
                          ),

                          const SizedBox(width: 10,),
                          ElevatedButton(
                              onPressed: () {
                                final Uri url = Uri.parse(widget.url);
                                _launchUrl(url);
                              },
                              child: Row(
                                children: const[
                                  Icon(Icons.play_arrow_rounded,
                                    color: Colors.black,),
                                  Text("Watch trailer", style: TextStyle(
                                      color: Colors.black54),),
                                ],
                              ),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  minimumSize: const Size(130, 50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  )
                              )
                          )
                        ],
                      ),
                      const SizedBox(height: 30,),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                        child: Text("Synopsis", style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(38, 20, 38, 20),
                        child: ReadMoreText(
                          widget.description.toString(),
                          style: const TextStyle(
                              fontSize: 20, color: Colors.white),
                          colorClickableText: Colors.orangeAccent,
                          trimLines: 4,
                          trimMode: TrimMode.Line,
                          trimExpandedText: ' Less',
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(25, 10, 0, 20),
                        child: Text("Cast & Crew", style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),),
                      ),

                      StreamBuilder<List<MovieCastModel>>(
                          stream: readCast(widget.title.toString() + "Cast"),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return const Padding(
                                padding: EdgeInsets.fromLTRB(30, 0, 0, 10),
                                child: Text("Something went wrong"),
                              );
                            }
                            else if (snapshot.hasData) {
                              final castMembers = snapshot.data!;
                              return Padding(
                                padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                                child: SizedBox(
                                  height: 200,
                                  child: ListView(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    children:
                                    castMembers.map(buildActor).toList(),
                                  ),
                                ),
                              );
                            }
                            else {
                              return const Center(
                                child: CircularProgressIndicator());
                            }
                          }),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(25, 10, 0, 20),
                        child: Text("Reviews", style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),),
                      ), Padding(
                        padding: const EdgeInsets.fromLTRB(30, 10, 30, 30.0),
                        child: TextFormField(
                            key: revKey,
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return "Can't post an empty review";
                              }
                              if (filter.hasProfanity(value)) {
                                return "Profanity detected, cannot submit review.";
                              }
                              return null;
                            },
                            style: const TextStyle(color: Colors.white),
                            controller: controller,
                            decoration: InputDecoration(
                              focusedErrorBorder: defaultBorder(c: Colors.red),
                              errorBorder: defaultBorder(),
                              focusedBorder: defaultBorder(),
                              enabledBorder: defaultBorder(),
                              disabledBorder: defaultBorder(),
                              suffixIcon: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    0, 0, 5, 0),
                                child: InkWell(
                                  onTap: () {
                                    final isValidRev = revKey.currentState!
                                        .validate();
                                    if (isValidRev) {
                                      String name = username;
                                      String comment = controller.text;

                                      createReview(name: name,
                                          comment: comment,
                                          title: widget.title.toString());
                                      controller.clear();
                                    }
                                  },
                                  child: Container(
                                    height: 30,
                                    width: 30,
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(30),
                                          topRight: Radius.circular(30),),
                                        color: Colors.white),
                                    child: const Center(
                                      child: Icon(
                                        Icons.double_arrow,
                                        color: Colors.orangeAccent,),
                                    ),
                                  ),
                                ),
                              ),
                              hintText: "  Write a Review...",
                              hintStyle: const TextStyle(color: Colors.grey),

                            )
                        ),
                      ),
                      StreamBuilder<List<Review>>(
                        stream: readReviews(widget.title.toString()),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return const Text("Something went wrong");
                          }
                          else if (snapshot.hasData) {
                            final reviews = snapshot.data!;
                            return Column(
                              children:
                              reviews.map(buildReview).toList(),
                            );
                          }
                          else {
                            return const Text("No Reviews", style: TextStyle(
                                color: Colors.white),);
                          }
                        },
                      ),
                    ],
                  ),
            ),
          ),
        ],
      ),
    );
  }
}


Widget buildReview(Review review) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(36,0,36,20),
    child: Column(
      children: [
        Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 80,
                width: 80,
                child: const Icon(Icons.person, color: Colors.white,),
                decoration:const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: [
                    Color(0xffff5983),
                    Colors.deepOrangeAccent,
                    Colors.orangeAccent
                  ]),

                  //Colors.pinkAccent
                ),
              ),
              const SizedBox(width: 20,),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(review.name,style: const TextStyle(color: Colors.white,fontSize: 20)),
                    ReadMoreText(
                      review.comment,
                      style: const TextStyle(color: Colors.white70,fontSize: 19,),
                      trimLines: 2,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: 'More',
                      trimExpandedText: 'Show less',
                      colorClickableText: Colors.orangeAccent,
                    ),
                  ],
                ),
              ),
            ],
          ),

        const SizedBox(height: 20,),
        const Divider(color: Colors.white,thickness: 1,indent: 10,endIndent: 10,)
      ],
    ),
  );
}

Stream<List<Review>>readReviews(String title){
  return FirebaseFirestore.instance.collection(title).snapshots().map((snapshot) => snapshot.docs.map((doc)=>Review.fromJason(doc.data())).toList());
}

Future createReview({required String name,required String comment,required String title}) async{
  final docRev=FirebaseFirestore.instance.collection(title).doc();
  final rev=Review(name, comment);
  final jason=rev.toJason();
  docRev.set(jason);
}

Stream<List<MovieCastModel>>readCast(String title){
  return FirebaseFirestore.instance.collection(title).snapshots().map((snapshot) => snapshot.docs.map((doc)=>MovieCastModel.fromJason(doc.data())).toList());
}

Future<void> _launchUrl(url) async {
  if (!await launchUrl(url)) {
    throw 'Could not launch $url';
  }
}

Widget buildActor(MovieCastModel cast) {
  return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SizedBox(
        width: 150,
        child: Stack(
          children: [
            Positioned(
              child: Container(
                height: 130,
                width: 130,
                decoration:  const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: [Color(0xffff5983),Colors.deepOrangeAccent,Colors.orangeAccent]),
                  //Colors.pinkAccent
                ),
              ),
              top: 0,
              left: 0,
            ),

            Positioned(
              left: 5,
              top: 5,
              child: Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(cast.image),
                      minRadius: 60,
                    ),

                    const SizedBox(height: 10,),
                    SizedBox(width:100,child: Text(cast.name,maxLines: 2 ,textAlign: TextAlign.center, style: const TextStyle(color: Colors.white),))
                  ]
              ),
            ),
          ],
        ),
      )
  );
}