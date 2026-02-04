import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:inventry_mgmt/product/model/product_model.dart';

class ProductService {
  final String baseurl =
      "https://69788471cd4fe130e3d93351.mockapi.io/users/product";

  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await http.get(Uri.parse(baseurl));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => ProductModel.fromJson(json)).toList();
      } else {
        return [];
      }
    } catch (e) {
      print("Error fetching products: $e");
      return [];
    }
  }

  Future<bool> addProduct(ProductModel product) async {
    try {
      final response = await http.post(
        Uri.parse(baseurl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(product.toJson()),
      );
      return response.statusCode == 201;
    } catch (e) {
      print("Erro adding $e");
      return false;
    }
  }

  Future<bool> updateProduct(ProductModel product) async {
    try {
      final url = "$baseurl/${product.id}";
      final response = await http.put(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(product.toJson()),
      );
      return response.statusCode == 200;
    } catch (e) {
      print("error $e");
      return false;
    }
  }

  Future<bool> deleteProduct(String id) async {
    try {
      final url = "$baseurl/$id";
      final response = await http.delete(Uri.parse(url));
      return response.statusCode == 200;
    } catch (e) {
      print("error deleting");
      return false;
    }
  }
}
