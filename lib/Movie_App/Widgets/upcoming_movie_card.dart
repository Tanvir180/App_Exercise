import 'package:flutter/material.dart';
import 'package:state_management/Movie_App/common/utils.dart';
import 'package:state_management/Movie_App/models/upcommingmoviemodel.dart';
import 'package:state_management/Movie_App/screens/movie_details_screen.dart';

class UpcomingMovieCard extends StatelessWidget {
  final List<Results> upComingMovies; // List of now playing movies
  final String headlineText; // Title of the section
  final ScrollController scrollController; // Scroll controller for pagination
  final bool isLoading; // Loading state indicator

  const UpcomingMovieCard(BuildContext context, {
    super.key,
    required this.upComingMovies,
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
              itemCount: upComingMovies.length + 1, // Add 1 for loading spinner
              itemBuilder: (context, index) {
                // Display movie poster if within bounds
                if (index < upComingMovies.length) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: (){
                        // print("pressed");
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> MovieDetailScreen(movieId: upComingMovies[index].id!)
                          ,));
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(
                          '$imageUrl${upComingMovies[index].posterPath}',
                          fit: BoxFit.cover,
                          width: 120,
                        ),
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











//     return FutureBuilder<UpcomingMovieModel>(
//         future: future,
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             var data = snapshot.data?.results;
//             return Padding(
//                 padding: const EdgeInsets.all(5.0),
//                 child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(headlineText,),
//                       const SizedBox(height: 20,),
//                       Expanded(
//                         child: ListView.builder(
//                           shrinkWrap: true,
//                           padding: const EdgeInsets.all(3),
//                           scrollDirection: Axis.horizontal,
//                           itemCount: data!.length,
//                           itemBuilder: (context, index) {
//                             return Padding(
//                               padding: const EdgeInsets.all(5.0),
//                               child: Image.network('$imageUrl${data[index].posterPath}',
//                                 fit: BoxFit.fitHeight,
//                               ),
//                             );
//                           },
//                         ),
//                       )
//                     ]));
//           } else {
//             return const SizedBox.shrink();
//           }
//         });
//   }
// }