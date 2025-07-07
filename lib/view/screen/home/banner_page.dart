import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controller/homepage/banner_provider.dart';
import '../../../data/model/home/banner_model.dart';
import '../../../data/model/home/banner_model.dart';

class BannerSlider extends StatefulWidget {
  const BannerSlider({
    Key? key,
  }) : super(key: key);

  @override
  State<BannerSlider> createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Start automatic sliding every 3 seconds.
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_pageController.hasClients) {
        // Retrieve the banners list from provider (already loaded)
        final banners = Provider.of<BannerProvider>(context, listen: false)
            .getBannersByVendor();
        if (banners.isNotEmpty) {
          int nextPage = _currentPage + 1;
          if (nextPage >= banners.length) {
            nextPage = 0;
          }
          _pageController.animateToPage(
            nextPage,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BannerProvider>(
      builder: (context, bannerProvider, child) {
        final List<BannerModel> banners = bannerProvider.getBannersByVendor();
        if (banners.isEmpty) {
          return const SizedBox.shrink();
        }
        return Column(
          children: [
            SizedBox(
              height: 250, // Adjust height as needed
              child: PageView.builder(
                controller: _pageController,
                itemCount: banners.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  BannerModel banner = banners[index];
                  // Use the first image from the banner's images list.
                  String imageUrl =
                      banner.images.isNotEmpty ? banner.images[0].image : "";
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(imageUrl),
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            // Mini circular indicators below the slider.
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(banners.length, (index) {
                return GestureDetector(
                  onTap: () {
                    _pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentPage == index
                          ? Colors.black
                          : Colors.grey.shade300,
                    ),
                  ),
                );
              }),
            )
          ],
        );
      },
    );
  }
}
