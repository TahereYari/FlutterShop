class Basket {
  int? id;
  int? price;
  int? isPay;
  int? userId;
  String? createdAt;
  String? updatedAt;
  int? send;
  int? addressId;
  int? invoiceNumber;
  int? offcode;
  int? offcodeId;

  Basket(
      {this.id,
        this.price,
        this.isPay,
        this.userId,
        this.createdAt,
        this.updatedAt,
        this.send,
        this.addressId,
        this.invoiceNumber,
        this.offcode,
        this.offcodeId});

  Basket.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    isPay = json['is_pay'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    send = json['send'];
    addressId = json['address_id'];
    invoiceNumber = json['InvoiceNumber'];
    offcode = json['offcode'];
    offcodeId = json['offcode_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['price'] = price;
    data['is_pay'] = isPay;
    data['user_id'] = userId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['send'] = send;
    data['address_id'] = addressId;
    data['InvoiceNumber'] = invoiceNumber;
    data['offcode'] = offcode;
    data['offcode_id'] = offcodeId;
    return data;
  }
}
