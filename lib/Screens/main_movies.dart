import 'package:carousel_slider/carousel_slider.dart';
import 'package:cinema_application/Screens/movie_screen.dart';
import 'package:cinema_application/components/Bubble.dart';
import 'package:cinema_application/components/gradient_button.dart';
import 'package:cinema_application/components/star_rating.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/movie_models.api.dart';

class MainMovies extends StatefulWidget {
  MainMovies({Key? key}) : super(key: key);

  @override
  _MainMoviesState createState() => _MainMoviesState();
}

class _MainMoviesState extends State<MainMovies> {

  final urlImages = [
    "https://m.media-amazon.com/images/M/MV5BMjAxMzY3NjcxNF5BMl5BanBnXkFtZTcwNTI5OTM0Mw@@._V1_FMjpg_UX1000_.jpg",
    "https://m.media-amazon.com/images/M/MV5BMTc5MDE2ODcwNV5BMl5BanBnXkFtZTgwMzI2NzQ2NzM@._V1_FMjpg_UX1000_.jpg",
    "https://m.media-amazon.com/images/M/MV5BMDU2ZWJlMjktMTRhMy00ZTA5LWEzNDgtYmNmZTEwZTViZWJkXkEyXkFqcGdeQXVyNDQ2OTk4MzI@._V1_.jpg",
    "https://m.media-amazon.com/images/M/MV5BYWNhNzcxNGEtZmYwOS00NmRiLTgwMjktMjVjZTk4MDYxMGUwXkEyXkFqcGdeQXVyNTIzOTk5ODM@._V1_FMjpg_UX1000_.jpg",
    "https://m.media-amazon.com/images/M/MV5BMTMxNTMwODM0NF5BMl5BanBnXkFtZTcwODAyMTk2Mw@@._V1_.jpg"
  ];

  final trailers = [
    "https://www.youtube.com/watch?v=YoHD9XEInc0",
    "https://www.youtube.com/watch?v=TcMBFSGVi1c",
    "https://www.youtube.com/watch?v=rNk1Wi8SvNc",
    "https://www.youtube.com/watch?v=S396-fnLldk",
    "https://www.youtube.com/watch?v=EXeTwQWrcwY",
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<MovieModelApi>(
        builder: (context, provider, _) {
          return Scaffold(
            backgroundColor: Colors.black38,
            body: Container(
              decoration: BoxDecoration(gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.grey.shade900,
                    Colors.grey.shade900,
                    Colors.pink
                  ]),),
              child:
              ListView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  const SizedBox(height:115,),

                  CarouselSlider.builder(
                    itemCount: provider.MovieData.length,
                    options: CarouselOptions(height: MediaQuery
                        .of(context)
                        .size
                        .height),
                    itemBuilder: (context, index, realIndex) =>
                        Container(
                          width: 300,
                          decoration: const BoxDecoration(color: Colors.black87,
                              borderRadius: BorderRadius.only(topRight: Radius
                                  .circular(30), topLeft: Radius.circular(
                                  30),)),

                          child: movieCard(
                              urlImages[index],
                              provider.MovieData[index].title,
                              provider.MovieData[index].genre,
                              provider.MovieData[index].rating,
                              provider.MovieData[index].runtime,
                              provider.MovieData[index].storyLine,
                              provider.MovieData[index].id,
                              trailers[index]),
                        ),
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

  Widget movieCard(String image, String title, String genre, num rating,
      String runtime, String description, String id, String url) {

    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [

          ClipRRect(borderRadius: const BorderRadius.only(
              topRight: Radius.circular(30.0), topLeft: Radius.circular(30.0)),
              child: Image.network(image, fit: BoxFit.fill,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return SizedBox(
                    height: 300, width: 300,
                    child: Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    ),
                  );
                },)),

          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: SizedBox(width: 300,
                child: Text(title, textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),)),
          ),

          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Bubble(genre, 85),
                const SizedBox(width: 5,),
                Bubble("IMDB " + rating.toString(), 85),
                const SizedBox(width: 5),
                Bubble(runtime, 85),
              ]
          ),

          const SizedBox(height: 10,),

          StarRating(rating.toDouble()),

          const SizedBox(height: 10,),

          gradientButton(
              text: "Details",
              first: const Color(0xffff5983),
              second: Colors.orangeAccent,
              radius: 30,
              width: 270,
              height: 50,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              textColor: Colors.white,
              function: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                    MovieScreen(
                      title: title,
                      image: image,
                      genre: genre,
                      rating: rating,
                      description: description,
                      id: id,
                      runtime: runtime,
                      url: url,)),);
              }
          ),
        ]
    );
  }}
