import 'package:get/get.dart';

class MainPageController extends GetxController {
  int selectedItem = 1;

  void updateItemMenu(int newValue) {
    selectedItem = newValue;
    update();
  }

}