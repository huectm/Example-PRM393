class Product {
  final String id;
  final String caId;
  final String name;
  final String image;
  final double price;
  final String? description;
  final int? discountPercent;


  Product({
    required this.id,
    required this.name,
    required this.caId,
    required this.image,
    required this.price,
    this.description,
    this.discountPercent,

  });

  // Chuyển đổi từ JSON sang đối tượng Product
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String,
      name: json['name'] as String,
      caId: json['caId'] as String,
      image: json['image'] as String,
      price: (json['price'] as num).toDouble(),
      description: json['description'] as String?,
      discountPercent: json['discountPercent'] as int?,

    );
  }

  // Chuyển đổi từ đối tượng Product sang JSON
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "caId":caId,
      "image": image,
      "price": price,
      "description": description,
      "discountPercent": discountPercent,

    };
  }
}
