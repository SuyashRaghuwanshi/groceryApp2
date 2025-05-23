import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/api/api_service.dart';
import 'package:frontend/application/state/cart_state.dart';
import 'package:frontend/application/state/notifier/cart_notifier.dart';
import 'package:frontend/application/state/notifier/product_filter_notifier.dart';
import 'package:frontend/application/state/notifier/products_notifier.dart';
import 'package:frontend/application/state/product_state.dart';
import 'package:frontend/models/category.dart';
import 'package:frontend/models/pagination.dart';
import 'package:frontend/models/product.dart';
import 'package:frontend/models/product_filter.dart';
import 'package:frontend/models/slider.dart';

final categoryProvider =
    FutureProvider.family<List<Category>?, PaginationModel>((
      ref,
      paginationModel,
    ) {
      final apiRepository = ref.watch(apiService);

      return apiRepository.getCategories(
        paginationModel.page,
        paginationModel.pageSize,
      );
    });
final homeProductProvider =
    FutureProvider.family<List<Product>?, ProductFilterModel>((
      ref,
      productFilterModel,
    ) {
      final apiRepository = ref.watch(apiService);
      return apiRepository.getProducts(productFilterModel);
    });
final productsFilterProvider =
    StateNotifierProvider<ProductsFilterNotifier, ProductFilterModel>((ref) {
      return ProductsFilterNotifier();
    });

final productsNotifierProvider =
    StateNotifierProvider<ProductsNotifier, ProductsState>(
      (ref) => ProductsNotifier(
        ref.watch(apiService),
        ref.watch(productsFilterProvider),
      ),
    );

final sliderProvider =
    FutureProvider.family<List<SliderModel>?, PaginationModel>((
      ref,
      paginationModel,
    ) async {
      final sliderRepo = ref.watch(apiService);
      final repo = await sliderRepo.getSliders(
        paginationModel.page,
        paginationModel.pageSize,
      );
      log("$repo");
      return repo;
    });

final ProductDetailsProvider = FutureProvider.family<Product?, String>((
  ref,
  productId,
) {
  final apiRepository = ref.watch(apiService);
  return apiRepository.getProductDetails(productId);
});

final relatedProductsProvider =
    FutureProvider.family<List<Product>?, ProductFilterModel>((
      ref,
      productsFilterModel,
    ) {
      final apiRepository = ref.watch(apiService);
      return apiRepository.getProducts(productsFilterModel);
    });

final cartItemProvider = StateNotifierProvider<CartNotifier, CartState>(
  (ref) => CartNotifier(ref.watch(apiService)),
);
