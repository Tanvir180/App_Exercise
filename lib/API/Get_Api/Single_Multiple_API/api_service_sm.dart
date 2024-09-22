import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:state_management/API/Get_Api/Single_Multiple_API/model_sm.dart';

class ApiServices {
  Future<MultiData?> getSMData() async {
    try {
      var response = await http.get(Uri.parse("https://reqres.in/api/unknown"));
      if (response.statusCode == 200) {
        MultiData model = MultiData.fromJson(json.decode(response.body));
        return model;
      }
    } catch (e) {
      print(e.toString());
    }

    return null;
  }

//Without Model

  Future<dynamic> getPostWithOutModel() async {
    try {
      var response = await http
          .get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
      if (response.statusCode == 200) {
        final model = jsonDecode(response.body);
        return model;
      }
    } catch (e) {
      print(e.toString());
    }

    return null;
  }
}
