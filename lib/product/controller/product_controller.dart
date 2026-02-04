import 'package:get/get.dart';
import 'package:inventry_mgmt/product/model/product_model.dart';
import 'package:inventry_mgmt/product/service/product_service.dart';

class ProductController extends GetxController {
  final ProductService _service = ProductService();

  var isLoading = false.obs;
  var productList = <ProductModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchproducts();
  }

  void fetchproducts() async {
    isLoading.value = true;
    var data = await _service.getProducts();

    if (data.isNotEmpty) {
      productList.value = data;
    }
    isLoading.value = false;
  }

  Future<void> addProduct(ProductModel product) async {
    isLoading.value = true;
    bool success = await _service.addProduct(product);

    if (success) {
      Get.snackbar("Success", "Product Added Successfully");
      fetchproducts();
    } else {
      Get.snackbar("Error", "Failed To Add Product");
    }
    isLoading.value = false;
  }

  Future<void> updateProduct(ProductModel product) async {
    isLoading.value = true;
    bool success = await _service.updateProduct(product);

    if (success) {
      Get.snackbar("Success", "Product Update Successfully");
      fetchproducts();
    } else {
      Get.snackbar("Error", "Failed To Update Product");
    }
    isLoading.value = false;
  }

  Future<void> deleteProduct(String id) async {
    isLoading.value = true;
    bool success = await _service.deleteProduct(id);
    if (success) {
      Get.snackbar("Success", "Product Delete Successfully");
      fetchproducts();
    } else {
      Get.snackbar("Error", "Failed To Deleted Product");
    }
    isLoading.value = false;
  }
}
