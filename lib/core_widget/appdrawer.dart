import 'package:flutter/material.dart';
import 'package:my_tester/utility/local_storage.dart';
import 'package:my_tester/view/screen/authentication/login/login_page.dart';
import 'package:my_tester/view/screen/dashboard_screens/dashboard.dart';
import 'package:provider/provider.dart';

import '../controller/homepage/appdrawer_provider.dart'; // DrawerProvider
import '../controller/homepage/product_list_provider.dart';
import '../controller/userprofile_provider.dart';
import '../view/screen/home/product_list_screen.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    final drawerProvider = Provider.of<DrawerProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);

    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          // Profile Section at the top.
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(color: Colors.black87),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: (userProvider.userResponse != null &&
                      userProvider.userResponse!.user.profilePicture != null &&
                      userProvider
                          .userResponse!.user.profilePicture!.isNotEmpty)
                  ? NetworkImage(
                      userProvider.userResponse!.user.profilePicture!)
                  : const AssetImage('') as ImageProvider,
            ),
            accountName: Text(
              userProvider.userResponse != null
                  ? (userProvider.userResponse!.user.firstName! +
                      (userProvider.userResponse!.user.lastName != null &&
                              userProvider
                                  .userResponse!.user.lastName!.isNotEmpty
                          ? " ${userProvider.userResponse!.user.lastName}"
                          : ""))
                  : "Name",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            accountEmail: Text(
                userProvider.userResponse?.user.email ?? "abc@example.com"),
          ),

          ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Home"),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (context) => const DashboardScreen()),
                );
              }),
          const Divider(color: Colors.grey),
          Expanded(
            child: Consumer<ProductListController>(
              builder: (context, productProvider, _) {
                /** Extract unique categories from products **/
                final categories = productProvider.products
                    .map((product) => product.categoryName)
                    .toSet() // Remove duplicates
                    .toList();

                return ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    ExpansionTile(
                      title: const Text("Categories"),
                      leading: const Icon(Icons.category),
                      children: [
                        if (productProvider.isLoading)
                          const Center(child: CircularProgressIndicator())
                        else
                          ...categories.map((category) {
                            /** Extract unique subcategories from products **/
                            final subCategories = productProvider.products
                                .where((product) =>
                                    product.categoryName == category)
                                .map((product) => product.subCategoryName)
                                .toSet()
                                .toList();

                            return ExpansionTile(
                              title: Text(category),
                              leading:
                                  const Icon(Icons.label_important_outline),
                              children: [
                                ...subCategories.map((subCategory) {
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 24.0),
                                    child: ListTile(
                                      title: Text(
                                        subCategory,
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          // decoration:
                                          //     TextDecoration.underline,
                                        ),
                                      ),
                                      onTap: () {
                                        final products = productProvider
                                            .products
                                            .where((product) =>
                                                product.subCategoryName ==
                                                subCategory)
                                            .toList();
                                        print(
                                            "Selected SubCategory: ${products}");
                                        products.forEach((product) {
                                          print("""
                      Title: ${product.title}
                      Price: ₹${product.sellingPrice}
                      Price: ₹${product.categoryName}
                      Price: ₹${product.subCategory}
                      Image: ${product.productUrl ?? "N/A"}
                      --------------------------
                      """);
                                        });
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ProductDetailScreen(
                                                    product: products.first,
                                                    title: subCategory,
                                                  )),
                                        );
                                      },
                                    ),
                                  );
                                }).toList(),
                              ],
                            );
                          }).toList(),
                      ],
                    ),
                    const Divider(color: Colors.grey),
                    ListTile(
                      leading: const Icon(Icons.settings),
                      title: const Text("Settings"),
                      onTap: () => Navigator.pop(context),
                    ),
                  ],
                );
              },
            ),
          ),
          Divider(color: Colors.grey.shade300),
          Consumer<UserProvider>(
            builder: (context, userProvider, child) {
              if (userProvider.userResponse != null) {
                return ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text("Logout"),
                  onTap: () {
                    StorageHelper.removeToken();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                    // Add logout logic here.
                  },
                );
              } else {
                return ListTile(
                  leading: const Icon(Icons.login),
                  title: const Text("Login"),
                  // trailing: Text("data"),
                  onTap: () {
                    // Add login navigation logic here.
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
