import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/config.dart';
import 'package:frontend/main.dart';
import 'package:frontend/models/cart.dart';
import 'package:frontend/models/category.dart';
import 'package:frontend/models/login_response_model.dart';
import 'package:frontend/models/product.dart';
import 'package:frontend/models/product_filter.dart';
import 'package:frontend/models/slider.dart';
import 'package:frontend/utils/shared_service.dart';
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
    var url = Uri.parse(
      "${Config.apiUrl}${Config.categoryAPI}?page=$page&pageSize=$pageSize",
    );

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
    if (productFilterModel.sortBy != null) {
      queryString['sort'] = productFilterModel.sortBy!;
    }
    if (productFilterModel.productIds != null) {
      queryString['productIds'] = productFilterModel.productIds!.join(',');
    }
    final url = Uri.parse(
      "${Config.apiUrl}${Config.productAPI}",
    ).replace(queryParameters: queryString);

    debugPrint("Final API URL: $url");
    var response = await client.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      try {
        var data = jsonDecode(response.body);
        debugPrint("Decoded JSON: $data");
        return productsFromJson(data["data"]);
      } catch (e) {
        debugPrint("Error decoding JSON: $e");
        return null;
      }
    } else {
      debugPrint("Failed to fetch categories");
      return null;
    }
  }

  static Future<bool> registerUser(
    String fullName,
    String email,
    String password,
  ) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

    final url = Uri.parse("${Config.apiUrl}${Config.registerAPI}");

    debugPrint("Final API URL: $url");
    try {
      var response = await client.post(
        url,
        headers: requestHeaders,
        body: jsonEncode({
          "fullName": fullName,
          "email": email,
          "password": password,
        }),
      );

      debugPrint("📥 Response Code: ${response.statusCode}");
      debugPrint("📥 Response Body: ${response.body}");

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint("❌ Register Error: $e");
      return false;
    }
  }

  static Future<bool> loginUser(String email, String password) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
    final url = Uri.parse("${Config.apiUrl}${Config.loginAPI}");

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({"email": email, "password": password}),
    );
    if (response.statusCode == 200) {
      await SharedService.setLoginDetails(loginResponseJson(response.body));
      return true;
    } else {
      return false;
    }
  }

  Future<List<SliderModel>?> getSliders(page, pageSize) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
    Map<String, String> queryString = {
      'page': page.toString(),
      'pageSize': pageSize.toString(),
    };
    final url = Uri.parse(
      "${Config.apiUrl}${Config.sliderAPI}",
    ).replace(queryParameters: queryString);

    debugPrint("Final API URL: $url");
    log("Fetching sliders from $url");
    var response = await client.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      try {
        var data = jsonDecode(response.body);
        log("${data["data"]}");
        final sliders = slidersFromJson(data["data"]);
        log("$sliders");
        return sliders;
      } catch (e) {
        debugPrint("Error decoding JSON of sliders: $e");
        return null;
      }
    } else {
      debugPrint("Failed to fetch sliders");
      return null;
    }
  }

  Future<Product?> getProductDetails(String productId) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
    final url = Uri.parse("${Config.apiUrl}${Config.productAPI}/$productId");

    var response = await client.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      try {
        var data = jsonDecode(response.body);
        return Product.fromJson(data["data"]);
      } catch (e) {
        debugPrint("Error decoding JSON: $e");
        throw Exception("Failed to parse product details");
      }
    } else {
      debugPrint("Failed to fetch product details");
      return null;
    }
  }

  Future<bool?> addCartItem(productId, qty) async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${loginDetails!.data.token}',
    };
    // var url = Uri.http(Config.apiUrl, Config.cartAPI);
    var url = Uri.parse("${Config.apiUrl}${Config.cartAPI}");
    log("Adding to cart URL: $url");
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({
        "products": [
          {"product": productId, "qty": qty},
        ],
      }),
    );
    log("STATUS: ${response.statusCode}");
    log("BODY: ${response.body}");

    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 401) {
      navigatorKey.currentState?.pushNamedAndRemoveUntil(
        "/login",
        (route) => false,
      );
    } else {
      return null;
    }
  }

  Future<bool?> removeCartItem(productId, qty) async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${loginDetails!.data.token}',
    };
    final url = Uri.parse("${Config.apiUrl}${Config.cartAPI}");

    var response = await client.delete(
      url,
      headers: requestHeaders,
      body: jsonEncode({"productId": productId, "qty": qty}),
    );
    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 401) {
      navigatorKey.currentState?.pushNamedAndRemoveUntil(
        "/login",
        (route) => false,
      );
    } else {
      return null;
    }
  }

  Future<Cart?> getCart() async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${loginDetails!.data.token}',
    };
    final url = Uri.parse("${Config.apiUrl}${Config.cartAPI}");

    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      try {
        log("Response Body: ${response.body}");
        var data = jsonDecode(response.body);
        log(data.toString());
        return Cart.fromJson(data["data"]);
      } catch (e) {
        debugPrint("Error decoding JSON: $e");
        throw Exception("Failed to parse cart details");
      }
    } else if (response.statusCode == 401) {
      navigatorKey.currentState?.pushNamedAndRemoveUntil(
        "/login",
        (route) => false,
      );
    } else {
      return null;
    }
  }
}
