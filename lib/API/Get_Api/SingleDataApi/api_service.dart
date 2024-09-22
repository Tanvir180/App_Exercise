import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:state_management/API/Get_Api/SingleDataApi/model.dart';

class ApiServices {
  // With Model
  Future<Model?> getSinglePostWithModel() async {
    try {
      var response = await http
          .get(Uri.parse("https://jsonplaceholder.typicode.com/posts/1"));
      if (response.statusCode == 200) {
        Model model = Model.fromJson(json.decode(response.body));
        return model;
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}
