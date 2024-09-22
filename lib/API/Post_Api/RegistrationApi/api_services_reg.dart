import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:state_management/API/Post_Api/RegistrationApi/regmodel.dart';

class ApiServicesReg {
  Future<RegistrationModel?> registrationApi(
      String email, String password) async {
    try {
      var url = Uri.parse("https://reqres.in/api/register");
      var response =
          await http.post(url, body: {"email": email, "password": password});
      if (response.statusCode == 201 || response.statusCode == 200) {
        RegistrationModel model =
            RegistrationModel.fromJson(jsonDecode(response.body));
        return model;
      }
    } catch (e) {
      print(e);
    }
  }
}
