class Product {
  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.rating,
    required this.image,
    required this.brand,
    required this.stock,
    required this.category,
  });

  // constructor from json
  Product.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        name = json['name'] as String,
        description = json['description'] as String,
        price = json['price'] as double,
        rating = json['rating'] as double,
        image = json['image'] as String,
        brand = json['brand'] as String,
        stock = json['stock'] as int,
        category = json['category'] as String;
  // from assoc
  Product.fromAssoc(Map<String, dynamic> assoc)
      : id = assoc['id'] as int,
        name = assoc['name'] as String,
        description = assoc['description'] as String,
        price = assoc['price'] as double,
        rating = assoc['rating'] as double,
        image = assoc['image'] as String,
        brand = assoc['brand'] as String,
        stock = assoc['stock'] as int,
        category = assoc['category'] as String;
  int id;
  String name;
  String description;
  double price;
  double rating;
  String image;
  String brand;
  int stock;
  String category;
  // to json
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'price': price,
        'rating': rating,
        'image': image,
        'brand': brand,
        'stock': stock,
        'category': category,
      };
}
