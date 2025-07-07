import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controller/homepage/product_list_provider.dart';
import 'product_list_screen.dart';

class ExploreCollectionWidget extends StatelessWidget {
  const ExploreCollectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    /****** here the initialize provider  ************/
    return Consumer<ProductListController>(
      builder: (_, controller, __) {
        if (controller.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.errorMessage != null) {
          return Center(child: Text(controller.errorMessage!));
        }

        return SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.products.length,
            itemBuilder: (context, index) {
              final product = controller.products[index];

              return GestureDetector(
                onTap: () {
                  print(controller.products[index]);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProductDetailScreen(
                        product: controller.products[index],
                        title: "",
                      ),
                    ),
                  );
                },
                child: Container(
                  width: 140,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        spreadRadius: 2,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12)),
                        child: Image.network(
                          product.productUrl,
                          height: 100,
                          width: double.infinity,
                          fit: BoxFit.fill,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.broken_image,
                                  size: 100, color: Colors.grey),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Text(
                          product.categoryName,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
