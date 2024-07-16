class inntShop_list {
  String? result;
  String? message;
  List<Data>? data;

  inntShop_list({this.result, this.message, this.data});

  inntShop_list.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result'] = result;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  var shopId;
  var shopName;
  var logo;
  var frontImage;
  var shopAddress;
  var country;
  var city;
  var raters;
  var averageRatings;
  var sales;
  var distances;
  double? lon;
  double? lat;

  Data(
      {this.shopId,
        this.shopName,
        this.logo,
        this.frontImage,
        this.shopAddress,
        this.country,
        this.city,
        this.raters,
        this.averageRatings,
        this.sales,
        this.distances,
        this.lon,
        this.lat});

  Data.fromJson(Map<String, dynamic> json) {
    shopId = json['shopId'];
    shopName = json['shop_name'];
    logo = json['logo'];
    frontImage = json['frontImage'];
    shopAddress = json['shop_address'];
    country = json['country'];
    city = json['city'];
    raters = json['raters'];
    averageRatings = json['average_ratings'];
    sales = json['sales'];
    distances = json['distances'];
    lon = json['lon'];
    lat = json['lat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['shopId'] = shopId;
    data['shop_name'] = shopName;
    data['logo'] = logo;
    data['frontImage'] = frontImage;
    data['shop_address'] = shopAddress;
    data['country'] = country;
    data['city'] = city;
    data['raters'] = raters;
    data['average_ratings'] = averageRatings;
    data['sales'] = sales;
    data['distances'] = distances;
    data['lon'] = lon;
    data['lat'] = lat;
    return data;
  }
}
