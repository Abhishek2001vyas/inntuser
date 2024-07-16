import 'dart:convert';
/// result : "true"
/// message : "product data get sucessfully"
/// data : [{"_id":"6603f89abbcb15c443e6fa0c","userId":"65d6fecd3e4d071b479ea66d","productId":{"_id":"65f1b45e69e61627081e08e0","venderId":"65eaf16c9c99c649416b1f62","product_name":"Checked Shirt with patch pocket","description":"Regular fit 100% cotton ","productType":"Digital","categoryId":"65eddc05e73fd3071ed36c10","subcategoryId":"65eddf19e73fd3071ed36c4c","sub_subcategoryId":"65ee9f5be73fd3071ed375bd","product_code":"44300","brand_name":"LEE COOPER","productPreparation_time":"30 Minutes","size":["Small","Medium","Large","X-Large","XX-Large"],"color":["Navy"],"product_details":"100% cotton","warranty":"14 Day(s)","note":"machine wash ","unit_price":1999,"sale_price":1994,"discount":[{"discount_type":"Unit","discount_value":5,"_id":"65f1b45e69e61627081e08e1"}],"Tax":[{"tax_name":"Exclude","tax_value":2,"_id":"65f1b45e69e61627081e08e2"}],"stock":[{"stock_name":"Unit","stock_value":0,"_id":"65f1b45e69e61627081e08e3"}],"minimum_order":1,"deliveryType":"Yes","image1":"-78Wx98H-443005820-navy-MODEL.jpg","image2":"-78Wx98H-443005820-navy-MODEL2.jpg","image3":"-78Wx98H-443005820-navy-MODEL3.jpg","image4":"-78Wx98H-443005820-navy-MODEL4.jpg","image5":"Shirt1.jpg","like_status":0,"rating":0,"product_status":0,"status":1,"hot_of_deals_status":0,"product_weight":"1 KG","returnType":[{"type":true,"value":7,"_id":"65f1b45e69e61627081e08e4"}],"createdAt":"2024-03-13T14:12:46.635Z","updatedAt":"2024-03-21T13:31:10.306Z","__v":0},"status":0,"createdAt":"2024-03-27T10:44:42.325Z","updatedAt":"2024-03-27T10:44:42.325Z","__v":0},{"_id":"6603f9c705d150b86f21bb34","userId":"65d6fecd3e4d071b479ea66d","productId":{"_id":"65f157bae3f45f7f69acf44d","venderId":"65eaf16c9c99c649416b1f62","product_name":"comfort flex waist jean","description":"wrangler authentic men regular fit comfort fit waist jean","productType":"Digital","categoryId":"65eddc05e73fd3071ed36c10","subcategoryId":"65eddf19e73fd3071ed36c4c","sub_subcategoryId":"65ee9f2ae73fd3071ed375b1","product_code":"122","brand_name":"Puma","productPreparation_time":"30 Minutes","size":["XXl","L"],"color":["Blue"],"product_details":"98% cotton, 2% spandex","warranty":"14 Day(s)","note":"only machine wash","unit_price":799,"sale_price":759.05,"discount":[{"discount_type":"Percent","discount_value":5,"_id":"66026d9d91075bdcdcb36df6"}],"Tax":[{"tax_name":"Exclude","tax_value":2,"_id":"65f157bae3f45f7f69acf44f"}],"stock":[{"stock_name":"Unit","stock_value":0,"_id":"65f157bae3f45f7f69acf450"}],"minimum_order":5,"deliveryType":"Yes","image1":"jeans1.jpg","image2":"jeans2.jpg","image3":"jeans3.jpg","image4":"jeans4.jpg","image5":"jeans5.jpg","like_status":0,"rating":4,"product_status":0,"status":1,"hot_of_deals_status":0,"product_weight":"1 KG","returnType":[{"type":true,"value":7,"_id":"65f157bae3f45f7f69acf451"}],"createdAt":"2024-03-13T07:37:30.589Z","updatedAt":"2024-03-26T06:39:25.255Z","__v":0},"status":0,"createdAt":"2024-03-27T10:49:43.261Z","updatedAt":"2024-03-27T10:49:43.261Z","__v":0}]

SuggestedProductList suggestedProductListFromJson(String str) => SuggestedProductList.fromJson(json.decode(str));
String suggestedProductListToJson(SuggestedProductList data) => json.encode(data.toJson());
class SuggestedProductList {
  SuggestedProductList({
      String? result, 
      String? message, 
      List<Data>? data,}){
    _result = result;
    _message = message;
    _data = data;
}

  SuggestedProductList.fromJson(dynamic json) {
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
SuggestedProductList copyWith({  String? result,
  String? message,
  List<Data>? data,
}) => SuggestedProductList(  result: result ?? _result,
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

/// _id : "6603f89abbcb15c443e6fa0c"
/// userId : "65d6fecd3e4d071b479ea66d"
/// productId : {"_id":"65f1b45e69e61627081e08e0","venderId":"65eaf16c9c99c649416b1f62","product_name":"Checked Shirt with patch pocket","description":"Regular fit 100% cotton ","productType":"Digital","categoryId":"65eddc05e73fd3071ed36c10","subcategoryId":"65eddf19e73fd3071ed36c4c","sub_subcategoryId":"65ee9f5be73fd3071ed375bd","product_code":"44300","brand_name":"LEE COOPER","productPreparation_time":"30 Minutes","size":["Small","Medium","Large","X-Large","XX-Large"],"color":["Navy"],"product_details":"100% cotton","warranty":"14 Day(s)","note":"machine wash ","unit_price":1999,"sale_price":1994,"discount":[{"discount_type":"Unit","discount_value":5,"_id":"65f1b45e69e61627081e08e1"}],"Tax":[{"tax_name":"Exclude","tax_value":2,"_id":"65f1b45e69e61627081e08e2"}],"stock":[{"stock_name":"Unit","stock_value":0,"_id":"65f1b45e69e61627081e08e3"}],"minimum_order":1,"deliveryType":"Yes","image1":"-78Wx98H-443005820-navy-MODEL.jpg","image2":"-78Wx98H-443005820-navy-MODEL2.jpg","image3":"-78Wx98H-443005820-navy-MODEL3.jpg","image4":"-78Wx98H-443005820-navy-MODEL4.jpg","image5":"Shirt1.jpg","like_status":0,"rating":0,"product_status":0,"status":1,"hot_of_deals_status":0,"product_weight":"1 KG","returnType":[{"type":true,"value":7,"_id":"65f1b45e69e61627081e08e4"}],"createdAt":"2024-03-13T14:12:46.635Z","updatedAt":"2024-03-21T13:31:10.306Z","__v":0}
/// status : 0
/// createdAt : "2024-03-27T10:44:42.325Z"
/// updatedAt : "2024-03-27T10:44:42.325Z"
/// __v : 0

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? id, 
      String? userId, 
      ProductId? productId, 
      num? status, 
      String? createdAt, 
      String? updatedAt, 
      num? v,}){
    _id = id;
    _userId = userId;
    _productId = productId;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
}

  Data.fromJson(dynamic json) {
    _id = json['_id'];
    _userId = json['userId'];
    _productId = json['productId'] != null ? ProductId.fromJson(json['productId']) : null;
    _status = json['status'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _v = json['__v'];
  }
  String? _id;
  String? _userId;
  ProductId? _productId;
  num? _status;
  String? _createdAt;
  String? _updatedAt;
  num? _v;
Data copyWith({  String? id,
  String? userId,
  ProductId? productId,
  num? status,
  String? createdAt,
  String? updatedAt,
  num? v,
}) => Data(  id: id ?? _id,
  userId: userId ?? _userId,
  productId: productId ?? _productId,
  status: status ?? _status,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  v: v ?? _v,
);
  String? get id => _id;
  String? get userId => _userId;
  ProductId? get productId => _productId;
  num? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  num? get v => _v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['userId'] = _userId;
    if (_productId != null) {
      map['productId'] = _productId?.toJson();
    }
    map['status'] = _status;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['__v'] = _v;
    return map;
  }

}

/// _id : "65f1b45e69e61627081e08e0"
/// venderId : "65eaf16c9c99c649416b1f62"
/// product_name : "Checked Shirt with patch pocket"
/// description : "Regular fit 100% cotton "
/// productType : "Digital"
/// categoryId : "65eddc05e73fd3071ed36c10"
/// subcategoryId : "65eddf19e73fd3071ed36c4c"
/// sub_subcategoryId : "65ee9f5be73fd3071ed375bd"
/// product_code : "44300"
/// brand_name : "LEE COOPER"
/// productPreparation_time : "30 Minutes"
/// size : ["Small","Medium","Large","X-Large","XX-Large"]
/// color : ["Navy"]
/// product_details : "100% cotton"
/// warranty : "14 Day(s)"
/// note : "machine wash "
/// unit_price : 1999
/// sale_price : 1994
/// discount : [{"discount_type":"Unit","discount_value":5,"_id":"65f1b45e69e61627081e08e1"}]
/// Tax : [{"tax_name":"Exclude","tax_value":2,"_id":"65f1b45e69e61627081e08e2"}]
/// stock : [{"stock_name":"Unit","stock_value":0,"_id":"65f1b45e69e61627081e08e3"}]
/// minimum_order : 1
/// deliveryType : "Yes"
/// image1 : "-78Wx98H-443005820-navy-MODEL.jpg"
/// image2 : "-78Wx98H-443005820-navy-MODEL2.jpg"
/// image3 : "-78Wx98H-443005820-navy-MODEL3.jpg"
/// image4 : "-78Wx98H-443005820-navy-MODEL4.jpg"
/// image5 : "Shirt1.jpg"
/// like_status : 0
/// rating : 0
/// product_status : 0
/// status : 1
/// hot_of_deals_status : 0
/// product_weight : "1 KG"
/// returnType : [{"type":true,"value":7,"_id":"65f1b45e69e61627081e08e4"}]
/// createdAt : "2024-03-13T14:12:46.635Z"
/// updatedAt : "2024-03-21T13:31:10.306Z"
/// __v : 0

ProductId productIdFromJson(String str) => ProductId.fromJson(json.decode(str));
String productIdToJson(ProductId data) => json.encode(data.toJson());
class ProductId {
  ProductId({
      String? id, 
      String? venderId, 
      String? productName, 
      String? description, 
      String? productType, 
      String? categoryId, 
      String? subcategoryId, 
      String? subSubcategoryId, 
      String? productCode, 
      String? brandName, 
      String? productPreparationTime, 
      List<String>? size, 
      List<String>? color, 
      String? productDetails, 
      String? warranty, 
      String? note, 
      num? unitPrice, 
      num? salePrice, 
      List<Discount>? discount, 
      List<Tax>? tax, 
      List<Stock>? stock, 
      num? minimumOrder, 
      String? deliveryType, 
      String? image1, 
      String? image2, 
      String? image3, 
      String? image4, 
      String? image5, 
      num? likeStatus, 
      num? rating, 
      num? productStatus, 
      num? status, 
      num? hotOfDealsStatus, 
      String? productWeight, 
      List<ReturnType>? returnType, 
      String? createdAt, 
      String? updatedAt, 
      num? v,}){
    _id = id;
    _venderId = venderId;
    _productName = productName;
    _description = description;
    _productType = productType;
    _categoryId = categoryId;
    _subcategoryId = subcategoryId;
    _subSubcategoryId = subSubcategoryId;
    _productCode = productCode;
    _brandName = brandName;
    _productPreparationTime = productPreparationTime;
    _size = size;
    _color = color;
    _productDetails = productDetails;
    _warranty = warranty;
    _note = note;
    _unitPrice = unitPrice;
    _salePrice = salePrice;
    _discount = discount;
    _tax = tax;
    _stock = stock;
    _minimumOrder = minimumOrder;
    _deliveryType = deliveryType;
    _image1 = image1;
    _image2 = image2;
    _image3 = image3;
    _image4 = image4;
    _image5 = image5;
    _likeStatus = likeStatus;
    _rating = rating;
    _productStatus = productStatus;
    _status = status;
    _hotOfDealsStatus = hotOfDealsStatus;
    _productWeight = productWeight;
    _returnType = returnType;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
}

  ProductId.fromJson(dynamic json) {
    _id = json['_id'];
    _venderId = json['venderId'];
    _productName = json['product_name'];
    _description = json['description'];
    _productType = json['productType'];
    _categoryId = json['categoryId'];
    _subcategoryId = json['subcategoryId'];
    _subSubcategoryId = json['sub_subcategoryId'];
    _productCode = json['product_code'];
    _brandName = json['brand_name'];
    _productPreparationTime = json['productPreparation_time'];
    _size = json['size'] != null ? json['size'].cast<String>() : [];
    _color = json['color'] != null ? json['color'].cast<String>() : [];
    _productDetails = json['product_details'];
    _warranty = json['warranty'];
    _note = json['note'];
    _unitPrice = json['unit_price'];
    _salePrice = json['sale_price'];
    if (json['discount'] != null) {
      _discount = [];
      json['discount'].forEach((v) {
        _discount?.add(Discount.fromJson(v));
      });
    }
    if (json['Tax'] != null) {
      _tax = [];
      json['Tax'].forEach((v) {
        _tax?.add(Tax.fromJson(v));
      });
    }
    if (json['stock'] != null) {
      _stock = [];
      json['stock'].forEach((v) {
        _stock?.add(Stock.fromJson(v));
      });
    }
    _minimumOrder = json['minimum_order'];
    _deliveryType = json['deliveryType'];
    _image1 = json['image1'];
    _image2 = json['image2'];
    _image3 = json['image3'];
    _image4 = json['image4'];
    _image5 = json['image5'];
    _likeStatus = json['like_status'];
    _rating = json['rating'];
    _productStatus = json['product_status'];
    _status = json['status'];
    _hotOfDealsStatus = json['hot_of_deals_status'];
    _productWeight = json['product_weight'];
    if (json['returnType'] != null) {
      _returnType = [];
      json['returnType'].forEach((v) {
        _returnType?.add(ReturnType.fromJson(v));
      });
    }
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _v = json['__v'];
  }
  String? _id;
  String? _venderId;
  String? _productName;
  String? _description;
  String? _productType;
  String? _categoryId;
  String? _subcategoryId;
  String? _subSubcategoryId;
  String? _productCode;
  String? _brandName;
  String? _productPreparationTime;
  List<String>? _size;
  List<String>? _color;
  String? _productDetails;
  String? _warranty;
  String? _note;
  num? _unitPrice;
  num? _salePrice;
  List<Discount>? _discount;
  List<Tax>? _tax;
  List<Stock>? _stock;
  num? _minimumOrder;
  String? _deliveryType;
  String? _image1;
  String? _image2;
  String? _image3;
  String? _image4;
  String? _image5;
  num? _likeStatus;
  num? _rating;
  num? _productStatus;
  num? _status;
  num? _hotOfDealsStatus;
  String? _productWeight;
  List<ReturnType>? _returnType;
  String? _createdAt;
  String? _updatedAt;
  num? _v;
ProductId copyWith({  String? id,
  String? venderId,
  String? productName,
  String? description,
  String? productType,
  String? categoryId,
  String? subcategoryId,
  String? subSubcategoryId,
  String? productCode,
  String? brandName,
  String? productPreparationTime,
  List<String>? size,
  List<String>? color,
  String? productDetails,
  String? warranty,
  String? note,
  num? unitPrice,
  num? salePrice,
  List<Discount>? discount,
  List<Tax>? tax,
  List<Stock>? stock,
  num? minimumOrder,
  String? deliveryType,
  String? image1,
  String? image2,
  String? image3,
  String? image4,
  String? image5,
  num? likeStatus,
  num? rating,
  num? productStatus,
  num? status,
  num? hotOfDealsStatus,
  String? productWeight,
  List<ReturnType>? returnType,
  String? createdAt,
  String? updatedAt,
  num? v,
}) => ProductId(  id: id ?? _id,
  venderId: venderId ?? _venderId,
  productName: productName ?? _productName,
  description: description ?? _description,
  productType: productType ?? _productType,
  categoryId: categoryId ?? _categoryId,
  subcategoryId: subcategoryId ?? _subcategoryId,
  subSubcategoryId: subSubcategoryId ?? _subSubcategoryId,
  productCode: productCode ?? _productCode,
  brandName: brandName ?? _brandName,
  productPreparationTime: productPreparationTime ?? _productPreparationTime,
  size: size ?? _size,
  color: color ?? _color,
  productDetails: productDetails ?? _productDetails,
  warranty: warranty ?? _warranty,
  note: note ?? _note,
  unitPrice: unitPrice ?? _unitPrice,
  salePrice: salePrice ?? _salePrice,
  discount: discount ?? _discount,
  tax: tax ?? _tax,
  stock: stock ?? _stock,
  minimumOrder: minimumOrder ?? _minimumOrder,
  deliveryType: deliveryType ?? _deliveryType,
  image1: image1 ?? _image1,
  image2: image2 ?? _image2,
  image3: image3 ?? _image3,
  image4: image4 ?? _image4,
  image5: image5 ?? _image5,
  likeStatus: likeStatus ?? _likeStatus,
  rating: rating ?? _rating,
  productStatus: productStatus ?? _productStatus,
  status: status ?? _status,
  hotOfDealsStatus: hotOfDealsStatus ?? _hotOfDealsStatus,
  productWeight: productWeight ?? _productWeight,
  returnType: returnType ?? _returnType,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  v: v ?? _v,
);
  String? get id => _id;
  String? get venderId => _venderId;
  String? get productName => _productName;
  String? get description => _description;
  String? get productType => _productType;
  String? get categoryId => _categoryId;
  String? get subcategoryId => _subcategoryId;
  String? get subSubcategoryId => _subSubcategoryId;
  String? get productCode => _productCode;
  String? get brandName => _brandName;
  String? get productPreparationTime => _productPreparationTime;
  List<String>? get size => _size;
  List<String>? get color => _color;
  String? get productDetails => _productDetails;
  String? get warranty => _warranty;
  String? get note => _note;
  num? get unitPrice => _unitPrice;
  num? get salePrice => _salePrice;
  List<Discount>? get discount => _discount;
  List<Tax>? get tax => _tax;
  List<Stock>? get stock => _stock;
  num? get minimumOrder => _minimumOrder;
  String? get deliveryType => _deliveryType;
  String? get image1 => _image1;
  String? get image2 => _image2;
  String? get image3 => _image3;
  String? get image4 => _image4;
  String? get image5 => _image5;
  num? get likeStatus => _likeStatus;
  num? get rating => _rating;
  num? get productStatus => _productStatus;
  num? get status => _status;
  num? get hotOfDealsStatus => _hotOfDealsStatus;
  String? get productWeight => _productWeight;
  List<ReturnType>? get returnType => _returnType;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  num? get v => _v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['venderId'] = _venderId;
    map['product_name'] = _productName;
    map['description'] = _description;
    map['productType'] = _productType;
    map['categoryId'] = _categoryId;
    map['subcategoryId'] = _subcategoryId;
    map['sub_subcategoryId'] = _subSubcategoryId;
    map['product_code'] = _productCode;
    map['brand_name'] = _brandName;
    map['productPreparation_time'] = _productPreparationTime;
    map['size'] = _size;
    map['color'] = _color;
    map['product_details'] = _productDetails;
    map['warranty'] = _warranty;
    map['note'] = _note;
    map['unit_price'] = _unitPrice;
    map['sale_price'] = _salePrice;
    if (_discount != null) {
      map['discount'] = _discount?.map((v) => v.toJson()).toList();
    }
    if (_tax != null) {
      map['Tax'] = _tax?.map((v) => v.toJson()).toList();
    }
    if (_stock != null) {
      map['stock'] = _stock?.map((v) => v.toJson()).toList();
    }
    map['minimum_order'] = _minimumOrder;
    map['deliveryType'] = _deliveryType;
    map['image1'] = _image1;
    map['image2'] = _image2;
    map['image3'] = _image3;
    map['image4'] = _image4;
    map['image5'] = _image5;
    map['like_status'] = _likeStatus;
    map['rating'] = _rating;
    map['product_status'] = _productStatus;
    map['status'] = _status;
    map['hot_of_deals_status'] = _hotOfDealsStatus;
    map['product_weight'] = _productWeight;
    if (_returnType != null) {
      map['returnType'] = _returnType?.map((v) => v.toJson()).toList();
    }
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['__v'] = _v;
    return map;
  }

}

/// type : true
/// value : 7
/// _id : "65f1b45e69e61627081e08e4"

ReturnType returnTypeFromJson(String str) => ReturnType.fromJson(json.decode(str));
String returnTypeToJson(ReturnType data) => json.encode(data.toJson());
class ReturnType {
  ReturnType({
      bool? type, 
      num? value, 
      String? id,}){
    _type = type;
    _value = value;
    _id = id;
}

  ReturnType.fromJson(dynamic json) {
    _type = json['type'];
    _value = json['value'];
    _id = json['_id'];
  }
  bool? _type;
  num? _value;
  String? _id;
ReturnType copyWith({  bool? type,
  num? value,
  String? id,
}) => ReturnType(  type: type ?? _type,
  value: value ?? _value,
  id: id ?? _id,
);
  bool? get type => _type;
  num? get value => _value;
  String? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = _type;
    map['value'] = _value;
    map['_id'] = _id;
    return map;
  }

}

/// stock_name : "Unit"
/// stock_value : 0
/// _id : "65f1b45e69e61627081e08e3"

Stock stockFromJson(String str) => Stock.fromJson(json.decode(str));
String stockToJson(Stock data) => json.encode(data.toJson());
class Stock {
  Stock({
      String? stockName, 
      num? stockValue, 
      String? id,}){
    _stockName = stockName;
    _stockValue = stockValue;
    _id = id;
}

  Stock.fromJson(dynamic json) {
    _stockName = json['stock_name'];
    _stockValue = json['stock_value'];
    _id = json['_id'];
  }
  String? _stockName;
  num? _stockValue;
  String? _id;
Stock copyWith({  String? stockName,
  num? stockValue,
  String? id,
}) => Stock(  stockName: stockName ?? _stockName,
  stockValue: stockValue ?? _stockValue,
  id: id ?? _id,
);
  String? get stockName => _stockName;
  num? get stockValue => _stockValue;
  String? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['stock_name'] = _stockName;
    map['stock_value'] = _stockValue;
    map['_id'] = _id;
    return map;
  }

}

/// tax_name : "Exclude"
/// tax_value : 2
/// _id : "65f1b45e69e61627081e08e2"

Tax taxFromJson(String str) => Tax.fromJson(json.decode(str));
String taxToJson(Tax data) => json.encode(data.toJson());
class Tax {
  Tax({
      String? taxName, 
      num? taxValue, 
      String? id,}){
    _taxName = taxName;
    _taxValue = taxValue;
    _id = id;
}

  Tax.fromJson(dynamic json) {
    _taxName = json['tax_name'];
    _taxValue = json['tax_value'];
    _id = json['_id'];
  }
  String? _taxName;
  num? _taxValue;
  String? _id;
Tax copyWith({  String? taxName,
  num? taxValue,
  String? id,
}) => Tax(  taxName: taxName ?? _taxName,
  taxValue: taxValue ?? _taxValue,
  id: id ?? _id,
);
  String? get taxName => _taxName;
  num? get taxValue => _taxValue;
  String? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['tax_name'] = _taxName;
    map['tax_value'] = _taxValue;
    map['_id'] = _id;
    return map;
  }

}

/// discount_type : "Unit"
/// discount_value : 5
/// _id : "65f1b45e69e61627081e08e1"

Discount discountFromJson(String str) => Discount.fromJson(json.decode(str));
String discountToJson(Discount data) => json.encode(data.toJson());
class Discount {
  Discount({
      String? discountType, 
      num? discountValue, 
      String? id,}){
    _discountType = discountType;
    _discountValue = discountValue;
    _id = id;
}

  Discount.fromJson(dynamic json) {
    _discountType = json['discount_type'];
    _discountValue = json['discount_value'];
    _id = json['_id'];
  }
  String? _discountType;
  num? _discountValue;
  String? _id;
Discount copyWith({  String? discountType,
  num? discountValue,
  String? id,
}) => Discount(  discountType: discountType ?? _discountType,
  discountValue: discountValue ?? _discountValue,
  id: id ?? _id,
);
  String? get discountType => _discountType;
  num? get discountValue => _discountValue;
  String? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['discount_type'] = _discountType;
    map['discount_value'] = _discountValue;
    map['_id'] = _id;
    return map;
  }

}