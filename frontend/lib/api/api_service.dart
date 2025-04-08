import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/config.dart';
import 'package:frontend/models/category.dart';
import 'package:frontend/models/product.dart';
import 'package:frontend/models/product_filter.dart';
import 'package:http/http.dart' as http;

final apiService = Provider((ref) => APIService());

class APIService {
  static var client = http.Client();
  Future<List<Category>?> getCategories(page, pageSize) async {
    debugPrint("Fetching categories...");
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
    Map<String, String> queryString = {
      'page': page.toString(),
      'pageSize': pageSize.toString(),
    };
    debugPrint("API URL from Config: ${Config.apiUrl}");
    debugPrint("Category API Path: ${Config.categoryAPI}");
    var url = Uri.http(Config.apiUrl, Config.categoryAPI, queryString);

    debugPrint("Final API URL: $url");
    var response = await client.get(url, headers: requestHeaders);
    debugPrint("Status Code: ${response.statusCode}");
    debugPrint("Response Body: ${response.body}");
    if (response.statusCode == 200) {
      try {
        var data = jsonDecode(response.body);
        debugPrint("Decoded JSON: $data");
        debugPrint("Type of data['data']: ${data["data"].runtimeType}");

        // Ensure `data["data"]` is a List
        List<dynamic> categoryList = (data["data"] as List<dynamic>?) ?? [];
        debugPrint("Categories found: ${categoryList.length}");

        List<Category> categories = [];
        for (var item in categoryList) {
          try {
            var category = Category.fromJson(item);
            categories.add(category);
            debugPrint("Parsed category: ${category.categoryName}");
          } catch (e) {
            debugPrint("Error parsing category: $e, Data: $item");
          }
        }

        return categories;
      } catch (e) {
        debugPrint("Error decoding JSON: $e");
        return null;
      }
    } else {
      debugPrint("Failed to fetch categories");
      return null;
    }
  }

  Future<List<Product>?> getProducts(
    ProductFilterModel productFilterModel,
  ) async {
    debugPrint("Fetching categories...");
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
    Map<String, String> queryString = {
      'page': productFilterModel.paginationModel.page.toString(),
      'pageSize': productFilterModel.paginationModel.pageSize.toString(),
    };

    if (productFilterModel.categoryId != null) {
      queryString['categoryId'] = productFilterModel.categoryId!;
    }
    debugPrint("API URL from Config: ${Config.apiUrl}");
    debugPrint("Category API Path: ${Config.categoryAPI}");
    var url = Uri.http(Config.apiUrl, Config.productAPI, queryString);

    debugPrint("Final API URL: $url");
    var response = await client.get(url, headers: requestHeaders);
    debugPrint("Status Code: ${response.statusCode}");
    debugPrint("Response Body: ${response.body}");
    if (response.statusCode == 200) {
      try {
        var data = jsonDecode(response.body);
        debugPrint("Decoded JSON: $data");
        return productsFromJson(data["data"]);

        // List<dynamic> productList = (data["data"] as List<dynamic>?) ?? [];
        // debugPrint("Categories found: ${productList.length}");

        // List<Product> products = [];
        // for (var item in productList) {
        //   try {
        //     var product = Product.fromJson(item);
        //     products.add(product);
        //     debugPrint("Parsed category: ${product.productName}");
        //   } catch (e) {
        //     debugPrint("Error parsing category: $e, Data: $item");
        //   }
        // }
        // return products;
      } catch (e) {
        debugPrint("Error decoding JSON: $e");
        return null;
      }
    } else {
      debugPrint("Failed to fetch categories");
      return null;
    }
  }
}
