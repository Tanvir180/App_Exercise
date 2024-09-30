import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:state_management/Movie_App/common/utils.dart';
import 'package:state_management/Movie_App/screens/movie_details_screen.dart'; // Ensure the import path is correct
import 'bookmark_controller.dart'; // Import the controller

class BookMarkList extends StatelessWidget {
  // Initialize the controller using GetX dependency injection
  final BookmarkController bookmarkController = Get.put(BookmarkController());

  BookMarkList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Bookmarks'),
      ),



      // Here initstate is used for mainly render the data form database everytime
      body: GetBuilder<BookmarkController>(
        initState: (state) {
          bookmarkController.fetchData() ;
          },
        builder: (context) {
          return Obx(() {
            // Reactive UI using Obx to watch changes in the bookmarks list
            if (bookmarkController.bookmarks.isEmpty) {
              return const Center(child: Text('BookMark Movies'));
            }

            return ListView.builder(
              itemCount: bookmarkController.bookmarks.length,
              itemBuilder: (context, index) {
                var item = bookmarkController.bookmarks[index];

                return GestureDetector(
                  onTap: () {
                    Get.to(() => MovieDetailScreen(movieId: item['id']));
                  },
                  child: Card(
                    color: Colors.white70,
                    elevation: 2, // gives a slight shadow
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 80,
                            height: 100,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage("$imageUrl${item['posterPath']}"),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(4), // gives the image rounded corners
                            ),
                          ),
                          const SizedBox(width: 20), // spacing between image and text
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  item['title'] ?? 'No Title',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 5), // tiny space between title and ratings
                                Text(
                                  '⭐ ${item['imdbId'] ?? 'N/A'} IMDB',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const SizedBox(height: 5), // more space
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.access_time, // Clock icon for runtime
                                      size: 16,
                                      color: Colors.black54,
                                    ),
                                    const SizedBox(width: 4), // Add spacing between the icon and the text
                                    Text(
                                      '${item['runtime'] ?? 'N/A'} min', // You can append 'min' for clarity
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () async {
                              await bookmarkController.deleteBookmark(item['id']);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          });
        }
      ),
    );
  }
}
