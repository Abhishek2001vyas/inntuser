class orderDetails {
  String? result;
  String? message;
  Data? data;

  orderDetails({this.result, this.message, this.data});

  orderDetails.fromJson(Map<String, dynamic> json) {
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
  String? sId;
  int? orderStatus;
  int? status;
  String? deliveryPlace;
  String? payType;
  int? orderId;
  String? qrcode;
  double? grandTotal;
  String? createdAt;
  String? updatedAt;
  String? userId;
  String? firstName;
  String? lastName;
  String? mobileNumber;
  String? userProfile;
  String? checkoutId;
  List<Products>? products;
  int? totalItem;
  double? totalPrice;
  int? saveAmount;
  int? addressId;
  int? placeType;
  int? state;
  int? cityName;
  int? pinCode;
  int? buildingNo;
  int? landmark;
  int? villageName;

  Data(
      {this.sId,
        this.orderStatus,
        this.status,
        this.deliveryPlace,
        this.payType,
        this.orderId,
        this.qrcode,
        this.grandTotal,
        this.createdAt,
        this.updatedAt,
        this.userId,
        this.firstName,
        this.lastName,
        this.mobileNumber,
        this.userProfile,
        this.checkoutId,
        this.products,
        this.totalItem,
        this.totalPrice,
        this.saveAmount,
        this.addressId,
        this.placeType,
        this.state,
        this.cityName,
        this.pinCode,
        this.buildingNo,
        this.landmark,
        this.villageName});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    orderStatus = json['order_status'];
    status = json['status'];
    deliveryPlace = json['delivery_place'];
    payType = json['payType'];
    orderId = json['orderId'];
    qrcode = json['qrcode'];
    grandTotal = json['grand_total'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    userId = json['userId'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    mobileNumber = json['mobile_number'];
    userProfile = json['user_profile'];
    checkoutId = json['checkoutId'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
    totalItem = json['total_item'];
    totalPrice = json['total_price'];
    saveAmount = json['save_amount'];
    addressId = json['addressId'];
    placeType = json['place_type'];
    state = json['state'];
    cityName = json['city_name'];
    pinCode = json['pin_code'];
    buildingNo = json['building_no'];
    landmark = json['landmark'];
    villageName = json['village_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['order_status'] = orderStatus;
    data['status'] = status;
    data['delivery_place'] = deliveryPlace;
    data['payType'] = payType;
    data['orderId'] = orderId;
    data['qrcode'] = qrcode;
    data['grand_total'] = grandTotal;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['userId'] = userId;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['mobile_number'] = mobileNumber;
    data['user_profile'] = userProfile;
    data['checkoutId'] = checkoutId;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    data['total_item'] = totalItem;
    data['total_price'] = totalPrice;
    data['save_amount'] = saveAmount;
    data['addressId'] = addressId;
    data['place_type'] = placeType;
    data['state'] = state;
    data['city_name'] = cityName;
    data['pin_code'] = pinCode;
    data['building_no'] = buildingNo;
    data['landmark'] = landmark;
    data['village_name'] = villageName;
    return data;
  }
}

class Products {
  String? productId;
  String? productName;
  String? shopName;
  String? size;
  String? color;
  int? qty;
  double? salePrice;
  int? unitPrice;
  List<Discount>? discount;
  String? image;
  String? shopId;
  List<WorkHours>? workHours;
  String? shopAddress;
  String? country;
  String? city;

  Products(
      {this.productId,
        this.productName,
        this.shopName,
        this.size,
        this.color,
        this.qty,
        this.salePrice,
        this.unitPrice,
        this.discount,
        this.image,
        this.shopId,
        this.workHours,
        this.shopAddress,
        this.country,
        this.city});

  Products.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    productName = json['product_name'];
    shopName = json['shop_name'];
    size = json['size'];
    color = json['color'];
    qty = json['qty'];
    salePrice = json['sale_price'];
    unitPrice = json['unit_price'];
    if (json['discount'] != null) {
      discount = <Discount>[];
      json['discount'].forEach((v) {
        discount!.add(Discount.fromJson(v));
      });
    }
    image = json['image'];
    shopId = json['shopId'];
    if (json['workHours'] != null) {
      workHours = <WorkHours>[];
      json['workHours'].forEach((v) {
        workHours!.add(WorkHours.fromJson(v));
      });
    }
    shopAddress = json['shop_address'];
    country = json['country'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productId'] = productId;
    data['product_name'] = productName;
    data['shop_name'] = shopName;
    data['size'] = size;
    data['color'] = color;
    data['qty'] = qty;
    data['sale_price'] = salePrice;
    data['unit_price'] = unitPrice;
    if (discount != null) {
      data['discount'] = discount!.map((v) => v.toJson()).toList();
    }
    data['image'] = image;
    data['shopId'] = shopId;
    if (workHours != null) {
      data['workHours'] = workHours!.map((v) => v.toJson()).toList();
    }
    data['shop_address'] = shopAddress;
    data['country'] = country;
    data['city'] = city;
    return data;
  }
}

class Discount {
  String? discountType;
  int? discountValue;
  String? sId;

  Discount({this.discountType, this.discountValue, this.sId});

  Discount.fromJson(Map<String, dynamic> json) {
    discountType = json['discount_type'];
    discountValue = json['discount_value'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['discount_type'] = discountType;
    data['discount_value'] = discountValue;
    data['_id'] = sId;
    return data;
  }
}

class WorkHours {
  String? dayName;
  bool? status;
  String? openTime;
  String? closeTime;
  String? sId;

  WorkHours(
      {this.dayName, this.status, this.openTime, this.closeTime, this.sId});

  WorkHours.fromJson(Map<String, dynamic> json) {
    dayName = json['day_name'];
    status = json['status'];
    openTime = json['open_time'];
    closeTime = json['close_time'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['day_name'] = dayName;
    data['status'] = status;
    data['open_time'] = openTime;
    data['close_time'] = closeTime;
    data['_id'] = sId;
    return data;
  }
}
