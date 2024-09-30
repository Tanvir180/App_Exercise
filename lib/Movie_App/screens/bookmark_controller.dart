import 'package:get/get.dart';
import 'package:state_management/Movie_App/Data/db_handler.dart';

class BookmarkController extends GetxController {
  final DbHandler _dbHandler = DbHandler();

  // Observable list to hold bookmark data
  var bookmarks = <Map<String, dynamic>>[].obs;

  // Fetch data from the database using DbHandler
  Future<void> fetchData() async {
    final data = await _dbHandler.getData();
    bookmarks.assignAll(data); // Update the observable list
  }



  // Delete a bookmark and refresh the list
  Future<void> deleteBookmark(int id) async {
    await _dbHandler.deleteData(id);
    fetchData(); // Refresh the list after deletion
  }
  //
  // @override
  // void onInit() {
  //   fetchData(); // Load data when controller is initialized
  //   super.onInit();
  // }
}
