class Model {
  Model({
    this.userId,
    this.id,
    this.title,
    this.body,
  });

  Model.fromJson(dynamic json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    body = json['body'];
  }
  num? userId;
  num? id;
  String? title;
  String? body;
  Model copyWith({
    num? userId,
    num? id,
    String? title,
    String? body,
  }) =>
      Model(
        userId: userId ?? this.userId,
        id: id ?? this.id,
        title: title ?? this.title,
        body: body ?? this.body,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = userId;
    map['id'] = id;
    map['title'] = title;
    map['body'] = body;
    return map;
  }
}
