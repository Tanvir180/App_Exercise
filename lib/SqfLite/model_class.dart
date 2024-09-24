class ModelClass {
  final int? id;
  final String name;
  final int age;

  ModelClass({
    this.id,
    required this.name,
    required this.age,
  });

  // map --> Model Class
  factory ModelClass.fromMap(Map<String, dynamic> map) {
    return ModelClass(
      id: map['id'],
      age: map['age'],
      name: map['name'],
    );
  }

// model class --> map
  Map<String, Object?> tomap() {
    return {'id': id, 'age': age, 'name': name};
  }
}
