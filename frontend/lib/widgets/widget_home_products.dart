import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/component/product_card.dart';
import 'package:frontend/models/pagination.dart';
import 'package:frontend/models/product.dart';
import 'package:frontend/models/product_filter.dart';
import 'package:frontend/providers.dart';

class HomeProductsWidget extends ConsumerWidget {
  const HomeProductsWidget({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // List<Product> list = List<Product>.empty(growable: true);
    // list.add(
    //   Product(
    //     productName: "Cake",
    //     category: Category(
    //       categoryName: "Bakery",
    //       categoryImage: "/uploads/categories/1743723022372-Bakery (2).png",
    //       categoryId: "67ef1a0e4568885ba165990b",
    //     ),
    //     productShortDescription: "Flaovoured Cake",
    //     productPrice: 200,
    //     productSalePrice: 150,
    //     productImage: "/uploads/products/1743849247394-cake.png",
    //     productSKU: "123",
    //     productType: "Simple",
    //     stockStatus: "IN",
    //     productId: "67f1071fa6a19cbd07a63831",
    //   ),
    // );
    // list.add(
    //   Product(
    //     productName: "Milk",
    //     category: Category(
    //       categoryName: "Dairy",
    //       categoryImage: "/uploads/categories/1743723080049-dairy (2).png",
    //       categoryId: "67ef1a484568885ba165990d",
    //     ),
    //     productShortDescription: "Natural Milk",
    //     productPrice: 35,
    //     productSalePrice: 32,
    //     productImage: "/uploads/products/1743849497731-milk.png",
    //     productSKU: "124",
    //     productType: "Simple",
    //     stockStatus: "IN",
    //     productId: "67f10819a6a19cbd07a63833",
    //   ),
    // );
    // list.add(
    //   Product(
    //     productName: "Facewash",
    //     category: Category(
    //       categoryName: "Personal Care",
    //       categoryImage: "/uploads/categories/1743723243165-personal Care.png",
    //       categoryId: "67ef1aeb4568885ba165990f",
    //     ),
    //     productShortDescription: "Make your Face Clean ",
    //     productPrice: 80,
    //     productSalePrice: 72,
    //     productImage: "/uploads/products/1743850114221-facewash.png",
    //     productSKU: "125",
    //     productType: "Simple",
    //     stockStatus: "IN",
    //     productId: "67f10a82a6a19cbd07a63835",
    //   ),
    // );
    return Container(
      // Add your widget implementation here
      color: const Color(0xffF4F7FA),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 15),
                child: Text(
                  "Top 10 Products",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Padding(padding: const EdgeInsets.all(5.0), child: _productList(ref)),
        ],
      ),
    );
  }

  Widget _productList(WidgetRef ref) {
    final products = ref.watch(
      homeProductProvider(
        ProductFilterModel(
          paginationModel: PaginationModel(page: 1, pageSize: 10),
        ),
      ),
    );
    return products.when(
      data: (list) {
        if (list == null || list.isEmpty) {
          return const Center(child: Text("No products available"));
        }
        return _buildProductList(list!);
      },
      error: (error, stack) {
        return Center(child: Text("Error: $error"));
      },
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildProductList(List<Product> products) {
    return Container(
      // Add your widget implementation here
      height: 200,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 10),
      child: ListView.builder(
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (context, index) {
          var data = products[index];
          return GestureDetector(onTap: () {}, child: ProductCard(model: data));
        },
      ),
    );
  }
}
