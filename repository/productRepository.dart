import '../models/product.dart';

class ProductRepository {
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

  Future<List<Product>> fetchProducts() async {
    return _products;
  }

  Future<Product> fetchProductById(int id) async {
    return _products.firstWhere((p) => p.id == id);
  }

  Future<Product> createProduct(Product product) async {
    _products.add(product);
    return product;
  }

  Future<Product> updateProduct(Product product) async {
    final index = _products.indexWhere((p) => p.id == product.id);
    _products[index] = product;
    return product;
  }

  Future<void> deleteProduct(int id) async {
    _products.removeWhere((p) => p.id == id);
  }
}
