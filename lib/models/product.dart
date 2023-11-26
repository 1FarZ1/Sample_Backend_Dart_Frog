class Product {
  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
  });

  // constructor from json
  Product.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        name = json['name'] as String,
        description = json['description'] as String,
        price = json['price'] as double;
  int id;
  String name;
  String description;
  double price;


  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'price': price,
  };
  
}
