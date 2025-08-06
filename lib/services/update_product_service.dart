import 'package:store/helper/api.dart';
import 'package:store/models/product_model.dart';

class UpdateProductService {
  Future<ProductModel> updateProduct({
    required String title,
    required double price,
    required String desc,
    required String image,
    required String category,
    required dynamic id,
  }) async {
    Map<String, dynamic> data = await Api().put(
      url: 'https://fakestoreapi.com/products/$id',
      body: {
        'title': title,
        'price': price,
        'description': desc,
        'image': image,
        'category': category,
      },
      //token: token
    );
    return ProductModel.formJson(data);
  }
}
