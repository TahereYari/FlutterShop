class Discount {
  int? id;
  int? off;
  String? startdate;
  String? enddate;
  int? productId;
  String? createdAt;
  String? updatedAt;

  Discount(
      {this.id,
        this.off,
        this.startdate,
        this.enddate,
        this.productId,
        this.createdAt,
        this.updatedAt});

  Discount.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    off = json['off'];
    startdate = json['startdate'];
    enddate = json['enddate'];
    productId = json['product_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['off'] = off;
    data['startdate'] = startdate;
    data['enddate'] = enddate;
    data['product_id'] = productId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
