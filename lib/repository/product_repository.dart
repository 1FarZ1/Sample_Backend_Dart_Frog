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

  Future<Product?> createProduct(Product product) async {
    const query = '''
      INSERT INTO product (name, description, price, image , category,brand,stock,rating)
      VALUES (:name, :description, :price, :image, :category, :brand, :stock, :rating)
    ''';

    final result = await sqlClient.execute(
      query,
      params: {
        'name': product.name,
        'description': product.description,
        'price': product.price,
        'image': product.image,
        'category': product.category,
        'brand': product.brand,
        'stock': product.stock,
        'rating': product.rating,
      },
    );

    if (result.rows.isEmpty) return null;

    return Product.fromAssoc(result.rows.first.assoc());
  }

  Future<Product?> updateProduct(Product product) async {
  
    final result = await sqlClient.execute(
      'UPDATE product SET name = :name, description = :description, price = :price, image = :image category = ,:category, brand = ,:brand, stock = ,:stock, rating = ,:rating  WHERE id = :id',
      params: {
        'id': product.id,
        'name': product.name,
        'description': product.description,
        'price': product.price,
        'image': product.image,
        'category': product.category,
        'brand': product.brand,
        'stock': product.stock,
        'rating': product.rating,

      },
    );
    
    if (result.rows.isEmpty) return null;

    return Product.fromAssoc(result.rows.first.assoc());
  }

  Future<bool> deleteProduct(int id) async {

    return sqlClient.execute(
      'DELETE FROM product WHERE id = :id',
      params: {
        'id': id,
      },
    ).then((value) => value.numOfRows > 0);
  }
}
