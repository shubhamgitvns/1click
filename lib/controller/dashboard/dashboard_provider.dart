import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_tester/view/screen/dashboard_screens/cart_screen.dart';
import 'package:my_tester/view/screen/dashboard_screens/category_screen.dart';
import 'package:my_tester/view/screen/dashboard_screens/profile_screen.dart';
import 'package:my_tester/view/screen/dashboard_screens/wishlist_screen.dart';
import 'package:my_tester/view/screen/home/home_page.dart';

class DashboardProvider with ChangeNotifier {
  int currentIndex = 0;
  TabController? tabController;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool isProfile = false;
  bool isBack = false;

  // List of pages in the dashboard
  final List<Widget> pages = [
    HomePage(),
    CategoryScreen(),
    CartScreen(),
    WishListScreen(),
    ProfileScreen()
  ];

  /// Initialize the TabController and set initial values.
  /// It also checks for any route arguments (like isBack flag).
  void initTabController(TickerProvider vsync, BuildContext context) {
    tabController = TabController(length: pages.length, vsync: vsync);
    currentIndex = tabController!.index;
    // Check route arguments for back state, if any.
    final data = ModalRoute.of(context)?.settings.arguments;
    // isBack = data ?? false;
    notifyListeners();
  }

  /// Dispose the TabController when it's no longer needed.
  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }

  /// Change the tab index.
  /// If the cart tab (index 2) is selected, navigate to a dedicated cart view.
  void changeTab(int index, BuildContext context) {
    currentIndex = index;
    if (currentIndex == 2) {
      // Special logic for cart tab: navigate to cart view and reset currentIndex.
      currentIndex = 0;
      tabController?.animateTo(0,
          duration: const Duration(milliseconds: 1), curve: Curves.ease);
      // Navigator.pushNamed(context, routeName.cartView);
    }
    notifyListeners();
  }

  /// Programmatically move to a specific tab.
  /// If [isBack] is true, pop the current route.
  void moveTab(BuildContext context, int index, {bool isBack = false}) {
    if (isBack) {
      Navigator.pop(context);
    } else {
      currentIndex = index;
      tabController?.animateTo(index,
          duration: const Duration(milliseconds: 1), curve: Curves.ease);
      notifyListeners();
    }
  }

  /// Handle device back press based on current tab index.
  Future<void> onBackPress(int index) async {
    if (index == 0) {
      SystemNavigator.pop();
    }
  }

  /// Handle list tap events.
  /// Navigates to specific routes based on the tapped list item.
  // void onTapList(Map<String, dynamic> data, BuildContext context) {
  //   if (data['title'] == appFonts.pageList ||
  //       data['title'] == appFonts.setting ||
  //       data['title'] == appFonts.logout) {
  //     Navigator.pushNamed(context, data['route']);
  //   }
  // }
}
