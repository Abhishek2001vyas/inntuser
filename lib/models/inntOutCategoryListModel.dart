class InntOutCategoryListModel {
  String? sId;
  String? mainCategoryName;
  String? categoryImage;
  int? acrtiveStatus;
  String? categoryEnglishName;
  String? categoryFrenchName;
  int? iV;

  InntOutCategoryListModel(
      {this.sId,
      this.mainCategoryName,
      this.categoryImage,
      this.acrtiveStatus,
      this.categoryEnglishName,
      this.categoryFrenchName,
      this.iV});

  InntOutCategoryListModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    mainCategoryName = json['mainCategory_name'];
    categoryImage = json['category_image'];
    acrtiveStatus = json['acrtive_status'];
    categoryEnglishName = json['category_englishName'];
    categoryFrenchName = json['category_frenchName'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['mainCategory_name'] = mainCategoryName;
    data['category_image'] = categoryImage;
    data['acrtive_status'] = acrtiveStatus;
    data['category_englishName'] = categoryEnglishName;
    data['category_frenchName'] = categoryFrenchName;
    data['__v'] = iV;
    return data;
  }
}
