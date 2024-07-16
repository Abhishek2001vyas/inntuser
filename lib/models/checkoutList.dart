import 'dart:convert';
/// result : "true"
/// message : "Checkout list get successfully"
/// data : {"_id":"6602aa07f3fc69589d1aa174","userId":"65d6fecd3e4d071b479ea66d","products":[{"productId":"65f170a9aba2a8e214b554d4","shopId":"65eaf16c9c99c649416b1f62","size":"XXl","image":"shirts1.jpg","product_name":"crew neck soft fitted Tees","shop_name":"sachin general store","color":"Blue","qty":1,"_id":"6602c9f9a9ad204797b5aef0"},{"productId":"65f19b8b69e61627081deea8","shopId":"65f0232ff91f54c9cd41cab6","size":"L","image":"61F-BRmlyrL._SY535_.jpg","product_name":"SPARX Mens Running Shoes","shop_name":"Reatil","color":"Blue","qty":1,"_id":"6602c9f9a9ad204797b5aef1"}],"check_status":0,"status":0,"total_item":2,"total_price":1216.33,"save_amount":0,"createdAt":"2024-03-26T10:57:11.952Z","updatedAt":"2024-03-26T13:13:29.251Z","__v":0}

CheckoutList checkoutListFromJson(String str) => CheckoutList.fromJson(json.decode(str));
String checkoutListToJson(CheckoutList data) => json.encode(data.toJson());
class CheckoutList {
  CheckoutList({
      String? result, 
      String? message, 
      Data? data,}){
    _result = result;
    _message = message;
    _data = data;
}

  CheckoutList.fromJson(dynamic json) {
    _result = json['result'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? _result;
  String? _message;
  Data? _data;
CheckoutList copyWith({  String? result,
  String? message,
  Data? data,
}) => CheckoutList(  result: result ?? _result,
  message: message ?? _message,
  data: data ?? _data,
);
  String? get result => _result;
  String? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['result'] = _result;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// _id : "6602aa07f3fc69589d1aa174"
/// userId : "65d6fecd3e4d071b479ea66d"
/// products : [{"productId":"65f170a9aba2a8e214b554d4","shopId":"65eaf16c9c99c649416b1f62","size":"XXl","image":"shirts1.jpg","product_name":"crew neck soft fitted Tees","shop_name":"sachin general store","color":"Blue","qty":1,"_id":"6602c9f9a9ad204797b5aef0"},{"productId":"65f19b8b69e61627081deea8","shopId":"65f0232ff91f54c9cd41cab6","size":"L","image":"61F-BRmlyrL._SY535_.jpg","product_name":"SPARX Mens Running Shoes","shop_name":"Reatil","color":"Blue","qty":1,"_id":"6602c9f9a9ad204797b5aef1"}]
/// check_status : 0
/// status : 0
/// total_item : 2
/// total_price : 1216.33
/// save_amount : 0
/// createdAt : "2024-03-26T10:57:11.952Z"
/// updatedAt : "2024-03-26T13:13:29.251Z"
/// __v : 0

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? id, 
      String? userId, 
      List<Products>? products, 
      num? checkStatus, 
      num? status, 
      num? totalItem, 
      num? totalPrice, 
      num? saveAmount, 
      String? createdAt, 
      String? updatedAt, 
      num? v,}){
    _id = id;
    _userId = userId;
    _products = products;
    _checkStatus = checkStatus;
    _status = status;
    _totalItem = totalItem;
    _totalPrice = totalPrice;
    _saveAmount = saveAmount;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
}

  Data.fromJson(dynamic json) {
    _id = json['_id'];
    _userId = json['userId'];
    if (json['products'] != null) {
      _products = [];
      json['products'].forEach((v) {
        _products?.add(Products.fromJson(v));
      });
    }
    _checkStatus = json['check_status'];
    _status = json['status'];
    _totalItem = json['total_item'];
    _totalPrice = json['total_price'];
    _saveAmount = json['save_amount'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _v = json['__v'];
  }
  String? _id;
  String? _userId;
  List<Products>? _products;
  num? _checkStatus;
  num? _status;
  num? _totalItem;
  num? _totalPrice;
  num? _saveAmount;
  String? _createdAt;
  String? _updatedAt;
  num? _v;
Data copyWith({  String? id,
  String? userId,
  List<Products>? products,
  num? checkStatus,
  num? status,
  num? totalItem,
  num? totalPrice,
  num? saveAmount,
  String? createdAt,
  String? updatedAt,
  num? v,
}) => Data(  id: id ?? _id,
  userId: userId ?? _userId,
  products: products ?? _products,
  checkStatus: checkStatus ?? _checkStatus,
  status: status ?? _status,
  totalItem: totalItem ?? _totalItem,
  totalPrice: totalPrice ?? _totalPrice,
  saveAmount: saveAmount ?? _saveAmount,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  v: v ?? _v,
);
  String? get id => _id;
  String? get userId => _userId;
  List<Products>? get products => _products;
  num? get checkStatus => _checkStatus;
  num? get status => _status;
  num? get totalItem => _totalItem;
  num? get totalPrice => _totalPrice;
  num? get saveAmount => _saveAmount;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  num? get v => _v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['userId'] = _userId;
    if (_products != null) {
      map['products'] = _products?.map((v) => v.toJson()).toList();
    }
    map['check_status'] = _checkStatus;
    map['status'] = _status;
    map['total_item'] = _totalItem;
    map['total_price'] = _totalPrice;
    map['save_amount'] = _saveAmount;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['__v'] = _v;
    return map;
  }

}

/// productId : "65f170a9aba2a8e214b554d4"
/// shopId : "65eaf16c9c99c649416b1f62"
/// size : "XXl"
/// image : "shirts1.jpg"
/// product_name : "crew neck soft fitted Tees"
/// shop_name : "sachin general store"
/// color : "Blue"
/// qty : 1
/// _id : "6602c9f9a9ad204797b5aef0"

Products productsFromJson(String str) => Products.fromJson(json.decode(str));
String productsToJson(Products data) => json.encode(data.toJson());
class Products {
  Products({
      String? productId, 
      String? shopId, 
      String? size, 
      String? image, 
      String? productName, 
      String? shopName, 
      String? color, 
      num? qty, 
      String? id,}){
    _productId = productId;
    _shopId = shopId;
    _size = size;
    _image = image;
    _productName = productName;
    _shopName = shopName;
    _color = color;
    _qty = qty;
    _id = id;
}

  Products.fromJson(dynamic json) {
    _productId = json['productId'];
    _shopId = json['shopId'];
    _size = json['size'];
    _image = json['image'];
    _productName = json['product_name'];
    _shopName = json['shop_name'];
    _color = json['color'];
    _qty = json['qty'];
    _id = json['_id'];
  }
  String? _productId;
  String? _shopId;
  String? _size;
  String? _image;
  String? _productName;
  String? _shopName;
  String? _color;
  num? _qty;
  String? _id;
Products copyWith({  String? productId,
  String? shopId,
  String? size,
  String? image,
  String? productName,
  String? shopName,
  String? color,
  num? qty,
  String? id,
}) => Products(  productId: productId ?? _productId,
  shopId: shopId ?? _shopId,
  size: size ?? _size,
  image: image ?? _image,
  productName: productName ?? _productName,
  shopName: shopName ?? _shopName,
  color: color ?? _color,
  qty: qty ?? _qty,
  id: id ?? _id,
);
  String? get productId => _productId;
  String? get shopId => _shopId;
  String? get size => _size;
  String? get image => _image;
  String? get productName => _productName;
  String? get shopName => _shopName;
  String? get color => _color;
  num? get qty => _qty;
  String? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['productId'] = _productId;
    map['shopId'] = _shopId;
    map['size'] = _size;
    map['image'] = _image;
    map['product_name'] = _productName;
    map['shop_name'] = _shopName;
    map['color'] = _color;
    map['qty'] = _qty;
    map['_id'] = _id;
    return map;
  }

}