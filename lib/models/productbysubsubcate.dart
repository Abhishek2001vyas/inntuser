import 'dart:convert';
/// result : "true"
/// message : "product data get sucessfully"
/// data : [{"productId":"65ec08ed93fb56e5b3853f8f","venderId":"65eaf16c9c99c649416b1f62","categoryId":"65ec018e97d37cd76d3de84f","sub_subcategoryId":"65ec028e97d37cd76d3de92b","subcategoryId":"65ec024997d37cd76d3de8e3","product_name":"ff","description":"fgg","image1":"yshirt3.jpg","product_code":"566","unit_price":888,"sale_price":880,"discount":8,"discount_name":"Unit"}]

Productbysubsubcate productbysubsubcateFromJson(String str) => Productbysubsubcate.fromJson(json.decode(str));
String productbysubsubcateToJson(Productbysubsubcate data) => json.encode(data.toJson());
class Productbysubsubcate {
  Productbysubsubcate({
      String? result, 
      String? message, 
      List<Data>? data,}){
    _result = result;
    _message = message;
    _data = data;
}

  Productbysubsubcate.fromJson(dynamic json) {
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
Productbysubsubcate copyWith({  String? result,
  String? message,
  List<Data>? data,
}) => Productbysubsubcate(  result: result ?? _result,
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

/// productId : "65ec08ed93fb56e5b3853f8f"
/// venderId : "65eaf16c9c99c649416b1f62"
/// categoryId : "65ec018e97d37cd76d3de84f"
/// sub_subcategoryId : "65ec028e97d37cd76d3de92b"
/// subcategoryId : "65ec024997d37cd76d3de8e3"
/// product_name : "ff"
/// description : "fgg"
/// image1 : "yshirt3.jpg"
/// product_code : "566"
/// unit_price : 888
/// sale_price : 880
/// discount : 8
/// discount_name : "Unit"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? productId, 
      String? venderId, 
      String? categoryId, 
      String? subSubcategoryId, 
      String? subcategoryId, 
      String? productName, 
      String? description, 
      String? image1, 
      String? productCode, 
      num? unitPrice, 
      num? salePrice, 
      num? discount, 
      String? discountName,}){
    _productId = productId;
    _venderId = venderId;
    _categoryId = categoryId;
    _subSubcategoryId = subSubcategoryId;
    _subcategoryId = subcategoryId;
    _productName = productName;
    _description = description;
    _image1 = image1;
    _productCode = productCode;
    _unitPrice = unitPrice;
    _salePrice = salePrice;
    _discount = discount;
    _discountName = discountName;
}

  Data.fromJson(dynamic json) {
    _productId = json['productId'];
    _venderId = json['venderId'];
    _categoryId = json['categoryId'];
    _subSubcategoryId = json['sub_subcategoryId'];
    _subcategoryId = json['subcategoryId'];
    _productName = json['product_name'];
    _description = json['description'];
    _image1 = json['image1'];
    _productCode = json['product_code'];
    _unitPrice = json['unit_price'];
    _salePrice = json['sale_price'];
    _discount = json['discount'];
    _discountName = json['discount_name'];
  }
  String? _productId;
  String? _venderId;
  String? _categoryId;
  String? _subSubcategoryId;
  String? _subcategoryId;
  String? _productName;
  String? _description;
  String? _image1;
  String? _productCode;
  num? _unitPrice;
  num? _salePrice;
  num? _discount;
  String? _discountName;
Data copyWith({  String? productId,
  String? venderId,
  String? categoryId,
  String? subSubcategoryId,
  String? subcategoryId,
  String? productName,
  String? description,
  String? image1,
  String? productCode,
  num? unitPrice,
  num? salePrice,
  num? discount,
  String? discountName,
}) => Data(  productId: productId ?? _productId,
  venderId: venderId ?? _venderId,
  categoryId: categoryId ?? _categoryId,
  subSubcategoryId: subSubcategoryId ?? _subSubcategoryId,
  subcategoryId: subcategoryId ?? _subcategoryId,
  productName: productName ?? _productName,
  description: description ?? _description,
  image1: image1 ?? _image1,
  productCode: productCode ?? _productCode,
  unitPrice: unitPrice ?? _unitPrice,
  salePrice: salePrice ?? _salePrice,
  discount: discount ?? _discount,
  discountName: discountName ?? _discountName,
);
  String? get productId => _productId;
  String? get venderId => _venderId;
  String? get categoryId => _categoryId;
  String? get subSubcategoryId => _subSubcategoryId;
  String? get subcategoryId => _subcategoryId;
  String? get productName => _productName;
  String? get description => _description;
  String? get image1 => _image1;
  String? get productCode => _productCode;
  num? get unitPrice => _unitPrice;
  num? get salePrice => _salePrice;
  num? get discount => _discount;
  String? get discountName => _discountName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['productId'] = _productId;
    map['venderId'] = _venderId;
    map['categoryId'] = _categoryId;
    map['sub_subcategoryId'] = _subSubcategoryId;
    map['subcategoryId'] = _subcategoryId;
    map['product_name'] = _productName;
    map['description'] = _description;
    map['image1'] = _image1;
    map['product_code'] = _productCode;
    map['unit_price'] = _unitPrice;
    map['sale_price'] = _salePrice;
    map['discount'] = _discount;
    map['discount_name'] = _discountName;
    return map;
  }

}