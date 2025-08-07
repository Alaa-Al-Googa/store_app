import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:store/helper/api.dart';

class AllCategoriesService {
  Future<List<String>> getAllCategories() async {
    final data = await Api().get(
      url: 'https://fakestoreapi.com/products/categories',
      token: null,
    );

    return List<String>.from(data);
  }
}
