// ignore_for_file: public_member_api_docs

import 'package:server/db/sql_client.dart';
import 'package:server/models/product.dart';

class ProductRepository {
  factory ProductRepository() {
    return _instance;
  }

  ProductRepository._privateConstructor(
    this.sqlClient,
  );
  SqlClient sqlClient;

  static final ProductRepository _instance =
      ProductRepository._privateConstructor(
    SqlClient(),
  );

  //singleton

  final List<Product> _products = [
    Product(
      id: 1,
      name: 'Product 1',
      description: 'This is product 1',
      price: 100,
    ),
    Product(
      id: 2,
      name: 'Product 2',
      description: 'This is product 2',
      price: 200,
    ),
    Product(
      id: 3,
      name: 'Product 3',
      description: 'This is product 3',
      price: 300,
    ),
    Product(
      id: 4,
      name: 'Product 4',
      description: 'This is product 4',
      price: 400,
    ),
    Product(
      id: 5,
      name: 'Product 5',
      description: 'This is product 5',
      price: 500,
    ),
  ];

  Future<List<Product>> fetchProducts({
    int? page = 0,
    int? limit = 2,
    String? search,
  }) async {
    final resultProducts = <Product>[];

    final result = await sqlClient.execute('SELECT * FROM product');
   
    if (search != null) {
      for (final p in _products) {
        if (p.description.toLowerCase().contains(search.toLowerCase()) ||
            p.name.toLowerCase().contains(search.toLowerCase())) {
          resultProducts.add(p);
        }
      }
    } else {
      resultProducts.addAll(_products);
    }

    final startIndex = page! * limit!;
    final endIndex = startIndex + limit;

    return resultProducts.sublist(
      startIndex,
      endIndex > resultProducts.length ? resultProducts.length : endIndex,
    );
  }

  Future<Product?> fetchProductById(int id) async {
    return _products.firstWhere((p) => p.id == id);
  }

  Future<Product> createProduct(Product product) async {
    _products.add(product);

    return product;
  }

  Future<Product?> updateProduct(Product product) async {
    final index = _products.indexWhere((p) => p.id == product.id);
    if (index == -1) {
      return null;
    }
    _products[index] = product;
    return product;
  }

  Future<bool> deleteProduct(int id) async {
    _products.removeWhere((p) => p.id == id);
    return true;
  }
}
