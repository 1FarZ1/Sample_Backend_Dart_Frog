import '../models/product.dart';
class ProductRepository {
  factory ProductRepository() {
    return _instance;
  }

  ProductRepository._privateConstructor();

  static final ProductRepository _instance =
      ProductRepository._privateConstructor();

  //singleton

  final List<Product> products = [
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
    return products;
  }

  Future<Product?> fetchProductById(int id) async {
    return products.firstWhere((p) => p.id == id);
  }

  Future<Product> createProduct(Product product) async {
    products.add(product);

    return product;
  }

  Future<Product?> updateProduct(Product product) async {

    final index = products.indexWhere((p) => p.id == product.id);
    if(index == -1) {
      return null;
    }
    products[index] = product;
    return product;
  }

  Future<bool> deleteProduct(int id) async {
    products.removeWhere((p) => p.id == id);
    return true;
  }
}
