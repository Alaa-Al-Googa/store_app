import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Api {
  Future<dynamic> get({required String url, String? token}) async {
    final headers = <String, String>{};

    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }

    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
          'Request failed\n'
          'Status Code: ${response.statusCode}\n'
          'Response Body: ${response.body}',
        );
      }
    } catch (e) {
      throw Exception('GET request error: $e');
    }
  }

  // Future<dynamic> post(
  //     {required String url,
  //     @required dynamic body,
  //     @required String? token}) async {
  //   Map<String, String> headers = {};

  //   if (token != null) {
  //     headers.addAll({'Authorization': 'Bearer $token'});
  //   }

  //   http.Response response =
  //       await http.post(Uri.parse(url), body: body, headers: headers);

  //   if (response.statusCode == 200) {
  //     Map<String, dynamic> data = jsonDecode(response.body);

  //     return data;
  //   } else {
  //     throw Exception('there is a problem with status code '
  //         '${response.statusCode} '
  //         'with body ${jsonDecode(response.body)}');
  //   }
  // }

  Future<dynamic> post({
    required String url,
    required dynamic body,
    @required String? token,
  }) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json', // <<< مهم جدا
    };

    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }

    http.Response response = await http.post(
      Uri.parse(url),
      body: jsonEncode(body), // <<< نحول body إلى JSON
      headers: headers,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      // 201 = Created
      return jsonDecode(response.body);
    } else {
      throw Exception(
        'There is a problem with status code '
        '${response.statusCode} '
        'with body ${response.body}',
      );
    }
  }

  Future<dynamic> put(
      {required String url,
      @required dynamic body,
      @required String? token}) async {
    Map<String, String> headers = {};

    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }

    //headers.addAll({'Content-Type': 'application/x-www-form-urlencoded'});
    headers.addAll({'Content-Type': 'application/json'});

    print('url=$url body=$body token=$token');

    //http.Response response =await http.put(Uri.parse(url),body:body,headers:headers);
    http.Response response =
        await http.put(Uri.parse(url), body: body, headers: headers);

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      print(data);
      return data;
    } else {
      throw Exception('there is a problem with status code '
          '${response.statusCode} '
          'with body ${jsonDecode(response.body)}');
    }
  }
}
