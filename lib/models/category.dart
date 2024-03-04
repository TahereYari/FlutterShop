class Category {
  int? id;
  String? name;
  String? description;
  String? createdAt;
  String? updatedAt;
  int? deleteStatuse;
  String? image;

  Category(
      {this.id,
        this.name,
        this.description,
        this.createdAt,
        this.updatedAt,
        this.deleteStatuse,
        this.image});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deleteStatuse = json['DeleteStatuse'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['DeleteStatuse'] = deleteStatuse;
    data['image'] = image;
    return data;
  }
}
