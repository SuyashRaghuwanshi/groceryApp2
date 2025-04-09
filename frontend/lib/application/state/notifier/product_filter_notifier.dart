import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/models/pagination.dart';
import 'package:frontend/models/product_filter.dart';

class ProductsFilterNotifier extends StateNotifier<ProductFilterModel> {
  ProductsFilterNotifier()
    : super(
        ProductFilterModel(
          paginationModel: PaginationModel(page: 0, pageSize: 10),
        ),
      );

  void setProductFilter(ProductFilterModel model) {
    state = model;
  }
}
