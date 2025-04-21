import 'package:get/get.dart';
import '../../features/home/presentation/controllers/network_controller.dart';
import '../../features/home/presentation/controllers/product_controllers.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(ProductController());
    Get.put(NetworkController());
  }
}
