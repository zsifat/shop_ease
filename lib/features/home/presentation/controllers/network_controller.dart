import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ecommerce_app/features/home/presentation/controllers/product_controllers.dart';
import 'package:get/get.dart';

import '../../../../core/network/network_checker.dart';


class NetworkController extends GetxController {
  var isConnected = true.obs;

  final NetworkChecker _networkChecker = NetworkChecker();
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    _startNetworkMonitoring();
  }

  void _startNetworkMonitoring() {
    _connectivity.onConnectivityChanged.listen((List<ConnectivityResult> result) async {
      bool connectionStatus = await _networkChecker.hasConnection;
      isConnected.value = connectionStatus;
      if (connectionStatus) {
        final productController = Get.find<ProductController>();
        productController.fetchProducts(isRefresh: true);
      }
    });
  }

  Future<void> refreshNetworkStatus() async {
    bool connectionStatus = await _networkChecker.hasConnection;
    isConnected.value = connectionStatus;
  }
}
