class ProductList {
  final String id;
  final String vendorId;
  final String title;
  final String sku;
  final String productType;
  final String categoryId;
  final String description;
  final String? productImage;
  final double price;
  final double costPrice;
  final double salePrice;
  final double retailPrice;
  final String inventoryStatus;
  final String availability;
  final String globalTradeItemNumber;
  final String manufacturerPartNumber;
  final String brandName;
  final String productUpcEan;
  final int isShippingFree;
  final String? pageTitle;
  final String? metaKeywords;
  final String? metaDescription;
  final String productUrl;
  final String deliveryEventName;
  final String? deliveryFromDate;
  final String? deliveryToDate;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String subCategory;
  final int isImported;
  final String? importedFromVendor;
  final String shippingPrice;
  final String? importedProductReference;
  final int currentStock;
  final int lowStock;
  final dynamic sizes;
  final dynamic colorImages;
  final int peopleViewed;
  final String about;
  final String taxesAndCharges;
  final dynamic unit;
  final dynamic taxOptions;
  final int packagingCharges;
  final int isPackagingCharges;
  final int status;
  final int isFeaturedProduct;
  final String categoryName;
  final String subCategoryName;
  final int totalReviews;
  final double rating;
  final List<String> images;
  final List<dynamic> tags;
  // final double mrpPrice;
  // final double discountPrice;
  final String productName;
  final double sellingPrice;
  final String productId;
  ProductList({
    required this.id,
    required this.vendorId,
    required this.title,
    required this.sku,
    required this.productType,
    required this.categoryId,
    required this.description,
    required this.productImage,
    required this.price,
    required this.costPrice,
    required this.salePrice,
    required this.retailPrice,
    required this.inventoryStatus,
    required this.availability,
    required this.globalTradeItemNumber,
    required this.manufacturerPartNumber,
    required this.brandName,
    required this.productUpcEan,
    required this.isShippingFree,
    required this.pageTitle,
    required this.metaKeywords,
    required this.metaDescription,
    required this.productUrl,
    required this.deliveryEventName,
    required this.deliveryFromDate,
    required this.deliveryToDate,
    required this.createdAt,
    required this.updatedAt,
    required this.subCategory,
    required this.isImported,
    required this.importedFromVendor,
    required this.shippingPrice,
    required this.importedProductReference,
    required this.currentStock,
    required this.lowStock,
    required this.sizes,
    required this.colorImages,
    required this.peopleViewed,
    required this.about,
    required this.taxesAndCharges,
    required this.unit,
    required this.taxOptions,
    required this.packagingCharges,
    required this.isPackagingCharges,
    required this.status,
    required this.isFeaturedProduct,
    required this.categoryName,
    required this.subCategoryName,
    required this.totalReviews,
    required this.rating,
    required this.images,
    required this.tags,
    // required this.mrpPrice,
    // required this.discountPrice,
    required this.productName,
    required this.sellingPrice,
    required this.productId,
    required subcategory,
  });

  factory ProductList.fromJson(Map<String, dynamic> json) {
    return ProductList(
      productUrl: json['product']['productUrl'] ?? '',
      categoryName: json['product']['categoryName'] ?? '',
      subCategoryName: json['product']['subCategoryName'] ?? '',
      subcategory: json['product']['subcategory'] ?? '',
      id: json['product']['id'] ?? '',
      vendorId: json['product']['vendor_id'] ?? '',
      title: json['product']['title'] ?? '',
      sku: json['product']['sku'] ?? '',
      productType: json['product']['product_type'] ?? '',
      categoryId: json['product']['category_id'] ?? '',
      description: json['product']['description'] ?? '',
      productImage: json['product']['product_image'],
      price: (json['product']['price'] ?? 0).toDouble(),
      costPrice: (json['product']['cost_price'] ?? 0).toDouble(),
      salePrice: (json['product']['sale_price'] ?? 0).toDouble(),
      retailPrice: (json['product']['retail_price'] ?? 0).toDouble(),
      inventoryStatus: json['product']['inventory_status'] ?? '',
      availability: json['product']['availability'] ?? '',
      globalTradeItemNumber: json['product']['global_trade_item_number'] ?? '',
      manufacturerPartNumber: json['product']['manufacturer_part_number'] ?? '',
      brandName: json['product']['brand_name'] ?? '',
      productUpcEan: json['product']['product_upc_ean'] ?? '',
      isShippingFree: json['product']['is_shipping_free'] ?? 0,
      pageTitle: json['product']['page_title'],
      metaKeywords: json['product']['meta_keywords'],
      metaDescription: json['product']['meta_description'],
      deliveryEventName: json['product']['delivery_event_name'] ?? '',
      deliveryFromDate: json['product']['delivery_from_date'],
      deliveryToDate: json['product']['delivery_to_date'],
      createdAt: DateTime.parse(json['product']['created_at']),
      updatedAt: DateTime.parse(json['product']['updated_at']),
      subCategory: json['product']['subCategory'] ?? '',
      isImported: json['product']['is_imported'] ?? 0,
      importedFromVendor: json['product']['imported_from_vendor'],
      shippingPrice: json['product']['shippingPrice'] ?? '',
      importedProductReference: json['product']['imported_product_reference'],
      currentStock: json['product']['currentStock'] ?? 0,
      lowStock: json['product']['lowStock'] ?? 0,
      sizes: json['product']['sizes'],
      colorImages: json['product']['color_images'],
      peopleViewed: json['product']['people_viewed'] ?? 0,
      about: json['product']['about'] ?? '',
      taxesAndCharges: json['product']['taxesAndCharges'] ?? '',
      unit: json['product']['unit'],
      taxOptions: json['product']['taxOptions'],
      packagingCharges: json['product']['packagingCharges'] ?? 0,
      isPackagingCharges: json['product']['isPackagingCharges'] ?? 0,
      status: json['product']['status'] ?? 0,
      isFeaturedProduct: json['product']['isFeaturedProduct'] ?? 0,
      totalReviews: json['product']['totalReviews'] ?? 0,
      rating: (json['product']['rating'] ?? 0).toDouble(),
      productName: json['product']['productName'] ?? '',
      sellingPrice: (json['product']['sellingPrice'] ?? 0).toDouble(),
      productId: json['product']['productId'] ?? '',
      images: json['product']['images'] != null
          ? List<String>.from(json['product']['images'])
          : <String>[],
      tags: json['product']['tags'] ?? [],
      // mrpPrice: json['product']["mrpPrice"] ?? '',
      // discountPrice: json['product']["discountPrice"] ?? '',
    );
  }
}
