import 'package:flutter/material.dart';
import 'package:state_management/API/Post_Api/JobPost/api_service_job.dart';
import 'package:state_management/API/Post_Api/JobPost/job_model.dart';
import 'package:state_management/API/Post_Api/JobPost/job_see.dart';

class JobHomeScreen extends StatefulWidget {
  const JobHomeScreen({super.key});

  @override
  State<JobHomeScreen> createState() => _JobHomeScreenState();
}

class _JobHomeScreenState extends State<JobHomeScreen> {
  //controller
  TextEditingController name = TextEditingController();
  TextEditingController job = TextEditingController();

  JobModel createJobModel = JobModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Job Post ${createJobModel.name}"),
        // actions: Icon(Icons.import_contacts).
      ),
      body: Center(
        child: Container(
          // height: 500,
          // width: 700,
          color: Colors.blueGrey,
          padding: EdgeInsets.all(40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: Colors.white,
                child: TextField(
                  controller: name,
                  decoration: const InputDecoration(hintText: "Name"),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                color: Colors.white,
                child: TextField(
                  controller: job,
                  decoration: const InputDecoration(hintText: "Job"),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              SizedBox(
                height: 50,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red, // text color
                    ),
                    onPressed: () {
                      ApiServicesJob()
                          .createjob(name.text.toString(), job.text.toString())
                          .then((value) {
                        setState(() {
                          createJobModel = value!;

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SeeJob(
                                        id: createJobModel.id.toString(),
                                        name: createJobModel.name.toString(),
                                        job: createJobModel.job.toString(),
                                      ) // Passing token Value
                                  ));
                        });
                      });
                    },
                    child: const Text("Add Job")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
