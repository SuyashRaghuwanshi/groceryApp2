import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/api/api_service.dart';
import 'package:frontend/application/state/cart_state.dart';
import 'package:frontend/models/cart_product.dart';

class CartNotifier extends StateNotifier<CartState> {
  final APIService _apiService;

  CartNotifier(this._apiService) : super(const CartState()) {
    getCartItem();
  }
  Future<void> getCartItem() async {
    state = state.copyWith(isLoading: true);

    final cartData = await _apiService.getCart();

    state = state.copyWith(cartModel: cartData);
    state = state.copyWith(isLoading: false);
  }

  Future<void> addCartItem(productId, qty) async {
    await _apiService.addCartItem(productId, qty);
    log("Added to cart: $productId , qty: $qty");

    await getCartItem();
  }

  Future<void> removeCartItem(productId, qty) async {
    await _apiService.removeCartItem(productId, qty);

    final currentCart = state.cartModel!;

    final updatedProducts =
        currentCart.products
            .where((item) => item.product.productId != productId)
            .toList(); // Creates a new list

    final newTotal = updatedProducts.fold(
      0.0,
      (sum, item) => sum + (item.qty * item.product.productSalePrice),
    );

    final updatedCart = currentCart.copyWith(products: updatedProducts);

    state = state.copyWith(cartModel: updatedCart);
  }

  // Future<void> removeCartItem(productId, qty) async {
  //   await _apiService.removeCartItem(productId, qty);

  //   final updatedProducts = List<CartProduct>.from(state.cartModel!.products)
  //     ..removeWhere((element) => element.product.productId == productId);

  //   final updatedCartModel = state.cartModel!.copyWith(
  //     products: updatedProducts,
  //   );

  //   state = state.copyWith(cartModel: updatedCartModel);
  // }

  // Future<void> updateQty(productId, qty, type) async {
  //   final updatedProducts = List<CartProduct>.from(state.cartModel!.products);
  //   final index = updatedProducts.indexWhere(
  //     (element) => element.product.productId == productId,
  //   );

  //   if (index != -1) {
  //     final cartItem = updatedProducts[index];

  //     if (type == "-") {
  //       await _apiService.removeCartItem(productId, 1);

  //       if (cartItem.qty > 1) {
  //         updatedProducts[index] = cartItem.copyWith(qty: cartItem.qty - 1);
  //       } else {
  //         updatedProducts.removeAt(index);
  //       }
  //     } else {
  //       await _apiService.addCartItem(productId, 1);
  //       updatedProducts[index] = cartItem.copyWith(qty: cartItem.qty + 1);
  //     }

  //     final updatedCartModel = state.cartModel!.copyWith(
  //       products: updatedProducts,
  //     );
  //     state = state.copyWith(cartModel: updatedCartModel);
  //   }
  // }

  // Future<void> updateQty(productId, qty, type) async {
  //   var cartItem = state.cartModel!.products.firstWhere(
  //     (element) => element.product.productId == productId,
  //   );
  //   var updatedItems = state.cartModel!;

  //   if (type == "-") {
  //     await _apiService.removeCartItem(productId, 1);

  //     if (cartItem.qty > 1) {
  //       CartProduct cartProduct = CartProduct(
  //         qty: cartItem.qty,
  //         product: cartItem.product,
  //       );
  //       updatedItems.products.remove(cartItem);
  //       updatedItems.products.add(cartProduct);
  //     } else {
  //       updatedItems.products.remove(cartItem);
  //     }
  //   } else {
  //     await _apiService.addCartItem(productId, 1);

  //     CartProduct cartProduct = CartProduct(
  //       qty: cartItem.qty + 1,
  //       product: cartItem.product,
  //     );
  //     updatedItems.products.remove(cartItem);
  //     updatedItems.products.add(cartProduct);
  //   }
  //   state = state.copyWith(cartModel: updatedItems);
  // }

  Future<void> updateQty(productId, qty, type) async {
    final currentCart = state.cartModel!;
    final cartItem = currentCart.products.firstWhere(
      (element) => element.product.productId == productId,
    );

    List<CartProduct> updatedProducts = List.from(currentCart.products);

    if (type == "-") {
      await _apiService.removeCartItem(productId, 1);

      if (cartItem.qty > 1) {
        updatedProducts.remove(cartItem);
        updatedProducts.add(
          CartProduct(qty: cartItem.qty - 1, product: cartItem.product),
        );
      } else {
        updatedProducts.remove(cartItem);
      }
    } else {
      await _apiService.addCartItem(productId, 1);

      updatedProducts.remove(cartItem);
      updatedProducts.add(
        CartProduct(qty: cartItem.qty + 1, product: cartItem.product),
      );
    }

    // Optional: sort updated list if needed
    // updatedProducts.sort((a, b) => a.product.productId.compareTo(b.product.productId));

    final newTotal = updatedProducts.fold(
      0.0,
      (sum, item) => sum + (item.qty * item.product.productSalePrice),
    );

    final updatedCart = currentCart.copyWith(
      products: updatedProducts,
      // grandTotal: newTotal,
    );

    state = state.copyWith(cartModel: updatedCart);
  }
}
