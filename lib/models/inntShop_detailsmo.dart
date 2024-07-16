class inntShop_details {
  String? result;
  String? message;
  Data? data;

  inntShop_details({this.result, this.message, this.data});

  inntShop_details.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result'] = result;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  ShopData? shopData;
  int? productsCount;
  int? likeCount;
  int? ratersCount;
  int? averageRatings;
  int? viewCount;
  int? salesCount;
  List<Productlist>? productlist;

  Data(
      {this.shopData,
        this.productsCount,
        this.likeCount,
        this.ratersCount,
        this.averageRatings,
        this.viewCount,
        this.salesCount,
        this.productlist});

  Data.fromJson(Map<String, dynamic> json) {
    shopData = json['shop_data'] != null
        ? ShopData.fromJson(json['shop_data'])
        : null;
    productsCount = json['products_count'];
    likeCount = json['like_count'];
    ratersCount = json['raters_count'];
    averageRatings = json['average_ratings'];
    viewCount = json['view_count'];
    salesCount = json['sales_count'];
    if (json['productlist'] != null) {
      productlist = <Productlist>[];
      json['productlist'].forEach((v) {
        productlist!.add(Productlist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (shopData != null) {
      data['shop_data'] = shopData!.toJson();
    }
    data['products_count'] = productsCount;
    data['like_count'] = likeCount;
    data['raters_count'] = ratersCount;
    data['average_ratings'] = averageRatings;
    data['view_count'] = viewCount;
    data['sales_count'] = salesCount;
    if (productlist != null) {
      data['productlist'] = productlist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ShopData {
  String? shopId;
  String? firstName;
  String? lastName;
  String? residenceyCity;
  String? mobileNumber;
  String? uploadFrontId;
  String? uploadBacksideId;
  String? shopName;
  String? shopAddress;
  String? country;
  String? city;

  ShopData(
      {this.shopId,
        this.firstName,
        this.lastName,
        this.residenceyCity,
        this.mobileNumber,
        this.uploadFrontId,
        this.uploadBacksideId,
        this.shopName,
        this.shopAddress,
        this.country,
        this.city});

  ShopData.fromJson(Map<String, dynamic> json) {
    shopId = json['shopId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    residenceyCity = json['residenceyCity'];
    mobileNumber = json['mobile_number'];
    uploadFrontId = json['upload_frontId'];
    uploadBacksideId = json['upload_backsideId'];
    shopName = json['shop_name'];
    shopAddress = json['shop_address'];
    country = json['country'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['shopId'] = shopId;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['residenceyCity'] = residenceyCity;
    data['mobile_number'] = mobileNumber;
    data['upload_frontId'] = uploadFrontId;
    data['upload_backsideId'] = uploadBacksideId;
    data['shop_name'] = shopName;
    data['shop_address'] = shopAddress;
    data['country'] = country;
    data['city'] = city;
    return data;
  }
}

class Productlist {
  String? productId;
  String? venderId;
  String? categoryId;
  String? subSubcategoryId;
  String? subcategoryId;
  String? productName;
  String? description;
  String? image1;
  String? productCode;
  int? unitPrice;
  double? salePrice;
  int? discount;
  String? discountName;
  List<String>? size;

  Productlist(
      {this.productId,
        this.venderId,
        this.categoryId,
        this.subSubcategoryId,
        this.subcategoryId,
        this.productName,
        this.description,
        this.image1,
        this.productCode,
        this.unitPrice,
        this.salePrice,
        this.discount,
        this.discountName,
        this.size});

  Productlist.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    venderId = json['venderId'];
    categoryId = json['categoryId'];
    subSubcategoryId = json['sub_subcategoryId'];
    subcategoryId = json['subcategoryId'];
    productName = json['product_name'];
    description = json['description'];
    image1 = json['image1'];
    productCode = json['product_code'];
    unitPrice = json['unit_price'];
    salePrice = json['sale_price'];
    discount = json['discount'];
    discountName = json['discount_name'];
    size = json['size'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productId'] = productId;
    data['venderId'] = venderId;
    data['categoryId'] = categoryId;
    data['sub_subcategoryId'] = subSubcategoryId;
    data['subcategoryId'] = subcategoryId;
    data['product_name'] = productName;
    data['description'] = description;
    data['image1'] = image1;
    data['product_code'] = productCode;
    data['unit_price'] = unitPrice;
    data['sale_price'] = salePrice;
    data['discount'] = discount;
    data['discount_name'] = discountName;
    data['size'] = size;
    return data;
  }
}
