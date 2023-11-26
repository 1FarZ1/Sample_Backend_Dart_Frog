class Product {
  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
  });
  int id;
  String name;
  String description;
  double price;


  // to json 
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'price': price,
  };
  
}
