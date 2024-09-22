import 'package:flutter/material.dart';
import 'package:state_management/Movie_App/common/utils.dart';
import 'package:state_management/Movie_App/models/now_paying_movie_model.dart';

class NowPlayingMovieCard extends StatelessWidget {
  final List<Results> nowPlayingMovies; // List of now playing movies
  final String headlineText; // Title of the section
  final ScrollController scrollController; // Scroll controller for pagination
  final bool isLoading; // Loading state indicator

  const NowPlayingMovieCard(BuildContext context, {
    super.key,
    required this.nowPlayingMovies,
    required this.headlineText,
    required this.scrollController,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section title
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              headlineText,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),

          // Horizontal list view for movies
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: nowPlayingMovies.length + 1, // Add 1 for loading spinner
              itemBuilder: (context, index) {
                // Display movie poster if within bounds
                if (index < nowPlayingMovies.length) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        '$imageUrl${nowPlayingMovies[index].posterPath}',
                        fit: BoxFit.cover,
                        width: 120,
                      ),
                    ),
                  );
                }
                // Display loading spinner at the end
                else if (isLoading) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: SizedBox(
                        width: 40,
                        height: 40,
                        child: CircularProgressIndicator(
                          strokeWidth: 4,
                        ),
                      ),
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}



// return FutureBuilder<NowPlayingMovieModel>(
    //     future: future,
    //     builder: (context, snapshot) {
    //       if (snapshot.hasData) {
    //         var data = snapshot.data?.results;
    //         return Padding(
    //             padding: const EdgeInsets.all(15.0),
    //             child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   Text(
    //                     headlineText,
    //                   ),
    //                   const SizedBox(
    //                     height: 20,
    //                   ),
    //                   Expanded(
    //                     child: ListView.builder(
    //                       shrinkWrap: true,
    //                       padding: const EdgeInsets.all(3),
    //                       scrollDirection: Axis.horizontal,
    //                       itemCount: data!.length,
    //                       itemBuilder: (context, index) {
    //                         return Padding(
    //                           padding: const EdgeInsets.all(5.0),
    //                           child: Image.network(
    //                             '$imageUrl${data[index].posterPath}',
    //                             fit: BoxFit.fitHeight,
    //                           ),
    //                         );
    //                       },
    //                     ),
    //                   )
    //                 ]));
    //       } else {
    //         return const SizedBox.shrink();
    //       }
    //     });
