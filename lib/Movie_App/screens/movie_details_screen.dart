import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:state_management/Movie_App/common/utils.dart';
import 'package:state_management/Movie_App/models/movie_detail_model.dart';
import 'package:state_management/Movie_App/services/api_services.dart';

class MovieDetailScreen extends StatefulWidget {
  final int movieId;
  const MovieDetailScreen({super.key, required this.movieId});

  @override
  MovieDetailScreenState createState() => MovieDetailScreenState();
}

class MovieDetailScreenState extends State<MovieDetailScreen> {
  ApiServices apiServices = ApiServices();

  late Future<MovieDetailModel> movieDetail;
  // late Future<MovieRecommendationsModel> movieRecommendationModel;

  @override
  void initState() {
    fetchInitialData();
    super.initState();
  }

  fetchInitialData() {
    movieDetail = apiServices.getMovieDetail(widget.movieId);
    // movieRecommendationModel =
    //     apiServices.getMovieRecommendations(widget.movieId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    print(widget.movieId);
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: Text('Movie Details'),
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: movieDetail,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final movie = snapshot.data;
        
                String genresText =
                movie!.genres!.map((genre) => genre.name).join(', ');
        
                return Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: size.height * 0.4,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "$imageUrl${movie.posterPath}"),
                                  fit: BoxFit.cover)),
                          child: SafeArea(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.arrow_back_ios,
                                      color: Colors.white),
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
                      padding:
                      const EdgeInsets.only(top: 7, left: 10, right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                movie.title!,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(onPressed: (){}, icon: Icon(Icons.bookmark_add_sharp),
                                iconSize: 40.0, ),
                            ],
                          ),
        
                          SizedBox(height: 5),
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
                          SizedBox(height: 8),
                          // IMDB Rating and Icon
                           Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber),
                              SizedBox(width: 4),
                              Text(
                                  '${movie.imdbId!} IMDB',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
        
                          // Movie Info (Length, Language, Rating)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
        
        
        
                              Column(
                                children: [
                                  const Text( 'Length' ,
                                      style: TextStyle(fontSize: 16)),
                                  Text( '${movie.runtime!} Min' ,
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                ],
                              ),
        
                              Column(
                                children: [
                                  Text('Language',
                                      style: TextStyle(fontSize: 16)),
                                  Text('${movie.originalLanguage}',
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                ],
                              ),
                              Column(
                                children: [
                                  Text('Rating',
                                      style: TextStyle(fontSize: 16)),
                                  Text('${movie.popularity}',
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ],
                          ),
        
        
        
                          const SizedBox(height: 15),
        


        
                              const Text('Description',
                                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

                          const SizedBox(height: 7),
        
                            Text(
                              '${movie.overview}',
                              maxLines: 6,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 16, color: Colors.black, fontWeight:  FontWeight.w100),
        

                            ),
        
                      ],

        

                      ),
                    ),
        
        
        
        
        
        
        
        
        
        
        
                    // FutureBuilder(
                    //     future: movieRecommendationModel,
                    //     builder: (context, snapshot) {
                    //       if (snapshot.hasData) {
                    //         final movie = snapshot.data;
                    //
                    //         return GridView.builder(
                    //           physics: const NeverScrollableScrollPhysics(),
                    //           shrinkWrap: true,
                    //           padding: EdgeInsets.zero,
                    //           scrollDirection: Axis.vertical,
                    //           itemCount: movie!.results.length,
                    //           gridDelegate:
                    //           const SliverGridDelegateWithFixedCrossAxisCount(
                    //               crossAxisCount: 3,
                    //               childAspectRatio: 1.5 / 2),
                    //           itemBuilder: (context, index) {
                    //             return CachedNetworkImage(
                    //               imageUrl:
                    //               "$imageUrl${movie.results[index].posterPath}",
                    //             );
                    //           },
                    //         );
                    //       }
                    //       return const Text("Something Went wrong");
                    //     }),
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