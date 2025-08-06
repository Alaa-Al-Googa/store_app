import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:store/helper/api.dart';
import 'package:store/models/product_model.dart';

class AllProductService {
  Future<List<ProductModel>> getAllProducts() async {
    List<dynamic> data =
        await Api().get(url: 'https://fakestoreapi.com/products');
    List<ProductModel> productList = [];

    for (int i = 0; i < data.length; i++) {
      productList.add(
        ProductModel.formJson(data[i]),
      );
    }
    return productList;
  }
}
