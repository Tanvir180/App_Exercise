import 'package:get/get.dart';

class CounterController extends GetxController {
  var count1 = 0.obs;
  var count2 = 0.obs;
  var count3 = 0.obs;

  void increamentCount1() {
    count1++;
  }

  void increamentCount2() {
    count2++;
  }

  void increamentCount3() {
    count3++;
  }
}
