import 'package:flutter/material.dart';
import 'package:state_management/Movie_App/Data/db_handler.dart';
import 'package:state_management/Movie_App/common/utils.dart';
import 'package:state_management/Movie_App/screens/movie_details_screen.dart'; // Make sure this import path is correct

class BookMarkList extends StatefulWidget {
  const BookMarkList({super.key});

  @override
  _BookMarkListState createState() => _BookMarkListState();
}

class _BookMarkListState extends State<BookMarkList> {
  final DbHandler _dbHandler = DbHandler(); // Instantiate DbHandler

  // Check if a movie is already bookmarked
  Future<bool> isBookmarked(int id) async {
    final List<Map<String, dynamic>> movies = await _dbHandler.getData(); // Get data from the database
    return movies.any((movie) => movie['id'] == id); // Check if any movie has the same ID
  }

  // Fetch data from the database using DbHandler
  Future<List<Map<String, dynamic>>> fetchData() async {
    return await _dbHandler.getData(); // Call the method from DbHandler to get data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        primary: true,
        title: const Text('Bookmarks'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator()); // Show loading spinner while waiting for data
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}')); // Show error message if something went wrong
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var item = snapshot.data![index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetailScreen(movieId: item['id']),
                      ),
                    );
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

                              await _dbHandler.deleteData(item['id']);
                              setState(() {}); // Refresh the list after deletion
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('No data found.'));
          }
        },
      ),
    );
  }
}
