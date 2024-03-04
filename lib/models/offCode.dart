class OffCode {
  int? id;
  String? code;
  int? price;
  String? satartdate;
  String? enddate;
  String? createdAt;
  String? updatedAt;

  OffCode(
      {this.id,
        this.code,
        this.price,
        this.satartdate,
        this.enddate,
        this.createdAt,
        this.updatedAt});

  OffCode.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    price = json['price'];
    satartdate = json['satartdate'];
    enddate = json['enddate'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['code'] = code;
    data['price'] = price;
    data['satartdate'] = satartdate;
    data['enddate'] = enddate;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
