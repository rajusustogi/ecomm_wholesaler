class TrendingProducts {
  List<TrendingData> data;

  TrendingProducts({this.data});

  TrendingProducts.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<TrendingData>();
      json['data'].forEach((v) {
        data.add(new TrendingData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TrendingData {
  dynamic id;
  String title;
  String imageUrl;
  String manufacturer;
  dynamic packSize;
  dynamic composition;
  dynamic categoryId;
  dynamic mrp;
  dynamic offPercentage;
  dynamic offAmount;
  dynamic sellingPrice;
  bool isTrending;
  bool isActive;
  String createdAt;
  String updatedAt;
  Category category;

  TrendingData(
      {this.id,
      this.title,
      this.imageUrl,
      this.manufacturer,
      this.packSize,
      this.composition,
      this.categoryId,
      this.mrp,
      this.offPercentage,
      this.offAmount,
      this.sellingPrice,
      this.isTrending,
      this.isActive,
      this.createdAt,
      this.updatedAt,
      this.category});

  TrendingData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    imageUrl = json['image_url'];
    manufacturer = json['manufacturer'];
    packSize = json['pack_size'];
    composition = json['composition'];
    categoryId = json['category_id'];
    mrp = json['mrp'];
    offPercentage = json['off_percentage'];
    offAmount = json['off_amount'];
    sellingPrice = json['selling_price'];
    isTrending = json['is_trending'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image_url'] = this.imageUrl;
    data['manufacturer'] = this.manufacturer;
    data['pack_size'] = this.packSize;
    data['composition'] = this.composition;
    data['category_id'] = this.categoryId;
    data['mrp'] = this.mrp;
    data['off_percentage'] = this.offPercentage;
    data['off_amount'] = this.offAmount;
    data['selling_price'] = this.sellingPrice;
    data['is_trending'] = this.isTrending;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.category != null) {
      data['category'] = this.category.toJson();
    }
    return data;
  }
}

class Category {
  dynamic id;
  String title;
  bool isActive;
  String imageUrl;
  String createdAt;
  String updatedAt;

  Category(
      {this.id,
      this.title,
      this.isActive,
      this.imageUrl,
      this.createdAt,
      this.updatedAt});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    isActive = json['is_active'];
    imageUrl = json['image_url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['is_active'] = this.isActive;
    data['image_url'] = this.imageUrl;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
