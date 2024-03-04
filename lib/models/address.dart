class Address {
  int? id;
  String? name;
  String? ostan;
  String? shahr;
  int? code;
  int? tel;
  String? address;
  String? createdAt;
  String? updatedAt;
  int? userId;

  Address(
      {this.id,
        this.name,
        this.ostan,
        this.shahr,
        this.code,
        this.tel,
        this.address,
        this.createdAt,
        this.updatedAt,
        this.userId});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    ostan = json['ostan'];
    shahr = json['shahr'];
    code = json['code'];
    tel = json['tel'];
    address = json['address'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['ostan'] = ostan;
    data['shahr'] = shahr;
    data['code'] = code;
    data['tel'] = tel;
    data['address'] = address;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['user_id'] = userId;
    return data;
  }
}
