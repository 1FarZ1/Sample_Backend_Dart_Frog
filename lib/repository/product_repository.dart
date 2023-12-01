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

  Future<List<Product>> fetchProducts({
    int? page = 0,
    int? limit = 2,
    String? search,
  }) async {
    final resultProducts = <Product>[];

    final result = await sqlClient.execute('SELECT * FROM product');

    final products =
        result.rows.map((e) => Product.fromAssoc(e.assoc())).toList();
    if (search != null) {
      for (final p in products) {
        if (p.description.toLowerCase().contains(search.toLowerCase()) ||
            p.name.toLowerCase().contains(search.toLowerCase())) {
          resultProducts.add(p);
        }
      }
    } else {
      resultProducts.addAll(products);
    }

    final startIndex = page! * limit!;
    final endIndex = startIndex + limit;

    return resultProducts.sublist(
      startIndex,
      endIndex > resultProducts.length ? resultProducts.length : endIndex,
    );
  }

  Future<Product?> fetchProductById(int id) async {
    final result = await sqlClient.execute(
      'SELECT * FROM product WHERE id = :id',
      params: {
        'id': id,
      },
    );
    if (result.rows.isEmpty) return null;
    return Product.fromAssoc(result.rows.first.assoc());
  }

  Future<Product> createProduct(Product product) async {
    return product;
  }

  Future<Product?> updateProduct(Product product) async {
    // final index = _products.indexWhere((p) => p.id == product.id);
    // if (index == -1) {
    //   return null;
    // }
    // _products[index] = product;
    // return product;

    final result = await sqlClient.execute(
      'UPDATE product SET name = :name, description = :description, price = :price, image = :image WHERE id = :id',
      params: {
        'id': product.id,
        'name': product.name,
        'description': product.description,
        'price': product.price,
        'image': product.image,
      },
    );
    return null;
  }

  Future<bool> deleteProduct(int id) async {
    // _products.removeWhere((p) => p.id == id);

    return sqlClient.execute(
      'DELETE FROM product WHERE id = :id',
      params: {
        'id': id,
      },
    ).then((value) => value.numOfRows > 0);
  }
}
