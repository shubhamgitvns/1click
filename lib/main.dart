import 'package:flutter/material.dart';
import 'package:my_tester/controller/authentication/login_provider.dart';
import 'package:my_tester/controller/authentication/registration_provider.dart';
import 'package:my_tester/controller/dashboard/dashboard_provider.dart';
import 'package:my_tester/controller/homepage/banner_provider.dart';
import 'package:my_tester/controller/homepage/product_list_provider.dart';
import 'package:my_tester/controller/userprofile_provider.dart';
import 'package:my_tester/utility/local_storage.dart';
import 'package:my_tester/view/screen/splash_screen.dart';
import 'package:provider/provider.dart';

import 'controller/homepage/appdrawer_provider.dart';
import 'controller/homepage/category_provider.dart';
import 'controller/homepage/product_provider.dart';
import 'controller/sub_categery_provider.dart';
import 'controller/subcategory_product_provider.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await fetchUserData();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CategoryProvider()..loadCategories(),
        ),
        ChangeNotifierProvider(
          create: (_) => SubCategoryProvider(),
        ),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => RegistrationProvider()),
        ChangeNotifierProvider(create: (_) => DashboardProvider()),
        ChangeNotifierProvider(
            create: (_) => ProductListController()..loadProducts()),
        ChangeNotifierProvider(create: (_) => DrawerProvider()),
        ChangeNotifierProvider(create: (_) => SubCategoryProjectProvider()),
        ChangeNotifierProvider(create: (_) => BannerProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Category App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}
