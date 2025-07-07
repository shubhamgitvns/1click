// class VendorIdModel {
//   Meta meta;
//   dynamic error;
//   Data data;
//
//   VendorIdModel({
//     required this.meta,
//     required this.error,
//     required this.data,
//   });
//
// }
//
// class Data {
//   String? logoId;
//   String? vendorId;
//   String? logoUrl;
//   String? email;
//   String? mobile;
//
//
//   Data({
//      this.logoId,
//      this.vendorId,
//      this.logoUrl,
//      this.email,
//      this.mobile,
//
//   });
//   Data.fromJson(Map<String, dynamic> json) {
//     logoId = json['logoId'];
//     vendorId = json['vendorId'];
//     logoUrl = json['logoUrl'];
//     email = json['email'];
//     mobile = json['mobile'].toDouble();
//
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['logoId'] = logoId;
//     data['vendorId'] = vendorId;
//     data['logoUrl'] = logoUrl;
//     data['email'] = email;
//     data['mobile'] = mobile;
//
//     return data;
//   }
// }
//
// class Meta {
//   dynamic paginationInfo;
//
//   Meta({
//     required this.paginationInfo,
//   });
//
// }
class VendorIdModel {
   String? vendorId;
   String? logoUrl;

  VendorIdModel({ this.vendorId,  this.logoUrl});
      VendorIdModel.fromJson(Map<String, dynamic> json) {
    vendorId = json['vendorId'];
    logoUrl = json['logoUrl'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['vendorId'] = vendorId ?? '';
    data['logoUrl'] = logoUrl ?? '';


    return data;
  }
}


