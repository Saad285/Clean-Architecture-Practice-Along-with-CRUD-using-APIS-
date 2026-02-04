import 'package:flutter/material.dart';
import 'package:inventry_mgmt/product/widgets/detail_row.dart';
import '../model/product_model.dart';

class SeparateProductView extends StatelessWidget {
  final ProductModel product;
  final Color statusIIconcolor;
  final Color statusColor;
  const SeparateProductView({
    super.key,
    required this.product,
    required this.statusIIconcolor,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  color: statusColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.inventory_2,
                  size: 80,
                  color: statusIIconcolor,
                ),
              ),
            ),
            const SizedBox(height: 30),

            DetailRow(label: "Product Name", value: product.name),
            const Divider(),
            DetailRow(label: "Price", value: "Rs ${product.price}"),
            const Divider(),
            DetailRow(
              label: "Stock",
              value: "${product.quantity}",
              ValueColor: statusColor,
            ),
          ],
        ),
      ),
    );
  }
}
