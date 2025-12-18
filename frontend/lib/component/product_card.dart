import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:frontend/config.dart';
import 'package:frontend/models/product.dart';

class ProductCard extends StatelessWidget {
  final Product? model;
  const ProductCard({super.key, this.model});
  @override
  Widget build(BuildContext context) {
    // return Container(
    //   width: 150,
    //   decoration: const BoxDecoration(color: Colors.white),
    //   margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    //   child: Stack(
    //     children: [
    //       Column(
    //         mainAxisSize: MainAxisSize.min,
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         children: [
    //           Visibility(
    //             visible: model!.calculateDiscount > 0,
    //             child: Align(
    //               alignment: Alignment.topLeft,
    //               child: Container(
    //                 padding: const EdgeInsets.all(5),
    //                 decoration: const BoxDecoration(color: Colors.green),
    //                 child: Text(
    //                   "${model!.calculateDiscount}% OFF",
    //                   style: const TextStyle(
    //                     color: Colors.white,
    //                     fontSize: 12,
    //                     fontWeight: FontWeight.w600,
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ),
    //           GestureDetector(
    //             child: SizedBox(
    //               height: 100,
    //               width: MediaQuery.of(context).size.width,
    //               child: Image.network(model!.fullImagePath, fit: BoxFit.cover),
    //             ),
    //             onTap: () {
    //               Navigator.of(context).pushNamed(
    //                 "/product-details",
    //                 arguments: {'productId': model!.productId},
    //               );
    //             },
    //           ),
    //           Padding(
    //             padding: const EdgeInsets.only(top: 8, left: 10),
    //             child: Text(
    //               model!.productName,
    //               textAlign: TextAlign.left,
    //               overflow: TextOverflow.ellipsis,
    //               style: TextStyle(
    //                 fontSize: 13,
    //                 color: Colors.black,
    //                 fontWeight: FontWeight.bold,
    //               ),
    //             ),
    //           ),
    //           Padding(
    //             padding: const EdgeInsets.all(8.0),
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               crossAxisAlignment: CrossAxisAlignment.center,
    //               children: [
    //                 Flexible(
    //                   child: Row(
    //                     children: [
    //                       Text(
    //                         "${Config.currency}${model!.productPrice.toString()}",
    //                         textAlign: TextAlign.left,
    //                         style: TextStyle(
    //                           fontSize: 12,
    //                           color:
    //                               model!.calculateDiscount > 0
    //                                   ? Colors.red
    //                                   : Colors.black,
    //                           fontWeight: FontWeight.bold,
    //                           decoration:
    //                               model!.productSalePrice > 0
    //                                   ? TextDecoration.lineThrough
    //                                   : null,
    //                         ),
    //                       ),
    //                       Text(
    //                         (model!.calculateDiscount > 0
    //                             ? "${model!.productSalePrice.toString()}"
    //                             : ""),
    //                         textAlign: TextAlign.left,
    //                         style: const TextStyle(
    //                           fontSize: 12,
    //                           color: Colors.black,
    //                           fontWeight: FontWeight.bold,
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    // GestureDetector(
    //   child: Icon(Icons.favorite, color: Colors.grey, size: 20),
    //   onTap: () {
    //     Navigator.of(context).pushNamed(
    //       "/product-details",
    //       arguments: {'productId': model!.productId},
    //     );
    //   },
    // ),
    //               ],
    //             ),
    //           ),
    //         ],
    //       ),
    //     ],
    //   ),
    // );
    return Container(
      width: 150,
      height: 220, // Or 230 depending on your design
      decoration: const BoxDecoration(color: Colors.white),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // discount
          if (model!.calculateDiscount > 0)
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                padding: const EdgeInsets.all(5),
                color: Colors.green,
                child: Text(
                  "${model!.calculateDiscount}% OFF",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

          // image with fixed height
          // SizedBox(
          //   height: 100,
          //   child: Image.network(model!.fullImagePath, fit: BoxFit.cover),
          // ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                "/product-details",
                arguments: {'productId': model!.productId},
              );
            },
            child: SizedBox(
              height: 100,
              child: Image.network(
                Uri.encodeFull(model!.fullImagePath),
                fit: BoxFit.cover,
                gaplessPlayback: true,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  ;
                  log("PRODUCT IMAGE ERROR: $error");
                  return const Icon(
                    Icons.broken_image,
                    size: 40,
                    color: Colors.grey,
                  );
                },
              ),
            ),
          ),

          // product name
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 10),
            child: Text(
              model!.productName,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
          ),

          // price row
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Row(
                    children: [
                      Text(
                        "${Config.currency}${model!.productPrice}",
                        style: TextStyle(
                          fontSize: 12,
                          color:
                              model!.calculateDiscount > 0
                                  ? Colors.red
                                  : Colors.black,
                          decoration:
                              model!.productSalePrice > 0
                                  ? TextDecoration.lineThrough
                                  : null,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (model!.calculateDiscount > 0)
                        Text(
                          "${model!.productSalePrice}",
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ],
                  ),
                ),
                Icon(Icons.favorite, color: Colors.grey, size: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
