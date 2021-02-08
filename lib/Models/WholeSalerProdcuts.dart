class WholesalerProductModel {
  List<WholesalerProductData> data;

  WholesalerProductModel({this.data});

  WholesalerProductModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<WholesalerProductData>();
      json['data'].forEach((v) {
        data.add(new WholesalerProductData.fromJson(v));
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

class WholesalerProductData {
  dynamic id;
  dynamic wholesalerId;
  dynamic productId;
  String productName;
  dynamic mrp;
  dynamic offPercentage;
  dynamic offAmount;
  dynamic dealPrice;
  dynamic previousPrice;
  dynamic composition;
  bool isAssigned;
  String createdAt;
  String updatedAt;
  Wholesaler wholesaler;
  Product product;

  WholesalerProductData(
      {this.id,
      this.wholesalerId,
      this.productId,
      this.productName,
      this.mrp,
      this.offPercentage,
      this.offAmount,
      this.dealPrice,
      this.previousPrice,
      this.composition,
      this.isAssigned,
      this.createdAt,
      this.updatedAt,
      this.wholesaler,
      this.product});

  WholesalerProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    wholesalerId = json['wholesaler_id'];
    productId = json['product_id'];
    productName = json['product_name'];
    mrp = json['mrp'];
    offPercentage = json['off_percentage'];
    offAmount = json['off_amount'];
    dealPrice = json['deal_price'];
    previousPrice = json['previous_price'];
    composition = json['composition'];
    isAssigned = json['is_assigned'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    wholesaler = json['wholesaler'] != null
        ? new Wholesaler.fromJson(json['wholesaler'])
        : null;
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['wholesaler_id'] = this.wholesalerId;
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['mrp'] = this.mrp;
    data['off_percentage'] = this.offPercentage;
    data['off_amount'] = this.offAmount;
    data['deal_price'] = this.dealPrice;
    data['previous_price'] = this.previousPrice;
    data['composition'] = this.composition;
    data['is_assigned'] = this.isAssigned;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.wholesaler != null) {
      data['wholesaler'] = this.wholesaler.toJson();
    }
    if (this.product != null) {
      data['product'] = this.product.toJson();
    }
    return data;
  }
}

class Wholesaler {
  dynamic id;
  String name;
  String storeName;
  String email;
  String mobileNo;
  dynamic alternateNo;
  String password;
  String address;
  String landmark;
  String state;
  String pincode;
  dynamic pendingAmount;
  dynamic latitude;
  dynamic longitude;
  bool isActive;
  String createdAt;
  String updatedAt;

  Wholesaler(
      {this.id,
      this.name,
      this.storeName,
      this.email,
      this.mobileNo,
      this.alternateNo,
      this.password,
      this.address,
      this.landmark,
      this.state,
      this.pincode,
      this.pendingAmount,
      this.latitude,
      this.longitude,
      this.isActive,
      this.createdAt,
      this.updatedAt});

  Wholesaler.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    storeName = json['store_name'];
    email = json['email'];
    mobileNo = json['mobile_no'];
    alternateNo = json['alternate_no'];
    password = json['password'];
    address = json['address'];
    landmark = json['landmark'];
    state = json['state'];
    pincode = json['pincode'];
    pendingAmount = json['pending_amount'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['store_name'] = this.storeName;
    data['email'] = this.email;
    data['mobile_no'] = this.mobileNo;
    data['alternate_no'] = this.alternateNo;
    data['password'] = this.password;
    data['address'] = this.address;
    data['landmark'] = this.landmark;
    data['state'] = this.state;
    data['pincode'] = this.pincode;
    data['pending_amount'] = this.pendingAmount;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Product {
  dynamic id;
  String title;
  dynamic imageUrl;
  String manufacturer;
  String packSize;
  String composition;
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

  Product(
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

  Product.fromJson(Map<String, dynamic> json) {
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
  int id;
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
