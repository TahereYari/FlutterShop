class Comment {
  int? id;
  String? comment;
  int? productId;
  int? preview;
  String? createdAt;
  String? updatedAt;
  String? posetive;
  String? negative;
  String? title;
  String? emteaz;
  int? userId;

  Comment(
      {this.id,
        this.comment,
        this.productId,
        this.preview,
        this.createdAt,
        this.updatedAt,
        this.posetive,
        this.negative,
        this.title,
        this.emteaz,
        this.userId});

  Comment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comment = json['comment'];
    productId = json['product_id'];
    preview = json['preview'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    posetive = json['posetive'];
    negative = json['negative'];
    title = json['title'];
    emteaz = json['emteaz'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['comment'] = comment;
    data['product_id'] = productId;
    data['preview'] = preview;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['posetive'] = posetive;
    data['negative'] = negative;
    data['title'] = title;
    data['emteaz'] = emteaz;
    data['user_id'] = userId;
    return data;
  }
}
