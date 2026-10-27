class TypicalDish {
  final int id;
  final String name;
  final String? description;
  final String? ingredients;
  final String? imageUrl;
  final int? departmentId;
  final String? departmentName;

  TypicalDish({
    required this.id,
    required this.name,
    this.description,
    this.ingredients,
    this.imageUrl,
    this.departmentId,
    this.departmentName,
  });

  factory TypicalDish.fromJson(Map<String, dynamic> json) {
    final dept = json['department'];
    return TypicalDish(
      id: json['id'] is int ? json['id'] as int : int.tryParse('${json['id']}') ?? 0,
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString(),
      ingredients: json['ingredients']?.toString(),
      imageUrl: json['imageUrl']?.toString(),
      departmentId: json['departmentId'] is int
          ? json['departmentId'] as int
          : int.tryParse('${json['departmentId']}'),
      departmentName: dept is Map<String, dynamic> ? dept['name']?.toString() : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'ingredients': ingredients,
        'imageUrl': imageUrl,
        'departmentId': departmentId,
        'departmentName': departmentName,
      };
}
