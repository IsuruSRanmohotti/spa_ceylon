class ProductModel {
  String name;
  List<String> images;
  double price;
  int quantity;
  String description;
  String category;
  String id;

  ProductModel({
    required this.name,
    required this.images,
    required this.description,
    required this.price,
    required this.quantity,
    required this.category,
    required this.id,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      name: json['name'],
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      description: json['description'],
      price: json['price'],
      quantity: json['quantity'],
      category: json['category'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'images': images,
      'description': description,
      'quantity': quantity,
      'category': category,
      'id': id,
    };
  }
}
