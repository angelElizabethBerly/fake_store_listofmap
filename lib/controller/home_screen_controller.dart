import 'dart:convert';
import 'dart:developer';

import 'package:fake_store_listofmap/model/product_res_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreenController with ChangeNotifier {
  List<ProductResModel> productsList = [];
  bool isLoading = false;

  getProducts() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.parse("https://fakestoreapi.com/products");
    try {
      final res = await http.get(url);
      if (res.statusCode == 200) {
        final decodedData = jsonDecode(res.body) as List;
        // log(decodedData.toString());
        productsList =
            decodedData.map((e) => ProductResModel.fromJson(e)).toList();
        log(productsList.first.title.toString());
      } else {
        log("Failed");
      }
    } catch (e) {
      print(e.toString());
    }
    isLoading = false;
    notifyListeners();
  }
}
