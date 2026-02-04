class ProductModel {
  final String id;
  final String name;
  final double price;
  final int quantity;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
  });
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'].toString(),
      name: json['name'] ?? 'unknown',
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      quantity: int.tryParse(json['quantity'].toString()) ?? 0,
    );
  }
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'price': price, 'quantity': quantity};
  }
}
