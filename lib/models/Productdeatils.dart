// class Productdeatils {
//   String? result;
//   String? message;
//   List<Data>? data;
//
//   Productdeatils({this.result, this.message, this.data});
//
//   Productdeatils.fromJson(Map<String, dynamic> json) {
//     result = json['result'];
//     message = json['message'];
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(new Data.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['result'] = this.result;
//     data['message'] = this.message;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Data {
//   String? productId;
//   String? categoryId;
//   String? venderId;
//   String? productName;
//   String? description;
//   List<String>? images;
//   String? productCode;
//   String? productType;
//   String? productPreparationTime;
//   var mrpPrice;
//   var salePrice;
//   var discount;
//   String? discountType;
//   String? productDetails;
//   String? brandName;
//   var likeStatus;
//   var rating;
//   var totalRating;
//   var cartStatus;
//   var qty;
//   List<String>? size;
//   List<String>? color;
//   String? warranty;
//   String? note;
//   List<ReturnType>? returnType;
//   List<Stock>? stock;
//   List<Tax>? tax;
//   String? productWeight;
//   String? deliveryType;
//   var minimumOrder;
//   String? shopLogo;
//   String? shopAddress;
//   String? shopCountry;
//   String? shopCity;
//   String? shopName;
//   var totalProduct;
//   var totalSale;
//   var totalRater;
//   var averageRating;
//   var deliveryFee;
//   var deliveryTime;
//   var likedTime;
//   var pageViews;
//   List<ReviewsList>? reviewsList;
//   List<Moreproducts>? moreproducts;
//
//   Data(
//       {this.productId,
//         this.categoryId,
//         this.venderId,
//         this.productName,
//         this.description,
//         this.images,
//         this.productCode,
//         this.productType,
//         this.productPreparationTime,
//         this.mrpPrice,
//         this.salePrice,
//         this.discount,
//         this.discountType,
//         this.productDetails,
//         this.brandName,
//         this.likeStatus,
//         this.rating,
//         this.totalRating,
//         this.cartStatus,
//         this.qty,
//         this.size,
//         this.color,
//         this.warranty,
//         this.note,
//         this.returnType,
//         this.stock,
//         this.tax,
//         this.productWeight,
//         this.deliveryType,
//         this.minimumOrder,
//         this.shopLogo,
//         this.shopAddress,
//         this.shopCountry,
//         this.shopCity,
//         this.shopName,
//         this.totalProduct,
//         this.totalSale,
//         this.totalRater,
//         this.averageRating,
//         this.deliveryFee,
//         this.deliveryTime,
//         this.likedTime,
//         this.pageViews,
//         this.reviewsList,
//         this.moreproducts});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     productId = json['productId'];
//     categoryId = json['categoryId'];
//     venderId = json['venderId'];
//     productName = json['product_name'];
//     description = json['description'];
//     images = json['images'].cast<String>();
//     productCode = json['product_code'];
//     productType = json['productType'];
//     productPreparationTime = json['productPreparation_time'];
//     mrpPrice = json['mrp_price'];
//     salePrice = json['sale_price'];
//     discount = json['discount'];
//     discountType = json['discountType'];
//     productDetails = json['product_details'];
//     brandName = json['brand_name'];
//     likeStatus = json['like_status'];
//     rating = json['rating'];
//     totalRating = json['total_rating'];
//     cartStatus = json['cart_status'];
//     qty = json['qty'];
//     size = json['size'].cast<String>();
//     color = json['color'].cast<String>();
//     warranty = json['warranty'];
//     note = json['note'];
//     if (json['returnType'] != null) {
//       returnType = <ReturnType>[];
//       json['returnType'].forEach((v) {
//         returnType!.add(new ReturnType.fromJson(v));
//       });
//     }
//     if (json['stock'] != null) {
//       stock = <Stock>[];
//       json['stock'].forEach((v) {
//         stock!.add(new Stock.fromJson(v));
//       });
//     }
//     if (json['Tax'] != null) {
//       tax = <Tax>[];
//       json['Tax'].forEach((v) {
//         tax!.add(new Tax.fromJson(v));
//       });
//     }
//     productWeight = json['product_weight'];
//     deliveryType = json['deliveryType'];
//     minimumOrder = json['minimum_order'];
//     shopLogo = json['shop_logo'];
//     shopAddress = json['shop_address'];
//     shopCountry = json['shop_country'];
//     shopCity = json['shop_city'];
//     shopName = json['shop_name'];
//     totalProduct = json['total_product'];
//     totalSale = json['total_sale'];
//     totalRater = json['total_rater'];
//     averageRating = json['average_rating'];
//     deliveryFee = json['delivery_fee'];
//     deliveryTime = json['delivery__time'];
//     likedTime = json['liked__time'];
//     pageViews = json['page__views'];
//     if (json['reviews_list'] != null) {
//       reviewsList = <ReviewsList>[];
//       json['reviews_list'].forEach((v) {
//         reviewsList!.add(new ReviewsList.fromJson(v));
//       });
//     }
//     if (json['moreproducts'] != null) {
//       moreproducts = <Moreproducts>[];
//       json['moreproducts'].forEach((v) {
//         moreproducts!.add(new Moreproducts.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['productId'] = this.productId;
//     data['categoryId'] = this.categoryId;
//     data['venderId'] = this.venderId;
//     data['product_name'] = this.productName;
//     data['description'] = this.description;
//     data['images'] = this.images;
//     data['product_code'] = this.productCode;
//     data['productType'] = this.productType;
//     data['productPreparation_time'] = this.productPreparationTime;
//     data['mrp_price'] = this.mrpPrice;
//     data['sale_price'] = this.salePrice;
//     data['discount'] = this.discount;
//     data['discountType'] = this.discountType;
//     data['product_details'] = this.productDetails;
//     data['brand_name'] = this.brandName;
//     data['like_status'] = this.likeStatus;
//     data['rating'] = this.rating;
//     data['total_rating'] = this.totalRating;
//     data['cart_status'] = this.cartStatus;
//     data['qty'] = this.qty;
//     data['size'] = this.size;
//     data['color'] = this.color;
//     data['warranty'] = this.warranty;
//     data['note'] = this.note;
//     if (this.returnType != null) {
//       data['returnType'] = this.returnType!.map((v) => v.toJson()).toList();
//     }
//     if (this.stock != null) {
//       data['stock'] = this.stock!.map((v) => v.toJson()).toList();
//     }
//     if (this.tax != null) {
//       data['Tax'] = this.tax!.map((v) => v.toJson()).toList();
//     }
//     data['product_weight'] = this.productWeight;
//     data['deliveryType'] = this.deliveryType;
//     data['minimum_order'] = this.minimumOrder;
//     data['shop_logo'] = this.shopLogo;
//     data['shop_address'] = this.shopAddress;
//     data['shop_country'] = this.shopCountry;
//     data['shop_city'] = this.shopCity;
//     data['shop_name'] = this.shopName;
//     data['total_product'] = this.totalProduct;
//     data['total_sale'] = this.totalSale;
//     data['total_rater'] = this.totalRater;
//     data['average_rating'] = this.averageRating;
//     data['delivery_fee'] = this.deliveryFee;
//     data['delivery__time'] = this.deliveryTime;
//     data['liked__time'] = this.likedTime;
//     data['page__views'] = this.pageViews;
//     if (this.reviewsList != null) {
//       data['reviews_list'] = this.reviewsList!.map((v) => v.toJson()).toList();
//     }
//     if (this.moreproducts != null) {
//       data['moreproducts'] = this.moreproducts!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class ReturnType {
//   bool? type;
//   var value;
//   String? sId;
//
//   ReturnType({this.type, this.value, this.sId});
//
//   ReturnType.fromJson(Map<String, dynamic> json) {
//     type = json['type'];
//     value = json['value'];
//     sId = json['_id'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['type'] = this.type;
//     data['value'] = this.value;
//     data['_id'] = this.sId;
//     return data;
//   }
// }
//
// class Stock {
//   String? stockName;
//   var stockValue;
//   String? sId;
//
//   Stock({this.stockName, this.stockValue, this.sId});
//
//   Stock.fromJson(Map<String, dynamic> json) {
//     stockName = json['stock_name'];
//     stockValue = json['stock_value'];
//     sId = json['_id'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['stock_name'] = this.stockName;
//     data['stock_value'] = this.stockValue;
//     data['_id'] = this.sId;
//     return data;
//   }
// }
//
// class Tax {
//   String? taxName;
//   var taxValue;
//   String? sId;
//
//   Tax({this.taxName, this.taxValue, this.sId});
//
//   Tax.fromJson(Map<String, dynamic> json) {
//     taxName = json['tax_name'];
//     taxValue = json['tax_value'];
//     sId = json['_id'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['tax_name'] = this.taxName;
//     data['tax_value'] = this.taxValue;
//     data['_id'] = this.sId;
//     return data;
//   }
// }
//
// class ReviewsList {
//   String? rating;
//   String? comment;
//   String? userNamef;
//   String? userNamel;
//   String? userImage;
//
//   ReviewsList(
//       {this.rating,
//         this.comment,
//         this.userNamef,
//         this.userNamel,
//         this.userImage});
//
//   ReviewsList.fromJson(Map<String, dynamic> json) {
//     rating = json['rating'];
//     comment = json['comment'];
//     userNamef = json['user_namef'];
//     userNamel = json['user_namel'];
//     userImage = json['user_image'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['rating'] = this.rating;
//     data['comment'] = this.comment;
//     data['user_namef'] = this.userNamef;
//     data['user_namel'] = this.userNamel;
//     data['user_image'] = this.userImage;
//     return data;
//   }
// }
//
// class Moreproducts {
//   String? image;
//   String? productId;
//   String? shopId;
//
//   Moreproducts({this.image, this.productId, this.shopId});
//
//   Moreproducts.fromJson(Map<String, dynamic> json) {
//     image = json['image'];
//     productId = json['productId'];
//     shopId = json['shopId'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['image'] = this.image;
//     data['productId'] = this.productId;
//     data['shopId'] = this.shopId;
//     return data;
//   }
// }
