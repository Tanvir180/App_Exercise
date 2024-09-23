import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:state_management/Movie_App/common/utils.dart';
import 'package:state_management/Movie_App/models/search_model.dart';
import 'package:state_management/Movie_App/screens/movie_details_screen.dart';
import 'package:state_management/Movie_App/services/api_services.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  ApiServices apiServices = ApiServices();
  TextEditingController searchController = TextEditingController();
  SearchModel? searchedMovie;

  void search(String query) {
    apiServices.getSearchedMovie(query).then((results) {
      setState(() {
        searchedMovie = results;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 15, 10, 0),
              child: CupertinoSearchTextField(
                controller: searchController,
                padding: const EdgeInsets.all(13.0),
                prefixIcon: const Icon(
                  CupertinoIcons.search,
                  color: Colors.teal,
                ),
                suffixIcon: const Icon(
                  Icons.cancel,
                  color: Colors.teal,
                ),
                style: const TextStyle(color: Colors.black),
                backgroundColor: Colors.grey.withOpacity(0.3),
                onChanged: (value) {
                  if (value.isEmpty) {
                  } else {
                    search(searchController.text);
                  }
                },
              ),
            ),
            searchedMovie == null
                ? const SizedBox.shrink()
                : Expanded(
                    // child: Center(
                    //   child: ListView.builder(
                    //     shrinkWrap: true,
                    //     itemCount: searchedMovie?.results?.length ?? 0,
                    //     itemBuilder: (context, i) {
                    //       return Card(
                    //         color: const Color(0xFFE0E0E0), // Use a valid color
                    //         child: ListTile(
                    //           leading: CachedNetworkImage(
                    //             imageUrl:
                    //                 '$imageUrl${searchedMovie!.results?[i].backdropPath}',
                    //             errorWidget: (context, url, error) =>
                    //                 Image.asset("assets/splashScreen.png"),
                    //           ),
                    //           title: Text(
                    //               searchedMovie!.results![i].title.toString()),
                    //         ),
                    //       );
                    //     },
                    //   ),
                    // ),

                    child: GridView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: searchedMovie?.results?.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 1,
                        // mainAxisSpacing: 1,
                        crossAxisSpacing: 10,
                        childAspectRatio: 1.5 / 2,
                      ),
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            InkWell(
                              onTap: (){
                                // print("pressed");
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> MovieDetailScreen(movieId: searchedMovie!.results![index].id!)
                                  ,));
                              },
                              child: Container(
                                child:
                                    searchedMovie!.results?[index].backdropPath ==
                                            null
                                        ? Image.asset("assets/splashScreen.png")
                                        : CachedNetworkImage(
                                            imageUrl:
                                                '$imageUrl${searchedMovie!.results?[index].backdropPath}',
                                          ),
                              ),
                            ),
                            Text(searchedMovie!.results![index].title.toString()),
                          ],
                        );
                      },
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
