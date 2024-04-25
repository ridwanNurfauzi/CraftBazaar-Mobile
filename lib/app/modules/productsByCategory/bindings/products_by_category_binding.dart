import 'package:get/get.dart';

import '../controllers/products_by_category_controller.dart';

class ProductsByCategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductsByCategoryController>(
      () => ProductsByCategoryController(),
    );
  }
}
