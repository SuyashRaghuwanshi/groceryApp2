import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/api/api_service.dart';
import 'package:frontend/models/category.dart';
import 'package:frontend/models/pagination.dart';
import 'package:frontend/models/product.dart';
import 'package:frontend/models/product_filter.dart';

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
