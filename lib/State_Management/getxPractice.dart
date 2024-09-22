import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:state_management/State_Management/counter_controller.dart';

class Getxpractice extends StatelessWidget {
  Getxpractice({super.key});

  //dependency injection

  final dependency = Get.put(CounterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // GetX<CounterController>(
            //     builder: (controller){
            //       print("Update1");
            //       return Text(controller.count1.toString(), style: TextStyle(fontSize: 30));
            //     }),

            Obx(() => Text(dependency.count1.toString(),
                style: TextStyle(fontSize: 30))),

            // GetX<CounterController>(
            //     builder: (controller){
            //       print("Update2");
            //       return Text(controller.count2.toString(), style: TextStyle(fontSize: 30));
            //     }),

            Obx(() => Text(dependency.count2.toString(),
                style: TextStyle(fontSize: 30))),
            // GetX<CounterController>(
            //     builder: (controller){
            //       print("Update3");
            //       return Text(controller.count3.toString(), style: TextStyle(fontSize: 30));
            //     }),

            Obx(() => Text(dependency.count3.toString(),
                style: TextStyle(fontSize: 30))),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: dependency.increamentCount1,
                    child: Text("Increment1")),
                ElevatedButton(
                    onPressed: dependency.increamentCount2,
                    child: Text("Increment2")),
                ElevatedButton(
                    onPressed: dependency.increamentCount3,
                    child: Text("Increment3")),
              ],
            )
          ],
        ));
  }
}
