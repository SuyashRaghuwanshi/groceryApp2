import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/models/category.dart';
import 'package:frontend/models/pagination.dart';
import 'package:frontend/models/product_filter.dart';
import 'package:frontend/providers.dart';

class HomeCategoriesWidget extends ConsumerWidget {
  const HomeCategoriesWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              "All Categories",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _categoriesList(ref),
          ),
        ],
      ),
    );
  }

  Widget _categoriesList(WidgetRef ref) {
    debugPrint("Fetching categories...");
    final categories = ref.watch(
      categoryProvider(PaginationModel(page: 1, pageSize: 10)),
    );
    debugPrint("categoryProvider state: $categories");

    return categories.when(
      data: (categories) {
        if (categories == null || categories.isEmpty) {
          return const Center(
            child: Text("No categories found"),
          ); // Handle empty state
        }
        return _buildCategoryList(categories, ref);
      },

      error: (err, stack) {
        debugPrint("Provider Error: $err");
        return const Center(child: Text("Failed to load categories"));
      },
      loading: () {
        debugPrint("Loading categories..");
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildCategoryList(List<Category> categories, WidgetRef ref) {
    return Container(
      height: 150,
      alignment: Alignment.centerLeft,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          var data = categories[index];
          debugPrint("${data.categoryName}");
          debugPrint("${data.fullImagePath}");
          return GestureDetector(
            onTap: () {
              ProductFilterModel filterModel = ProductFilterModel(
                paginationModel: PaginationModel(page: 1, pageSize: 10),
                categoryId: data.categoryId,
              );
              ref
                  .read(productsFilterProvider.notifier)
                  .setProductFilter(filterModel);
              ref.read(productsNotifierProvider.notifier).getProducts();
              Navigator.of(context).pushNamed(
                '/products',
                arguments: {
                  "categoryId": data.categoryId,
                  "categoryName": data.categoryName,
                },
              );
            },
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: EdgeInsets.all(9),
                    width: 50,
                    height: 50,
                    alignment: Alignment.center,
                    child: Image.network(data.fullImagePath, height: 50),
                  ),
                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        data.categoryName,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Icon(Icons.keyboard_arrow_right, size: 13),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
