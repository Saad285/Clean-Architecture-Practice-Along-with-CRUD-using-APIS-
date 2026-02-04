import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventry_mgmt/product/controller/product_controller.dart';
import 'package:inventry_mgmt/product/model/product_model.dart';
import 'package:inventry_mgmt/product/widgets/product_card.dart';

class ProductView extends StatelessWidget {
  ProductView({super.key});

  final ProductController controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Store Inventory"),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDialog(context),
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add, color: Colors.white),
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.productList.isEmpty) {
          return const Center(child: Text("No Products Found. Add some!"));
        }

        return ListView.builder(
          itemCount: controller.productList.length,
          padding: const EdgeInsets.all(10),
          itemBuilder: (context, index) {
            final product = controller.productList[index];

            return ProductCard(
              product: product,

              onDelete: () {
                controller.deleteProduct(product.id);
              },

              onEdit: () {
                _showEditDialog(context, product);
              },
            );
          },
        );
      }),
    );
  }

  void _showAddDialog(BuildContext context) {
    final nameController = TextEditingController();
    final priceController = TextEditingController();
    final qtyController = TextEditingController();

    Get.defaultDialog(
      title: "Add Product",
      contentPadding: const EdgeInsets.all(20),
      content: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: "Name"),
          ),
          TextField(
            controller: priceController,
            decoration: const InputDecoration(labelText: "Price"),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: qtyController,
            decoration: const InputDecoration(labelText: "Quantity"),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
      textConfirm: "Save",
      textCancel: "Cancel",
      confirmTextColor: Colors.white,
      buttonColor: Colors.blue,
      onConfirm: () {
        if (nameController.text.isEmpty) return;

        final newProduct = ProductModel(
          id: '',
          name: nameController.text,
          price: double.tryParse(priceController.text) ?? 0.0,
          quantity: int.tryParse(qtyController.text) ?? 0,
        );

        controller.addProduct(newProduct);
        Get.back();
      },
    );
  }

  void _showEditDialog(BuildContext context, ProductModel existingProduct) {
    final nameController = TextEditingController(text: existingProduct.name);
    final priceController = TextEditingController(
      text: existingProduct.price.toString(),
    );
    final qtyController = TextEditingController(
      text: existingProduct.quantity.toString(),
    );

    Get.defaultDialog(
      title: "Edit Product",
      contentPadding: const EdgeInsets.all(20),
      content: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: "Name"),
          ),
          TextField(
            controller: priceController,
            decoration: const InputDecoration(labelText: "Price"),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: qtyController,
            decoration: const InputDecoration(labelText: "Quantity"),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
      textConfirm: "Update",
      textCancel: "Cancel",
      confirmTextColor: Colors.white,
      buttonColor: Colors.green,
      onConfirm: () {
        final updatedProduct = ProductModel(
          id: existingProduct.id,
          name: nameController.text,
          price: double.tryParse(priceController.text) ?? 0.0,
          quantity: int.tryParse(qtyController.text) ?? 0,
        );

        controller.updateProduct(updatedProduct);
        Get.back();
      },
    );
  }
}
