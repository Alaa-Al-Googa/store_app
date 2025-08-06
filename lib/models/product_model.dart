class ProductModel {
  final dynamic id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final RatingModel rating;

  ProductModel({
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.id,
    required this.rating,
  });

  factory ProductModel.formJson(jsonData) {
    return ProductModel(
      id: jsonData['id'],
      title: jsonData['title'],
      price: jsonData['price']?.toDouble() ?? 0.0,
      description: jsonData['description'],
      category: jsonData['category'],
      image: jsonData['image'],
      rating: RatingModel.formJson(
        jsonData['rating'],
      ),
    );
  }
}

class RatingModel {
  final double rate;
  final double count;

  RatingModel({required this.rate, required this.count});

  factory RatingModel.formJson(jsonData) {
    return RatingModel(
      rate: (jsonData['rate'] as num).toDouble(),
      count: (jsonData['count'] as num).toDouble(),
    );
  }
}
