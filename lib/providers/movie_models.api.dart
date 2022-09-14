import 'dart:convert';
import 'package:cinema_application/models/movie_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class MovieModelApi with ChangeNotifier{
  List<MovieModel> MovieData=[];
  bool loading=false;

  MovieModelApi(){
    getData();
  }

  Future<void> getData()async{
    final m=await getMovie('tt1375666');
    final m2=await getMovie('tt4154796');
    final m3=await getMovie('tt0114709');
    final m5=await getMovie('tt0396555');
    final m6=await getMovie('tt0468569');

    MovieData.add(m);
    MovieData.add(m2);
    MovieData.add(m3);
    MovieData.add(m5);
    MovieData.add(m6);

    loading=true;

    notifyListeners();
  }

  Future<MovieModel> getMovie(String imdbId) async {
    var uri = Uri.https('movie-details1.p.rapidapi.com', '/imdb_api/movie',
        { "id":imdbId });
    final response = await http.get(uri, headers: {
      "X-RapidAPI-Key": "b50bc7f278msh58dfd2aba4fe02bp105a47jsn40ad2eca9ed6",
      "X-RapidAPI-Host": "movie-details1.p.rapidapi.com",
      "useQueryString": "true"
    });

    final data = jsonDecode(response.body);

    MovieModel M=MovieModel.moviesFromSnapshot(data);
    return M;
  }
}