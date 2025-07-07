import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utility/images.dart';
import '../../../utility/local_storage.dart';

class ProductWidgetItem extends StatelessWidget {
  // final ProductList product;
  const ProductWidgetItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Center(
            child: Text(
              'Best Selling Product',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
            ),
          ),
        ),
        GridView.builder(
          itemCount: 6,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
            childAspectRatio: 0.45,
          ),
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border:
                    Border.all(color: CupertinoColors.systemGrey4, width: 0.5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    child: Image.asset(
                      Images.image,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '1200 ML Insulated Tumbler',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Text(
                    '₹ 998',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'No Color available',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () async {
                      String? token = await StorageHelper.getToken();
                      if (token != null) {
                        print("Exist");
                        // Proceed with next steps (navigate, purchase etc.)
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            behavior: SnackBarBehavior.floating,
                            elevation: 8,
                            duration: Duration(seconds: 3),
                            backgroundColor: Colors.redAccent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            content: const Row(
                              children: [
                                Icon(Icons.lock_outline, color: Colors.white),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    'You are not signed in. Please log in to continue.',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    },
                    child: Container(
                      height: 36,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: CupertinoColors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        'Buy Now',
                        style: TextStyle(
                          color: CupertinoColors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
