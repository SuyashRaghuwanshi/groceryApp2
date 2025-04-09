// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_sort.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProductSortModel {

 PaginationModel get paginationModel;// Kept as required
 String? get value;// Added explicit type
 String? get label;
/// Create a copy of ProductSortModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductSortModelCopyWith<ProductSortModel> get copyWith => _$ProductSortModelCopyWithImpl<ProductSortModel>(this as ProductSortModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductSortModel&&(identical(other.paginationModel, paginationModel) || other.paginationModel == paginationModel)&&(identical(other.value, value) || other.value == value)&&(identical(other.label, label) || other.label == label));
}


@override
int get hashCode => Object.hash(runtimeType,paginationModel,value,label);

@override
String toString() {
  return 'ProductSortModel(paginationModel: $paginationModel, value: $value, label: $label)';
}


}

/// @nodoc
abstract mixin class $ProductSortModelCopyWith<$Res>  {
  factory $ProductSortModelCopyWith(ProductSortModel value, $Res Function(ProductSortModel) _then) = _$ProductSortModelCopyWithImpl;
@useResult
$Res call({
 PaginationModel paginationModel, String? value, String? label
});


$PaginationModelCopyWith<$Res> get paginationModel;

}
/// @nodoc
class _$ProductSortModelCopyWithImpl<$Res>
    implements $ProductSortModelCopyWith<$Res> {
  _$ProductSortModelCopyWithImpl(this._self, this._then);

  final ProductSortModel _self;
  final $Res Function(ProductSortModel) _then;

/// Create a copy of ProductSortModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? paginationModel = null,Object? value = freezed,Object? label = freezed,}) {
  return _then(_self.copyWith(
paginationModel: null == paginationModel ? _self.paginationModel : paginationModel // ignore: cast_nullable_to_non_nullable
as PaginationModel,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String?,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of ProductSortModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaginationModelCopyWith<$Res> get paginationModel {
  
  return $PaginationModelCopyWith<$Res>(_self.paginationModel, (value) {
    return _then(_self.copyWith(paginationModel: value));
  });
}
}


/// @nodoc


class _ProductSortModel implements ProductSortModel {
   _ProductSortModel({required this.paginationModel, this.value, this.label});
  

@override final  PaginationModel paginationModel;
// Kept as required
@override final  String? value;
// Added explicit type
@override final  String? label;

/// Create a copy of ProductSortModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductSortModelCopyWith<_ProductSortModel> get copyWith => __$ProductSortModelCopyWithImpl<_ProductSortModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductSortModel&&(identical(other.paginationModel, paginationModel) || other.paginationModel == paginationModel)&&(identical(other.value, value) || other.value == value)&&(identical(other.label, label) || other.label == label));
}


@override
int get hashCode => Object.hash(runtimeType,paginationModel,value,label);

@override
String toString() {
  return 'ProductSortModel(paginationModel: $paginationModel, value: $value, label: $label)';
}


}

/// @nodoc
abstract mixin class _$ProductSortModelCopyWith<$Res> implements $ProductSortModelCopyWith<$Res> {
  factory _$ProductSortModelCopyWith(_ProductSortModel value, $Res Function(_ProductSortModel) _then) = __$ProductSortModelCopyWithImpl;
@override @useResult
$Res call({
 PaginationModel paginationModel, String? value, String? label
});


@override $PaginationModelCopyWith<$Res> get paginationModel;

}
/// @nodoc
class __$ProductSortModelCopyWithImpl<$Res>
    implements _$ProductSortModelCopyWith<$Res> {
  __$ProductSortModelCopyWithImpl(this._self, this._then);

  final _ProductSortModel _self;
  final $Res Function(_ProductSortModel) _then;

/// Create a copy of ProductSortModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? paginationModel = null,Object? value = freezed,Object? label = freezed,}) {
  return _then(_ProductSortModel(
paginationModel: null == paginationModel ? _self.paginationModel : paginationModel // ignore: cast_nullable_to_non_nullable
as PaginationModel,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String?,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of ProductSortModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaginationModelCopyWith<$Res> get paginationModel {
  
  return $PaginationModelCopyWith<$Res>(_self.paginationModel, (value) {
    return _then(_self.copyWith(paginationModel: value));
  });
}
}

// dart format on
