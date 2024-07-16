import 'dart:convert';
/// result : "true"
/// message : "Order list get suOrderListessfully"
/// data : [{"_id":"660a6b4d74bc1e04f8ea2a30","userId":"65d6fecd3e4d071b479ea66d","checkoutId":"660a5c46e8676ce679524b29","shopId":"65eaf16c9c99c649416b1f62","orderId":60440926,"products":[{"productId":"65f170a9aba2a8e214b554d4","size":"XXl","image":"shirts1.jpg","product_name":"crew neck soft fitted Tees","shop_name":"sachin general store","color":"Blue","qty":1,"subtotal":678.03,"discount":3,"tax":3,"shipping_charge":0,"total":678.03,"checkout_status":0,"qrcode":"ziokPqZn","_id":"660a6b4d74bc1e04f8ea2a31"}],"order_status":0,"status":0,"__v":0,"createdAt":"2024-04-01T08:07:41.015Z","updatedAt":"2024-04-01T08:07:41.015Z"},{"_id":"660a6d8274bc1e04f8ef5eb3","userId":"65d6fecd3e4d071b479ea66d","checkoutId":"660a6d7d74bc1e04f8ef5211","shopId":"65eaf16c9c99c649416b1f62","orderId":39720779,"products":[{"productId":"65f170a9aba2a8e214b554d4","size":"","image":"shirts1.jpg","product_name":"crew neck soft fitted Tees","shop_name":"sachin general store","color":"","qty":1,"subtotal":678.03,"discount":3,"tax":3,"shipping_charge":0,"total":678.03,"checkout_status":0,"qrcode":"1H9qD4kj","_id":"660a6d8274bc1e04f8ef5eb4"}],"order_status":0,"status":0,"__v":0,"createdAt":"2024-04-01T08:17:06.431Z","updatedAt":"2024-04-01T08:17:06.431Z"},{"_id":"660a6d8274bc1e04f8ef5eb5","userId":"65d6fecd3e4d071b479ea66d","checkoutId":"660a6d7d74bc1e04f8ef5211","shopId":"65f0232ff91f54c9cd41cab6","orderId":33155856,"products":[{"productId":"65f19b8b69e61627081deea8","size":"L","image":"61F-BRmlyrL._SY535_.jpg","product_name":"SPARX Mens Running Shoes","shop_name":"Reatil","color":"Blue","qty":1,"subtotal":538.3,"discount":30,"tax":41,"shipping_charge":0,"total":538.3,"checkout_status":0,"qrcode":"LOm0w896","_id":"660a6d8274bc1e04f8ef5eb6"}],"order_status":0,"status":0,"__v":0,"createdAt":"2024-04-01T08:17:06.432Z","updatedAt":"2024-04-01T08:17:06.432Z"},{"_id":"660a6dd174bc1e04f8f034ae","userId":"65d6fecd3e4d071b479ea66d","checkoutId":"660a6dcf74bc1e04f8f02e5a","shopId":"65eaf16c9c99c649416b1f62","orderId":57887960,"products":[{"productId":"65f157bae3f45f7f69acf44d","size":"XXl","image":"jeans1.jpg","product_name":"comfort flex waist jean","shop_name":"sachin general store","color":"Blue","qty":1,"subtotal":759.05,"discount":5,"tax":2,"shipping_charge":0,"total":759.05,"checkout_status":0,"qrcode":"yA49ZM8U","_id":"660a6dd174bc1e04f8f034af"},{"productId":"65f1b45e69e61627081e08e0","size":"Small","image":"-78Wx98H-443005820-navy-MODEL.jpg","product_name":"Checked Shirt with patch pocket","shop_name":"sachin general store","color":"Navy","qty":1,"subtotal":1994,"discount":5,"tax":2,"shipping_charge":0,"total":1994,"checkout_status":0,"qrcode":"3pwh9IoP","_id":"660a6dd174bc1e04f8f034b0"}],"order_status":0,"status":0,"__v":0,"createdAt":"2024-04-01T08:18:25.679Z","updatedAt":"2024-04-01T08:18:25.679Z"}]

OrderList OrderListFromJson(String str) => OrderList.fromJson(json.decode(str));
String OrderListToJson(OrderList data) => json.encode(data.toJson());
class OrderList {
  OrderList({
    String? result,
    String? message,
    List<Data>? data,}){
    _result = result;
    _message = message;
    _data = data;
  }

  OrderList.fromJson(dynamic json) {
    _result = json['result'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  String? _result;
  String? _message;
  List<Data>? _data;
  OrderList copyWith({  String? result,
    String? message,
    List<Data>? data,
  }) => OrderList(  result: result ?? _result,
    message: message ?? _message,
    data: data ?? _data,
  );
  String? get result => _result;
  String? get message => _message;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['result'] = _result;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// _id : "660a6b4d74bc1e04f8ea2a30"
/// userId : "65d6fecd3e4d071b479ea66d"
/// checkoutId : "660a5c46e8676ce679524b29"
/// shopId : "65eaf16c9c99c649416b1f62"
/// orderId : 60440926
/// products : [{"productId":"65f170a9aba2a8e214b554d4","size":"XXl","image":"shirts1.jpg","product_name":"crew neck soft fitted Tees","shop_name":"sachin general store","color":"Blue","qty":1,"subtotal":678.03,"discount":3,"tax":3,"shipping_charge":0,"total":678.03,"checkout_status":0,"qrcode":"ziokPqZn","_id":"660a6b4d74bc1e04f8ea2a31"}]
/// order_status : 0
/// status : 0
/// __v : 0
/// createdAt : "2024-04-01T08:07:41.015Z"
/// updatedAt : "2024-04-01T08:07:41.015Z"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
    String? id,
    String? userId,
    String? checkoutId,
    String? shopId,
    num? orderId,
    List<Products>? products,
    num? orderStatus,
    num? status,
    num? v,
    String? createdAt,
    String? updatedAt,}){
    _id = id;
    _userId = userId;
    _checkoutId = checkoutId;
    _shopId = shopId;
    _orderId = orderId;
    _products = products;
    _orderStatus = orderStatus;
    _status = status;
    _v = v;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Data.fromJson(dynamic json) {
    _id = json['_id'];
    _userId = json['userId'];
    _checkoutId = json['checkoutId'];
    _shopId = json['shopId'];
    _orderId = json['orderId'];
    if (json['products'] != null) {
      _products = [];
      json['products'].forEach((v) {
        _products?.add(Products.fromJson(v));
      });
    }
    _orderStatus = json['order_status'];
    _status = json['status'];
    _v = json['__v'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  String? _id;
  String? _userId;
  String? _checkoutId;
  String? _shopId;
  num? _orderId;
  List<Products>? _products;
  num? _orderStatus;
  num? _status;
  num? _v;
  String? _createdAt;
  String? _updatedAt;
  Data copyWith({  String? id,
    String? userId,
    String? checkoutId,
    String? shopId,
    num? orderId,
    List<Products>? products,
    num? orderStatus,
    num? status,
    num? v,
    String? createdAt,
    String? updatedAt,
  }) => Data(  id: id ?? _id,
    userId: userId ?? _userId,
    checkoutId: checkoutId ?? _checkoutId,
    shopId: shopId ?? _shopId,
    orderId: orderId ?? _orderId,
    products: products ?? _products,
    orderStatus: orderStatus ?? _orderStatus,
    status: status ?? _status,
    v: v ?? _v,
    createdAt: createdAt ?? _createdAt,
    updatedAt: updatedAt ?? _updatedAt,
  );
  String? get id => _id;
  String? get userId => _userId;
  String? get checkoutId => _checkoutId;
  String? get shopId => _shopId;
  num? get orderId => _orderId;
  List<Products>? get products => _products;
  num? get orderStatus => _orderStatus;
  num? get status => _status;
  num? get v => _v;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['userId'] = _userId;
    map['checkoutId'] = _checkoutId;
    map['shopId'] = _shopId;
    map['orderId'] = _orderId;
    if (_products != null) {
      map['products'] = _products?.map((v) => v.toJson()).toList();
    }
    map['order_status'] = _orderStatus;
    map['status'] = _status;
    map['__v'] = _v;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }

}

/// productId : "65f170a9aba2a8e214b554d4"
/// size : "XXl"
/// image : "shirts1.jpg"
/// product_name : "crew neck soft fitted Tees"
/// shop_name : "sachin general store"
/// color : "Blue"
/// qty : 1
/// subtotal : 678.03
/// discount : 3
/// tax : 3
/// shipping_charge : 0
/// total : 678.03
/// checkout_status : 0
/// qrcode : "ziokPqZn"
/// _id : "660a6b4d74bc1e04f8ea2a31"

Products productsFromJson(String str) => Products.fromJson(json.decode(str));
String productsToJson(Products data) => json.encode(data.toJson());
class Products {
  Products({
    String? productId,
    String? size,
    String? image,
    String? productName,
    String? shopName,
    String? color,
    num? qty,
    num? subtotal,
    num? discount,
    num? tax,
    num? shippingCharge,
    num? total,
    num? checkoutStatus,
    String? qrcode,
    String? id,}){
    _productId = productId;
    _size = size;
    _image = image;
    _productName = productName;
    _shopName = shopName;
    _color = color;
    _qty = qty;
    _subtotal = subtotal;
    _discount = discount;
    _tax = tax;
    _shippingCharge = shippingCharge;
    _total = total;
    _checkoutStatus = checkoutStatus;
    _qrcode = qrcode;
    _id = id;
  }

  Products.fromJson(dynamic json) {
    _productId = json['productId'];
    _size = json['size'];
    _image = json['image'];
    _productName = json['product_name'];
    _shopName = json['shop_name'];
    _color = json['color'];
    _qty = json['qty'];
    _subtotal = json['subtotal'];
    _discount = json['discount'];
    _tax = json['tax'];
    _shippingCharge = json['shipping_charge'];
    _total = json['total'];
    _checkoutStatus = json['checkout_status'];
    _qrcode = json['qrcode'];
    _id = json['_id'];
  }
  String? _productId;
  String? _size;
  String? _image;
  String? _productName;
  String? _shopName;
  String? _color;
  num? _qty;
  num? _subtotal;
  num? _discount;
  num? _tax;
  num? _shippingCharge;
  num? _total;
  num? _checkoutStatus;
  String? _qrcode;
  String? _id;
  Products copyWith({  String? productId,
    String? size,
    String? image,
    String? productName,
    String? shopName,
    String? color,
    num? qty,
    num? subtotal,
    num? discount,
    num? tax,
    num? shippingCharge,
    num? total,
    num? checkoutStatus,
    String? qrcode,
    String? id,
  }) => Products(  productId: productId ?? _productId,
    size: size ?? _size,
    image: image ?? _image,
    productName: productName ?? _productName,
    shopName: shopName ?? _shopName,
    color: color ?? _color,
    qty: qty ?? _qty,
    subtotal: subtotal ?? _subtotal,
    discount: discount ?? _discount,
    tax: tax ?? _tax,
    shippingCharge: shippingCharge ?? _shippingCharge,
    total: total ?? _total,
    checkoutStatus: checkoutStatus ?? _checkoutStatus,
    qrcode: qrcode ?? _qrcode,
    id: id ?? _id,
  );
  String? get productId => _productId;
  String? get size => _size;
  String? get image => _image;
  String? get productName => _productName;
  String? get shopName => _shopName;
  String? get color => _color;
  num? get qty => _qty;
  num? get subtotal => _subtotal;
  num? get discount => _discount;
  num? get tax => _tax;
  num? get shippingCharge => _shippingCharge;
  num? get total => _total;
  num? get checkoutStatus => _checkoutStatus;
  String? get qrcode => _qrcode;
  String? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['productId'] = _productId;
    map['size'] = _size;
    map['image'] = _image;
    map['product_name'] = _productName;
    map['shop_name'] = _shopName;
    map['color'] = _color;
    map['qty'] = _qty;
    map['subtotal'] = _subtotal;
    map['discount'] = _discount;
    map['tax'] = _tax;
    map['shipping_charge'] = _shippingCharge;
    map['total'] = _total;
    map['checkout_status'] = _checkoutStatus;
    map['qrcode'] = _qrcode;
    map['_id'] = _id;
    return map;
  }

}