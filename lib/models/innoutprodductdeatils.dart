// import 'dart:convert';
// /// result : "true"
// /// message : "product data get successfully"
// /// data : [{"productId":"65f44fbc5583e792f44530de","categoryId":"65f3e6fa1c20e8bb0a86c83e","venderId":"65f400381df960de87b7acbb","product_name":"pizza","description":"corn pizza","images":["pizza-1239077_640.jpg","pizza-346985_640.jpg","pizza-2068272.jpg","pizza-5275191_640.jpg","pizza-329523_640.jpg"],"product_code":"455","productType":"Kohinoor","productSize":"large","productPreparation_time":"25 Minutes","mrp_price":299,"sale_price":269.1,"discount":10,"discountType":"Amount","product_details":"corn , garlic, cheese ,wheat ","like_status":0,"rating":0,"total_rating":0,"cart_status":0,"qty":0,"size":[],"color":[],"note":"direct to eat","returnType":[],"stock":[],"Tax":[{"tax_name":"Exclude","tax_value":18,"_id":"65f44fbc5583e792f44530e0"}],"product_weight":"2 KG","deliveryType":"Yes","minimum_order":5,"shop_logo":"IMG_20230707_114651284.jpg","shop_address":"indire","shop_country":"+91","shop_city":"Vijay Nagar, Indore, Madhya Pradesh, India","shop_name":"damru cafe","total_product":2,"total_sale":0,"total_rater":0,"average_rating":0,"delivery_fee":0,"delivery__time":0,"liked__time":0,"page__views":0}]
//
// Innoutprodductdeatils innoutprodductdeatilsFromJson(String str) => Innoutprodductdeatils.fromJson(json.decode(str));
// String innoutprodductdeatilsToJson(Innoutprodductdeatils data) => json.encode(data.toJson());
// class Innoutprodductdeatils {
//   Innoutprodductdeatils({
//       String? result,
//       String? message,
//       List<Data>? data,}){
//     _result = result;
//     _message = message;
//     _data = data;
// }
//
//   Innoutprodductdeatils.fromJson(dynamic json) {
//     _result = json['result'];
//     _message = json['message'];
//     if (json['data'] != null) {
//       _data = [];
//       json['data'].forEach((v) {
//         _data?.add(Data.fromJson(v));
//       });
//     }
//   }
//   String? _result;
//   String? _message;
//   List<Data>? _data;
// Innoutprodductdeatils copyWith({  String? result,
//   String? message,
//   List<Data>? data,
// }) => Innoutprodductdeatils(  result: result ?? _result,
//   message: message ?? _message,
//   data: data ?? _data,
// );
//   String? get result => _result;
//   String? get message => _message;
//   List<Data>? get data => _data;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['result'] = _result;
//     map['message'] = _message;
//     if (_data != null) {
//       map['data'] = _data?.map((v) => v.toJson()).toList();
//     }
//     return map;
//   }
//
// }
//
// /// productId : "65f44fbc5583e792f44530de"
// /// categoryId : "65f3e6fa1c20e8bb0a86c83e"
// /// venderId : "65f400381df960de87b7acbb"
// /// product_name : "pizza"
// /// description : "corn pizza"
// /// images : ["pizza-1239077_640.jpg","pizza-346985_640.jpg","pizza-2068272.jpg","pizza-5275191_640.jpg","pizza-329523_640.jpg"]
// /// product_code : "455"
// /// productType : "Kohinoor"
// /// productSize : "large"
// /// productPreparation_time : "25 Minutes"
// /// mrp_price : 299
// /// sale_price : 269.1
// /// discount : 10
// /// discountType : "Amount"
// /// product_details : "corn , garlic, cheese ,wheat "
// /// like_status : 0
// /// rating : 0
// /// total_rating : 0
// /// cart_status : 0
// /// qty : 0
// /// size : []
// /// color : []
// /// note : "direct to eat"
// /// returnType : []
// /// stock : []
// /// Tax : [{"tax_name":"Exclude","tax_value":18,"_id":"65f44fbc5583e792f44530e0"}]
// /// product_weight : "2 KG"
// /// deliveryType : "Yes"
// /// minimum_order : 5
// /// shop_logo : "IMG_20230707_114651284.jpg"
// /// shop_address : "indire"
// /// shop_country : "+91"
// /// shop_city : "Vijay Nagar, Indore, Madhya Pradesh, India"
// /// shop_name : "damru cafe"
// /// total_product : 2
// /// total_sale : 0
// /// total_rater : 0
// /// average_rating : 0
// /// delivery_fee : 0
// /// delivery__time : 0
// /// liked__time : 0
// /// page__views : 0
//
// Data dataFromJson(String str) => Data.fromJson(json.decode(str));
// String dataToJson(Data data) => json.encode(data.toJson());
// class Data {
//   Data({
//       String? productId,
//       String? categoryId,
//       String? venderId,
//       String? productName,
//       String? description,
//       List<String>? images,
//       String? productCode,
//       String? productType,
//       String? productSize,
//       String? productPreparationTime,
//       num? mrpPrice,
//       num? salePrice,
//       num? discount,
//       String? discountType,
//       String? productDetails,
//       num? likeStatus,
//       num? rating,
//       num? totalRating,
//       num? cartStatus,
//       num? qty,
//       List<dynamic>? size,
//       List<dynamic>? color,
//       String? note,
//       List<dynamic>? returnType,
//       List<dynamic>? stock,
//       List<Tax>? tax,
//       String? productWeight,
//       String? deliveryType,
//       num? minimumOrder,
//       String? shopLogo,
//       String? shopAddress,
//       String? shopCountry,
//       String? shopCity,
//       String? shopName,
//       num? totalProduct,
//       num? totalSale,
//       num? totalRater,
//       num? averageRating,
//       num? deliveryFee,
//       num? deliveryTime,
//       num? likedTime,
//       num? pageViews,}){
//     _productId = productId;
//     _categoryId = categoryId;
//     _venderId = venderId;
//     _productName = productName;
//     _description = description;
//     _images = images;
//     _productCode = productCode;
//     _productType = productType;
//     _productSize = productSize;
//     _productPreparationTime = productPreparationTime;
//     _mrpPrice = mrpPrice;
//     _salePrice = salePrice;
//     _discount = discount;
//     _discountType = discountType;
//     _productDetails = productDetails;
//     _likeStatus = likeStatus;
//     _rating = rating;
//     _totalRating = totalRating;
//     _cartStatus = cartStatus;
//     _qty = qty;
//     _size = size;
//     _color = color;
//     _note = note;
//     _returnType = returnType;
//     _stock = stock;
//     _tax = tax;
//     _productWeight = productWeight;
//     _deliveryType = deliveryType;
//     _minimumOrder = minimumOrder;
//     _shopLogo = shopLogo;
//     _shopAddress = shopAddress;
//     _shopCountry = shopCountry;
//     _shopCity = shopCity;
//     _shopName = shopName;
//     _totalProduct = totalProduct;
//     _totalSale = totalSale;
//     _totalRater = totalRater;
//     _averageRating = averageRating;
//     _deliveryFee = deliveryFee;
//     _deliveryTime = deliveryTime;
//     _likedTime = likedTime;
//     _pageViews = pageViews;
// }
//
//   Data.fromJson(dynamic json) {
//     _productId = json['productId'];
//     _categoryId = json['categoryId'];
//     _venderId = json['venderId'];
//     _productName = json['product_name'];
//     _description = json['description'];
//     _images = json['images'] != null ? json['images'].cast<String>() : [];
//     _productCode = json['product_code'];
//     _productType = json['productType'];
//     _productSize = json['productSize'];
//     _productPreparationTime = json['productPreparation_time'];
//     _mrpPrice = json['mrp_price'];
//     _salePrice = json['sale_price'];
//     _discount = json['discount'];
//     _discountType = json['discountType'];
//     _productDetails = json['product_details'];
//     _likeStatus = json['like_status'];
//     _rating = json['rating'];
//     _totalRating = json['total_rating'];
//     _cartStatus = json['cart_status'];
//     _qty = json['qty'];
//     if (json['size'] != null) {
//       _size = [];
//       json['size'].forEach((v) {
//         _size?.add(Dynamic.fromJson(v));
//       });
//     }
//     if (json['color'] != null) {
//       _color = [];
//       json['color'].forEach((v) {
//         _color?.add(Dynamic.fromJson(v));
//       });
//     }
//     _note = json['note'];
//     if (json['returnType'] != null) {
//       _returnType = [];
//       json['returnType'].forEach((v) {
//         _returnType?.add(Dynamic.fromJson(v));
//       });
//     }
//     if (json['stock'] != null) {
//       _stock = [];
//       json['stock'].forEach((v) {
//         _stock?.add(Dynamic.fromJson(v));
//       });
//     }
//     if (json['Tax'] != null) {
//       _tax = [];
//       json['Tax'].forEach((v) {
//         _tax?.add(Tax.fromJson(v));
//       });
//     }
//     _productWeight = json['product_weight'];
//     _deliveryType = json['deliveryType'];
//     _minimumOrder = json['minimum_order'];
//     _shopLogo = json['shop_logo'];
//     _shopAddress = json['shop_address'];
//     _shopCountry = json['shop_country'];
//     _shopCity = json['shop_city'];
//     _shopName = json['shop_name'];
//     _totalProduct = json['total_product'];
//     _totalSale = json['total_sale'];
//     _totalRater = json['total_rater'];
//     _averageRating = json['average_rating'];
//     _deliveryFee = json['delivery_fee'];
//     _deliveryTime = json['delivery__time'];
//     _likedTime = json['liked__time'];
//     _pageViews = json['page__views'];
//   }
//   String? _productId;
//   String? _categoryId;
//   String? _venderId;
//   String? _productName;
//   String? _description;
//   List<String>? _images;
//   String? _productCode;
//   String? _productType;
//   String? _productSize;
//   String? _productPreparationTime;
//   num? _mrpPrice;
//   num? _salePrice;
//   num? _discount;
//   String? _discountType;
//   String? _productDetails;
//   num? _likeStatus;
//   num? _rating;
//   num? _totalRating;
//   num? _cartStatus;
//   num? _qty;
//   List<dynamic>? _size;
//   List<dynamic>? _color;
//   String? _note;
//   List<dynamic>? _returnType;
//   List<dynamic>? _stock;
//   List<Tax>? _tax;
//   String? _productWeight;
//   String? _deliveryType;
//   num? _minimumOrder;
//   String? _shopLogo;
//   String? _shopAddress;
//   String? _shopCountry;
//   String? _shopCity;
//   String? _shopName;
//   num? _totalProduct;
//   num? _totalSale;
//   num? _totalRater;
//   num? _averageRating;
//   num? _deliveryFee;
//   num? _deliveryTime;
//   num? _likedTime;
//   num? _pageViews;
// Data copyWith({  String? productId,
//   String? categoryId,
//   String? venderId,
//   String? productName,
//   String? description,
//   List<String>? images,
//   String? productCode,
//   String? productType,
//   String? productSize,
//   String? productPreparationTime,
//   num? mrpPrice,
//   num? salePrice,
//   num? discount,
//   String? discountType,
//   String? productDetails,
//   num? likeStatus,
//   num? rating,
//   num? totalRating,
//   num? cartStatus,
//   num? qty,
//   List<dynamic>? size,
//   List<dynamic>? color,
//   String? note,
//   List<dynamic>? returnType,
//   List<dynamic>? stock,
//   List<Tax>? tax,
//   String? productWeight,
//   String? deliveryType,
//   num? minimumOrder,
//   String? shopLogo,
//   String? shopAddress,
//   String? shopCountry,
//   String? shopCity,
//   String? shopName,
//   num? totalProduct,
//   num? totalSale,
//   num? totalRater,
//   num? averageRating,
//   num? deliveryFee,
//   num? deliveryTime,
//   num? likedTime,
//   num? pageViews,
// }) => Data(  productId: productId ?? _productId,
//   categoryId: categoryId ?? _categoryId,
//   venderId: venderId ?? _venderId,
//   productName: productName ?? _productName,
//   description: description ?? _description,
//   images: images ?? _images,
//   productCode: productCode ?? _productCode,
//   productType: productType ?? _productType,
//   productSize: productSize ?? _productSize,
//   productPreparationTime: productPreparationTime ?? _productPreparationTime,
//   mrpPrice: mrpPrice ?? _mrpPrice,
//   salePrice: salePrice ?? _salePrice,
//   discount: discount ?? _discount,
//   discountType: discountType ?? _discountType,
//   productDetails: productDetails ?? _productDetails,
//   likeStatus: likeStatus ?? _likeStatus,
//   rating: rating ?? _rating,
//   totalRating: totalRating ?? _totalRating,
//   cartStatus: cartStatus ?? _cartStatus,
//   qty: qty ?? _qty,
//   size: size ?? _size,
//   color: color ?? _color,
//   note: note ?? _note,
//   returnType: returnType ?? _returnType,
//   stock: stock ?? _stock,
//   tax: tax ?? _tax,
//   productWeight: productWeight ?? _productWeight,
//   deliveryType: deliveryType ?? _deliveryType,
//   minimumOrder: minimumOrder ?? _minimumOrder,
//   shopLogo: shopLogo ?? _shopLogo,
//   shopAddress: shopAddress ?? _shopAddress,
//   shopCountry: shopCountry ?? _shopCountry,
//   shopCity: shopCity ?? _shopCity,
//   shopName: shopName ?? _shopName,
//   totalProduct: totalProduct ?? _totalProduct,
//   totalSale: totalSale ?? _totalSale,
//   totalRater: totalRater ?? _totalRater,
//   averageRating: averageRating ?? _averageRating,
//   deliveryFee: deliveryFee ?? _deliveryFee,
//   deliveryTime: deliveryTime ?? _deliveryTime,
//   likedTime: likedTime ?? _likedTime,
//   pageViews: pageViews ?? _pageViews,
// );
//   String? get productId => _productId;
//   String? get categoryId => _categoryId;
//   String? get venderId => _venderId;
//   String? get productName => _productName;
//   String? get description => _description;
//   List<String>? get images => _images;
//   String? get productCode => _productCode;
//   String? get productType => _productType;
//   String? get productSize => _productSize;
//   String? get productPreparationTime => _productPreparationTime;
//   num? get mrpPrice => _mrpPrice;
//   num? get salePrice => _salePrice;
//   num? get discount => _discount;
//   String? get discountType => _discountType;
//   String? get productDetails => _productDetails;
//   num? get likeStatus => _likeStatus;
//   num? get rating => _rating;
//   num? get totalRating => _totalRating;
//   num? get cartStatus => _cartStatus;
//   num? get qty => _qty;
//   List<dynamic>? get size => _size;
//   List<dynamic>? get color => _color;
//   String? get note => _note;
//   List<dynamic>? get returnType => _returnType;
//   List<dynamic>? get stock => _stock;
//   List<Tax>? get tax => _tax;
//   String? get productWeight => _productWeight;
//   String? get deliveryType => _deliveryType;
//   num? get minimumOrder => _minimumOrder;
//   String? get shopLogo => _shopLogo;
//   String? get shopAddress => _shopAddress;
//   String? get shopCountry => _shopCountry;
//   String? get shopCity => _shopCity;
//   String? get shopName => _shopName;
//   num? get totalProduct => _totalProduct;
//   num? get totalSale => _totalSale;
//   num? get totalRater => _totalRater;
//   num? get averageRating => _averageRating;
//   num? get deliveryFee => _deliveryFee;
//   num? get deliveryTime => _deliveryTime;
//   num? get likedTime => _likedTime;
//   num? get pageViews => _pageViews;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['productId'] = _productId;
//     map['categoryId'] = _categoryId;
//     map['venderId'] = _venderId;
//     map['product_name'] = _productName;
//     map['description'] = _description;
//     map['images'] = _images;
//     map['product_code'] = _productCode;
//     map['productType'] = _productType;
//     map['productSize'] = _productSize;
//     map['productPreparation_time'] = _productPreparationTime;
//     map['mrp_price'] = _mrpPrice;
//     map['sale_price'] = _salePrice;
//     map['discount'] = _discount;
//     map['discountType'] = _discountType;
//     map['product_details'] = _productDetails;
//     map['like_status'] = _likeStatus;
//     map['rating'] = _rating;
//     map['total_rating'] = _totalRating;
//     map['cart_status'] = _cartStatus;
//     map['qty'] = _qty;
//     if (_size != null) {
//       map['size'] = _size?.map((v) => v.toJson()).toList();
//     }
//     if (_color != null) {
//       map['color'] = _color?.map((v) => v.toJson()).toList();
//     }
//     map['note'] = _note;
//     if (_returnType != null) {
//       map['returnType'] = _returnType?.map((v) => v.toJson()).toList();
//     }
//     if (_stock != null) {
//       map['stock'] = _stock?.map((v) => v.toJson()).toList();
//     }
//     if (_tax != null) {
//       map['Tax'] = _tax?.map((v) => v.toJson()).toList();
//     }
//     map['product_weight'] = _productWeight;
//     map['deliveryType'] = _deliveryType;
//     map['minimum_order'] = _minimumOrder;
//     map['shop_logo'] = _shopLogo;
//     map['shop_address'] = _shopAddress;
//     map['shop_country'] = _shopCountry;
//     map['shop_city'] = _shopCity;
//     map['shop_name'] = _shopName;
//     map['total_product'] = _totalProduct;
//     map['total_sale'] = _totalSale;
//     map['total_rater'] = _totalRater;
//     map['average_rating'] = _averageRating;
//     map['delivery_fee'] = _deliveryFee;
//     map['delivery__time'] = _deliveryTime;
//     map['liked__time'] = _likedTime;
//     map['page__views'] = _pageViews;
//     return map;
//   }
//
// }
//
// /// tax_name : "Exclude"
// /// tax_value : 18
// /// _id : "65f44fbc5583e792f44530e0"
//
// Tax taxFromJson(String str) => Tax.fromJson(json.decode(str));
// String taxToJson(Tax data) => json.encode(data.toJson());
// class Tax {
//   Tax({
//       String? taxName,
//       num? taxValue,
//       String? id,}){
//     _taxName = taxName;
//     _taxValue = taxValue;
//     _id = id;
// }
//
//   Tax.fromJson(dynamic json) {
//     _taxName = json['tax_name'];
//     _taxValue = json['tax_value'];
//     _id = json['_id'];
//   }
//   String? _taxName;
//   num? _taxValue;
//   String? _id;
// Tax copyWith({  String? taxName,
//   num? taxValue,
//   String? id,
// }) => Tax(  taxName: taxName ?? _taxName,
//   taxValue: taxValue ?? _taxValue,
//   id: id ?? _id,
// );
//   String? get taxName => _taxName;
//   num? get taxValue => _taxValue;
//   String? get id => _id;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['tax_name'] = _taxName;
//     map['tax_value'] = _taxValue;
//     map['_id'] = _id;
//     return map;
//   }
//
// }