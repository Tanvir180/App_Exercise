import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:state_management/Movie_App/common/utils.dart';
import 'package:state_management/Movie_App/models/now_paying_movie_model.dart';
import 'package:state_management/Movie_App/models/search_model.dart';
import 'package:state_management/Movie_App/models/upcommingmoviemodel.dart';

const baseUrl = 'https://api.themoviedb.org/3/';
var key = '?api_key=$apiKey';
late String endPoint;

class ApiServices {
  // Fetch upcoming movies with pagination (10 per page)
  Future<UpcomingMovieModel> getUpcomingMovies({int? page}) async {
    endPoint = 'movie/upcoming';
    final url = '$baseUrl$endPoint$key&page=$page';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      log('Success fetching upcoming movies, page: $page');
      return UpcomingMovieModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('Failed to load upcoming movies');
  }

  // Fetch now playing movies with pagination (10 per page)
  Future<NowPlayingMovieModel> getNowPlayingMovies({int? page}) async {
    endPoint = 'movie/now_playing';
    final url = '$baseUrl$endPoint$key&page=$page';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      log('Success fetching now playing movies, page: $page');
      return NowPlayingMovieModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('Failed to load now playing movies');
  }

  // Example method to fetch other types of data like popular movies (with pagination)
  Future<void> getPopularMovies({int page = 1}) async {
    endPoint = 'movie/popular';
    final url = '$baseUrl$endPoint$key&page=$page';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      log('Success fetching popular movies, page: $page');
    } else {
      throw Exception('Failed to load popular movies');
    }
  }

  Future<SearchModel> getSearchedMovie(String searchText) async {
    endPoint = 'search/movie?query=$searchText';
    final url = '$baseUrl$endPoint';
    print(url);
    final response = await http.get(Uri.parse(url),
        headers: {
      'Authorization':
      'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkYjg3MWNkNjBkN2JlZTI3MzM4MTVlNGEwNGE4MThlOSIsIm5iZiI6MTcyNjk4NzMyNS41MDg2MzQsInN1YiI6IjY2ZWJmYzJhZTQzZjA3ZGU4MmViOTFhMSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.lkQLDJNZtsp1-aOwFRa9Y84ajdWhim5PiW-A5q5tbx0'
    });
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      log('success');
      return SearchModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load  search movie ');
  }



}
