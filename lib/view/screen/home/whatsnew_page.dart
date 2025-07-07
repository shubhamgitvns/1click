import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controller/homepage/product_list_provider.dart';
import '../../../data/model/product_list_model.dart';

class WhatsNew extends StatefulWidget {
  const WhatsNew({super.key});

  @override
  State<WhatsNew> createState() => _WhatsNewState();
}

class _WhatsNewState extends State<WhatsNew> {
  String? _selectedCategory;
  List<ProductList> _categoryProducts = [];
  List<ProductList> _filteredProducts = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_selectedCategory == null) {
      _selectFirstCategory();
    }
  }

  void _selectFirstCategory() {
    final productProvider = context.read<ProductListController>();
    final categories = _getUniqueCategories(productProvider.products);
    if (categories.isNotEmpty) {
      setState(() {
        _selectedCategory = categories[0];
        _filterProducts();
      });
    }
  }
  /** This code filter the product regarding today day **/

  void _filterProducts() {
    final productProvider = context.read<ProductListController>();
    final now = DateTime.now();
    final sevenDaysAgo = now.subtract(const Duration(days: 7));

    setState(() {
      _categoryProducts = productProvider.products
          .where((p) => p.categoryName == _selectedCategory)
          .toList();

      _filteredProducts = _categoryProducts.where((product) {
        if (product.createdAt == null) return false;
        return product.createdAt!.isAfter(sevenDaysAgo);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = context.watch<ProductListController>();
    final categories = _getUniqueCategories(productProvider.products);

    return Column(
      children: [
        if (_filteredProducts.isNotEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Center(
              child: Text(
                "What's New",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
              ),
            ),
          ),
        // if (_filteredProducts.isNotEmpty)
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      final isSelected = _selectedCategory == category;

                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedCategory = category;
                              _filterProducts();
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Colors.black87
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: isSelected
                                    ? Colors.black87
                                    : Colors.grey.shade50,
                                width: 1,
                              ),
                            ),
                            child: Text(
                              category,
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.black,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),

        // Products Grid View
        if (_selectedCategory != null)
          _filteredProducts.isEmpty
              ? Column(
                  children: [
                    const SizedBox(height: 40),
                    const Center(
                      child: Text(
                        'No new products available in this category',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ),
                    if (_categoryProducts.isNotEmpty)
                      const Center(
                        child: Text(
                          '(Showing only products from last 7 days)',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ),
                  ],
                )
              : GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: _filteredProducts.length,
                  itemBuilder: (context, index) {
                    final product = _filteredProducts[index];
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: product.productUrl != null
                                ? Image.network(
                                    product.productUrl!,
                                    fit: BoxFit.fill,
                                    width: double.infinity,
                                    height: double.infinity,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            const Icon(Icons.broken_image,
                                                size: 150, color: Colors.grey),
                                  )
                                : Container(
                                    color: Colors.grey.shade200,
                                    child: const Icon(Icons.image),
                                  ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '₹${product.price}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black87,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                    child: const Text(
                                      'Buy Now',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
      ],
    );
  }

  List<String> _getUniqueCategories(List<ProductList> products) {
    return products
        .map((p) => p.categoryName ?? "Uncategorized")
        .toSet()
        .toList();
  }
}
