import 'package:get/get.dart';
import 'package:princess_garden_client/business/princess_garden_controller.dart';

class App {
  static void init() {
    final princessGardenController = PrincessGardenController();
    Get.put(princessGardenController);
    princessGardenController.start();
  }
}
