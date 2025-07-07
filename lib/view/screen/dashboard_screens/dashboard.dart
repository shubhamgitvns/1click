import 'package:flutter/material.dart';
import 'package:my_tester/view/screen/home/home_page.dart';

import 'cart_screen.dart';
import 'category_screen.dart';
import 'profile_screen.dart';
import 'wishlist_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int currentIndex = 0;
  final PageController pageController = PageController();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    if (currentIndex != 0) {
      setState(() {
        currentIndex = 0;
      });
      pageController.animateToPage(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
      return false;
    }
    return true; // If already on home page, allow app to close.
  }

  @override
  Widget build(BuildContext context) {
    // Calculate width for each nav item based on screen width (5 items).
    final double navItemWidth = MediaQuery.of(context).size.width / 5;

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: PageView(
          controller: pageController,
          onPageChanged: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          children: const [
            HomePage(),
            CategoryScreen(),
            CartScreen(),
            WishListScreen(),
            ProfileScreen(),
          ],
        ),
        bottomNavigationBar: Container(
          height: 60,
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 2),
            ],
          ),
          child: Stack(
            children: [
              // Animated slider indicator at the bottom of the nav bar

              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavItem(
                        icon: Icons.home, index: 0, navItemWidth: navItemWidth),
                    _buildNavItem(
                      icon: Icons.category,
                      index: 1,
                      navItemWidth: navItemWidth,
                    ),
                    _buildNavItem(
                        icon: Icons.shopping_cart,
                        index: 2,
                        navItemWidth: navItemWidth),
                    _buildNavItem(
                        icon: Icons.favorite,
                        index: 3,
                        navItemWidth: navItemWidth),
                    _buildNavItem(
                        icon: Icons.person,
                        index: 4,
                        navItemWidth: navItemWidth),
                  ],
                ),
              ),

              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease,
                left: navItemWidth * currentIndex,
                top: 0,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(15)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required int index,
    required double navItemWidth,
  }) {
    return GestureDetector(
      onTap: () {
        // Calculate difference BEFORE updating currentIndex
        final int diff = (currentIndex - index).abs();
        if (diff > 1) {
          // If difference is more than 1, update state and jump immediately
          setState(() {
            currentIndex = index;
          });
          pageController.jumpToPage(index);
        } else {
          // Otherwise, animate smoothly to the target page
          setState(() {
            currentIndex = index;
          });
          pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.ease,
          );
        }
      },
      child: SizedBox(
        width: navItemWidth,
        child: Icon(
          icon,
          size: 30,
          color: currentIndex == index ? Colors.black : Colors.grey,
        ),
      ),
    );
  }
}
