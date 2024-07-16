class ProductListModel {
  String? productId;
  String? venderId;
  String? categoryId;
  String? productName;
  String? description;
  String? image1;
  String? productCode;
  int? mrpPrice;
  int? salePrice;
  double? discountPercentage;

  ProductListModel(
      {this.productId,
      this.venderId,
      this.categoryId,
      this.productName,
      this.description,
      this.image1,
      this.productCode,
      this.mrpPrice,
      this.salePrice,
      this.discountPercentage});

  ProductListModel.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    venderId = json['venderId'];
    categoryId = json['categoryId'];
    productName = json['product_name'];
    description = json['description'];
    image1 = json['image1'];
    productCode = json['product_code'];
    mrpPrice = json['mrp_price'];
    salePrice = json['sale_price'];
    discountPercentage = json['discount_percentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productId'] = productId;
    data['venderId'] = venderId;
    data['categoryId'] = categoryId;
    data['product_name'] = productName;
    data['description'] = description;
    data['image1'] = image1;
    data['product_code'] = productCode;
    data['mrp_price'] = mrpPrice;
    data['sale_price'] = salePrice;
    data['discount_percentage'] = discountPercentage;
    return data;
  }
}
