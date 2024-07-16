class Inntoutproductlist {
  String? _result;
  String? _message;
  List<Data>? _data;

  Inntoutproductlist({String? result, String? message, List<Data>? data}) {
    if (result != null) {
      _result = result;
    }
    if (message != null) {
      _message = message;
    }
    if (data != null) {
      _data = data;
    }
  }

  String? get result => _result;
  set result(String? result) => _result = result;
  String? get message => _message;
  set message(String? message) => _message = message;
  List<Data>? get data => _data;
  set data(List<Data>? data) => _data = data;

  Inntoutproductlist.fromJson(Map<String, dynamic> json) {
    _result = json['result'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = <Data>[];
      json['data'].forEach((v) {
        _data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result'] = _result;
    data['message'] = _message;
    if (_data != null) {
      data['data'] = _data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? _productId;
  String? _venderId;
  String? _categoryId;
  String? _productName;
  String? _description;
  String? _image1;
  String? _productCode;
  int? _unitPrice;
  double? _salePrice;
  int? _discount;
  String? _discountName;

  Data(
      {String? productId,
        String? venderId,
        String? categoryId,
        String? productName,
        String? description,
        String? image1,
        String? productCode,
        int? unitPrice,
        double? salePrice,
        int? discount,
        String? discountName}) {
    if (productId != null) {
      _productId = productId;
    }
    if (venderId != null) {
      _venderId = venderId;
    }
    if (categoryId != null) {
      _categoryId = categoryId;
    }
    if (productName != null) {
      _productName = productName;
    }
    if (description != null) {
      _description = description;
    }
    if (image1 != null) {
      _image1 = image1;
    }
    if (productCode != null) {
      _productCode = productCode;
    }
    if (unitPrice != null) {
      _unitPrice = unitPrice;
    }
    if (salePrice != null) {
      _salePrice = salePrice;
    }
    if (discount != null) {
      _discount = discount;
    }
    if (discountName != null) {
      _discountName = discountName;
    }
  }

  String? get productId => _productId;
  set productId(String? productId) => _productId = productId;
  String? get venderId => _venderId;
  set venderId(String? venderId) => _venderId = venderId;
  String? get categoryId => _categoryId;
  set categoryId(String? categoryId) => _categoryId = categoryId;
  String? get productName => _productName;
  set productName(String? productName) => _productName = productName;
  String? get description => _description;
  set description(String? description) => _description = description;
  String? get image1 => _image1;
  set image1(String? image1) => _image1 = image1;
  String? get productCode => _productCode;
  set productCode(String? productCode) => _productCode = productCode;
  int? get unitPrice => _unitPrice;
  set unitPrice(int? unitPrice) => _unitPrice = unitPrice;
  double? get salePrice => _salePrice;
  set salePrice(double? salePrice) => _salePrice = salePrice;
  int? get discount => _discount;
  set discount(int? discount) => _discount = discount;
  String? get discountName => _discountName;
  set discountName(String? discountName) => _discountName = discountName;

  Data.fromJson(Map<String, dynamic> json) {
    _productId = json['productId'];
    _venderId = json['venderId'];
    _categoryId = json['categoryId'];
    _productName = json['product_name'];
    _description = json['description'];
    _image1 = json['image1'];
    _productCode = json['product_code'];
    _unitPrice = json['unit_price'];
    _salePrice = json['sale_price'];
    _discount = json['discount'];
    _discountName = json['discount_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productId'] = _productId;
    data['venderId'] = _venderId;
    data['categoryId'] = _categoryId;
    data['product_name'] = _productName;
    data['description'] = _description;
    data['image1'] = _image1;
    data['product_code'] = _productCode;
    data['unit_price'] = _unitPrice;
    data['sale_price'] = _salePrice;
    data['discount'] = _discount;
    data['discount_name'] = _discountName;
    return data;
  }
}
