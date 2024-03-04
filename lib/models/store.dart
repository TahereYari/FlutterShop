class Store {
  int? id;
  String? name;
  int? tel1;
  String? email;
  String? instagram;
  String? telegram;
  String? address;
  String? image;
  String? createdAt;
  String? updatedAt;
  String? describe;

  Store(
      {this.id,
        this.name,
        this.tel1,
        this.email,
        this.instagram,
        this.telegram,
        this.address,
        this.image,
        this.createdAt,
        this.updatedAt,
        this.describe});

  Store.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    tel1 = json['tel1'];
    email = json['email'];
    instagram = json['instagram'];
    telegram = json['telegram'];
    address = json['address'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    describe = json['describe'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['tel1'] = tel1;
    data['email'] = email;
    data['instagram'] = instagram;
    data['telegram'] = telegram;
    data['address'] = address;
    data['image'] = image;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['describe'] = describe;
    return data;
  }
}
