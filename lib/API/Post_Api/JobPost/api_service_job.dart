import 'package:state_management/API/Post_Api/JobPost/job_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiServicesJob {
  Future<JobModel?> createjob(String name, String job) async {
    try {
      var url = Uri.parse("https://reqres.in/api/users");
      var response = await http.post(url, body: {"name": name, "job": job});
      if (response.statusCode == 201 || response.statusCode == 200) {
        JobModel model = JobModel.fromJson(jsonDecode(response.body));
        return model;
      }
    } catch (e) {
      print(e);
    }
  }
}
