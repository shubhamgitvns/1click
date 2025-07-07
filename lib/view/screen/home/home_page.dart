import 'package:flutter/material.dart';
import 'package:my_tester/controller/authentication/login_provider.dart';
import 'package:my_tester/utility/local_storage.dart';
import 'package:my_tester/view/screen/home/xyz.dart';
import 'package:provider/provider.dart';

import '../../../core_widget/appdrawer.dart';
import '../../../data/model/home/category_model.dart';
import 'explore_collections_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Category? selectedCategory;
  // late Future<Data> _futureLogo;
  bool isLoading = true;
  String? LogoUrl;
  @override
  void initState() {
    super.initState();
    Provider.of<LoginProvider>(context, listen: false).fetchLogoData();

    loadLogo();

    Future.delayed(Duration.zero, () {});
  }

  void loadLogo() async {
    final url = await StorageHelper.getLogoUrl();
    setState(() {
      LogoUrl = url;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Home"),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 15.0),
            child: LogoDisplay(), // your short logo widget
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      drawer: const AppDrawer(),
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Center(
                  child: Text(
                "Explore Collections",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
              )),
            ),
            ExploreCollectionWidget(),
          ],
        ),
      ),
    );
  }
}
