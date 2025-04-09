import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:frontend/models/pagination.dart';

part 'product_sort.freezed.dart';

@freezed
abstract class ProductSortModel with _$ProductSortModel {
  factory ProductSortModel({
    required PaginationModel paginationModel, // Kept as required
    String? value, // Added explicit type
    String? label,
  }) = _ProductSortModel;
}
