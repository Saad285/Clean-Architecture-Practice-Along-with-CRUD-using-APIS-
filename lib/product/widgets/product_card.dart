import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:inventry_mgmt/product/model/product_model.dart';
import 'package:inventry_mgmt/product/view/separate_product_view.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback onDelete;
  final VoidCallback? onEdit;

  const ProductCard({
    super.key,
    required this.product,
    required this.onDelete,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    bool isLowStock = product.quantity < 5;
    Color statusColor = isLowStock
        ? Colors.red.shade100
        : Colors.green.shade100;
    Color statusIconColor = isLowStock ? Colors.red : Colors.green;

    return GestureDetector(
      onTap: () => Get.to(
        () => SeparateProductView(
          product: product,
          statusIIconcolor: statusIconColor,
          statusColor: statusColor,
        ),
      ),
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: ListTile(
          contentPadding: const EdgeInsets.all(15),

          leading: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: statusColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.inventory_2, color: statusIconColor),
          ),

          title: Text(
            product.name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Price: Rs ${product.price}"),
              if (isLowStock)
                const Padding(
                  padding: EdgeInsets.only(top: 4.0),
                  child: Text(
                    " Low Stock!",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
            ],
          ),

          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Qty: ${product.quantity}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(width: 10),

              IconButton(
                icon: const Icon(Icons.delete, color: Colors.redAccent),
                onPressed: onDelete,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
