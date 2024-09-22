import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:state_management/API/Header_Passing/headermodel.dart';
import 'package:state_management/API/Header_Passing/responsemodel.dart';

class HeaderApiServices {
  Future<HeaderModel?> headerPassingApi(String email, String password) async {
    try {
      var url = Uri.parse("https://api.escuelajs.co/api/v1/auth/login");
      var response = await http.post(url, body: {
        "email": email,
        "password": password,
      });
      if (response.statusCode == 201 || response.statusCode == 200) {
        HeaderModel model = HeaderModel.fromJson(jsonDecode(response.body));
        return model;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}

class ResponseApiServices {
  Future<ResponseModel?> getResponseData(String token) async {
    print(token);

    // String token;

    try {
      var response = await http.get(
          Uri.parse("https://api.escuelajs.co/api/v1/auth/profile"),
          headers: {"Authorization": "Bearer $token"});

      if (response.statusCode == 200) {
        ResponseModel model =
            ResponseModel.fromJson(json.decode(response.body));
        return model;
      }
    } catch (e) {
      print(e.toString());
    }

    return null;
  }
}
