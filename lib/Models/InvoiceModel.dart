class InvoiceModel {
  List<InvoiceData> data;

  InvoiceModel({this.data});

  InvoiceModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<InvoiceData>();
      json['data'].forEach((v) {
        data.add(new InvoiceData.fromJson(v));
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

class InvoiceData {
  dynamic id;
  dynamic pickupId;
  dynamic wholesalerId;
  List<Products> products;
  dynamic amount;
  String pickupStatus;
  String deliveryCode;
  dynamic employeeId;
  dynamic employeeName;
  String pickupAddress;
  dynamic pickupDate;
  dynamic latitude;
  dynamic longitude;
  String createdAt;
  String updatedAt;
  dynamic deletedAt;
  Wholesaler wholesaler;
  dynamic employee;

  InvoiceData(
      {this.id,
      this.pickupId,
      this.wholesalerId,
      this.products,
      this.amount,
      this.pickupStatus,
      this.deliveryCode,
      this.employeeId,
      this.employeeName,
      this.pickupAddress,
      this.pickupDate,
      this.latitude,
      this.longitude,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.wholesaler,
      this.employee});

  InvoiceData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pickupId = json['pickup_id'];
    wholesalerId = json['wholesaler_id'];
    if (json['products'] != null) {
      products = new List<Products>();
      json['products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }
    amount = json['amount'];
    pickupStatus = json['pickup_status'];
    deliveryCode = json['delivery_code'];
    employeeId = json['employee_id'];
    employeeName = json['employee_name'];
    pickupAddress = json['pickup_address'];
    pickupDate = json['pickup_date'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    wholesaler = json['wholesaler'] != null
        ? new Wholesaler.fromJson(json['wholesaler'])
        : null;
    employee = json['employee'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pickup_id'] = this.pickupId;
    data['wholesaler_id'] = this.wholesalerId;
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    data['amount'] = this.amount;
    data['pickup_status'] = this.pickupStatus;
    data['delivery_code'] = this.deliveryCode;
    data['employee_id'] = this.employeeId;
    data['employee_name'] = this.employeeName;
    data['pickup_address'] = this.pickupAddress;
    data['pickup_date'] = this.pickupDate;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    if (this.wholesaler != null) {
      data['wholesaler'] = this.wholesaler.toJson();
    }
    data['employee'] = this.employee;
    return data;
  }
}

class Products {
  dynamic productId;
  String title;
  dynamic rate;
  dynamic noOfUnits;
  dynamic amount;
  String imageUrl;
  String manufacturer;
  String packSize;

  Products(
      {this.productId,
      this.title,
      this.rate,
      this.noOfUnits,
      this.amount,
      this.imageUrl,
      this.manufacturer,
      this.packSize});

  Products.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    title = json['title'];
    rate = json['rate'];
    noOfUnits = json['no_of_units'];
    amount = json['amount'];
    imageUrl = json['image_url'];
    manufacturer = json['manufacturer'];
    packSize = json['pack_size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['title'] = this.title;
    data['rate'] = this.rate;
    data['no_of_units'] = this.noOfUnits;
    data['amount'] = this.amount;
    data['image_url'] = this.imageUrl;
    data['manufacturer'] = this.manufacturer;
    data['pack_size'] = this.packSize;
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
