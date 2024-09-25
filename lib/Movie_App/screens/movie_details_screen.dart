import 'package:flutter/material.dart';
import 'package:state_management/Movie_App/Data/db_handler.dart';
import 'package:state_management/Movie_App/common/utils.dart';
import 'package:state_management/Movie_App/models/bookmarkModel.dart';
import 'package:state_management/Movie_App/models/movie_detail_model.dart';
import 'package:state_management/Movie_App/models/now_paying_movie_model.dart';
import 'package:state_management/Movie_App/services/api_services.dart';
import 'package:state_management/SqfLite/model_class.dart';

class MovieDetailScreen extends StatefulWidget {
  final int movieId;
  const MovieDetailScreen({super.key, required this.movieId});

  @override
  MovieDetailScreenState createState() => MovieDetailScreenState();
}

class MovieDetailScreenState extends State<MovieDetailScreen> {
  ApiServices apiServices = ApiServices();

  final DbHandler _dbHandler = DbHandler(); // Instantiate DbHandler

  // Check if a movie is already bookmarked
  Future<bool> isBookmarked(int? id) async {
    final List<Map<String, dynamic>> movies = await _dbHandler.getData(); // Get data from the database
    return movies.any((movie) => movie['id'] == id); // Check if any movie has the same ID
  }

  late Future<MovieDetailModel> movieDetail;

  @override
  void initState() {
    fetchInitialData();
    super.initState();
  }

  fetchInitialData() {
    movieDetail = apiServices.getMovieDetail(widget.movieId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder<MovieDetailModel>(
            future: movieDetail,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final movie = snapshot.data;

                String genresText = movie!.genres!.map((genre) => genre.name).join(', ');

                return Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: size.height * 0.4,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage("$imageUrl${movie.posterPath}"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: SafeArea(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 7, left: 10, right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  movie.title!,
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              FutureBuilder<bool>(
                                future: isBookmarked(movie.id),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return const CircularProgressIndicator(); // Loading while checking the bookmark status
                                  }
                                  bool isBookmarked = snapshot.data ?? false;
                                  return IconButton(
                                    icon: Icon(
                                      Icons.bookmark_add_sharp,
                                      color: isBookmarked ? Colors.teal : Colors.grey, // Yellow if bookmarked, grey otherwise
                                    ),
                                    iconSize: 40.0,
                                    onPressed: () async {
                                      await DbHandler().insertData(
                                        movie.id,
                                        movie.title,
                                        movie.imdbId,
                                        movie.posterPath,
                                        movie.runtime,
                                      );
                                      setState((){

                                      });
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Text(
                                genresText,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.star, color: Colors.amber),
                              const SizedBox(width: 4),
                              Text(
                                '${movie.imdbId!} IMDB',
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  const Text('Length', style: TextStyle(fontSize: 16)),
                                  Text('${movie.runtime!} Min',
                                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                ],
                              ),
                              Column(
                                children: [
                                  const Text('Language', style: TextStyle(fontSize: 16)),
                                  Text('${movie.originalLanguage}',
                                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                ],
                              ),
                              Column(
                                children: [
                                  const Text('Rating', style: TextStyle(fontSize: 16)),
                                  Text('${movie.popularity}',
                                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          const Text(
                            'Description',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 7),
                          Text(
                            '${movie.overview}',
                            maxLines: 6,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
