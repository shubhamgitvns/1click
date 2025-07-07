class BannerImage {
  final String title;
  final String description;
  final String image;

  BannerImage({
    required this.title,
    required this.description,
    required this.image,
  });

  factory BannerImage.fromJson(Map<String, dynamic> json) {
    return BannerImage(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
    );
  }
}

class BannerModel {
  final String bannerId;
  final String vendorId;
  final String bannerType;
  final String bannerUrl;
  final int resoureType;
  final int status;
  final String resourceType;
  final List<BannerImage> images;

  BannerModel({
    required this.bannerId,
    required this.vendorId,
    required this.bannerType,
    required this.bannerUrl,
    required this.resoureType,
    required this.status,
    required this.resourceType,
    required this.images,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      bannerId: json['bannerId'] ?? '',
      vendorId: json['vendorId'] ?? '',
      bannerType: json['bannerType'] ?? '',
      bannerUrl: json['bannerUrl'] ?? '',
      resoureType: json['resoureType'] ?? 0,
      status: json['status'] ?? 0,
      resourceType: json['resourceType'] ?? '',
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => BannerImage.fromJson(e))
              .toList() ??
          [],
    );
  }
}
