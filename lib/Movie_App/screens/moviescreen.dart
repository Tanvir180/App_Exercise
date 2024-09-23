import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:state_management/Movie_App/Widgets/custom_carosel.dart';
import 'package:state_management/Movie_App/Widgets/now_playing_movie_card.dart';
// import 'package:state_management/Movie_App/Widgets/now_playing_movie_card.dart';
// import 'package:state_management/Movie_App/Widgets/upcoming_movie_card.dart';
import 'package:state_management/Movie_App/Widgets/upcoming_movie_card.dart';

import 'package:state_management/Movie_App/models/now_paying_movie_model.dart' as NowPlaying;
import 'package:state_management/Movie_App/models/tv_series_model.dart';
import 'package:state_management/Movie_App/models/upcommingmoviemodel.dart' as Upcoming;


import 'package:state_management/Movie_App/screens/drawer.dart';
import 'package:state_management/Movie_App/screens/movie_details_screen.dart';
import 'package:state_management/Movie_App/services/api_services.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({super.key});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  ApiServices apiServices = ApiServices();

  List<NowPlaying.Results> nowPlayingMovies = [];
  List<Upcoming.Results> upComingMovies = [];
  int nowPlayingPage = 1;
  int upComingPlayingPage = 1;
  bool isLoadingNowPlaying = false;
  bool isUpComingPlaying = false;

  late Future<TvSeriesModel> topRatedSeries;  //




  final ScrollController _nowPlayingScrollController = ScrollController();
  final ScrollController _upComingScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _fetchNowPlayingMovies();
    _fetchUpComingMovies();

    topRatedSeries = apiServices.getTopRatedSeries(); //



    _nowPlayingScrollController.addListener(() {
      if (_nowPlayingScrollController.position.pixels ==
          _nowPlayingScrollController.position.maxScrollExtent) {
        _fetchNowPlayingMovies();
      }
    });
    _upComingScrollController.addListener(() {
      if (_upComingScrollController.position.pixels ==
          _upComingScrollController.position.maxScrollExtent) {
        _fetchUpComingMovies();
      }
    });
  }

  Future<void> _fetchNowPlayingMovies() async {
    if (!isLoadingNowPlaying) {
      setState(() {
        isLoadingNowPlaying = true;
      });

      final newMovies = await apiServices.getNowPlayingMovies(
          page: nowPlayingPage);
      setState(() {
        nowPlayingMovies.addAll(newMovies.results!.cast<NowPlaying.Results>());
        nowPlayingPage++;
        isLoadingNowPlaying = false;
      });
    }
  }

  Future<void> _fetchUpComingMovies() async {
    if (!isUpComingPlaying) {
      setState(() {
        isUpComingPlaying = true;
      });

      final newMovies = await apiServices.getUpcomingMovies(
          page: upComingPlayingPage);
      setState(() {
        upComingMovies.addAll(newMovies.results!.cast<Upcoming.Results>());
        upComingPlayingPage++;
        isUpComingPlaying = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset('assets/appBar.png', height: 60, width: 120),
      ),
      drawer: const DrawerScreen(),
      body: SingleChildScrollView(
        child: Column(
          children: [

            FutureBuilder<TvSeriesModel>(
              future: topRatedSeries,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return CustomCarouselSlider(data: snapshot.data!);
                }
                return const SizedBox();
              },
            ),
            
            
            NowPlayingMovieCard(
              context,
              nowPlayingMovies: nowPlayingMovies,
              headlineText: "Now Playing Movies",
              scrollController: _nowPlayingScrollController,
              isLoading: isLoadingNowPlaying,
            ),
            UpcomingMovieCard(
              context,
              upComingMovies: upComingMovies,
              headlineText: "Up Coming  Movies",
              scrollController: _upComingScrollController,
              isLoading: isUpComingPlaying,
            ),

          ],
        ),
      ),
    );
  }
}
  // Widget _buildMovieSection(BuildContext context, String headline, List<Results> movies, ScrollController scrollController, bool isLoading,)
  // {
  //   return SizedBox(
  //     height: 260,
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Padding(
  //           padding: const EdgeInsets.all(8.0),
  //           child:
  //               Text(headline, style: Theme.of(context).textTheme.titleLarge),
  //         ),
  //         Expanded(
  //           child: ListView.builder(
  //             controller: scrollController,
  //             scrollDirection: Axis.horizontal,
  //             itemCount: movies.length + 1, // Add 1 to show a loading spinner
  //             itemBuilder: (context, index) {
  //               if (index < movies.length) {
  //                 return Padding(
  //                   padding: const EdgeInsets.all(8.0),
  //                   child: Image.network(
  //                     '$imageUrl${movies[index].posterPath}',
  //                     fit: BoxFit.fitHeight,
  //                   ),
  //                 );
  //               } else if (isLoading) {
  //                 return const Center(
  //                   child: Padding(
  //                     padding: EdgeInsets.all(16.0),
  //                     child: SizedBox(
  //                       width: 50,
  //                       height: 50,
  //                       child: CircularProgressIndicator(
  //                         strokeWidth: 5,
  //                       ),
  //                     ),
  //                   ),
  //                 );
  //               } else {
  //                 return const SizedBox.shrink();
  //               }
  //             },
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }


// class _MovieScreenState extends State<MovieScreen> {
//   ApiServices apiServices = ApiServices();
//
//   late Future<UpcomingMovieModel> upcomingFuture;
//   late Future<NowPlayingMovieModel> nowPlayingFuture;
//   // late Future<TvSeriesModel> topRatedShows;
//
//   @override
//   void initState() {
//     upcomingFuture = apiServices.getUpcomingMovies();
//     nowPlayingFuture = apiServices.getNowPlayingMovies();
//     // topRatedShows = apiServices.getTopRatedSeries();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Image.asset('assets/appBar.png', height: 60, width: 120,),
//       ),
//
//       drawer: const DrawerScreen(),
//
//
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(
//                 height: 260,
//                 child: UpcomingMovieCard(future: upcomingFuture, headlineText: "UpComing Movies")),
//
//             SizedBox(
//                 height: 260,
//                 child: NowPlayingMovieCard(future: nowPlayingFuture, headlineText: "Now Playing Movies"))
//           ],
//         ),
//       ),
//     );
//   }
// }
