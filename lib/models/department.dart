class Department {
  final int id;
  final String name;
  final String? description;
  final int? cityCapitalId;
  final String? cityCapitalName;
  final int? municipalities;
  final int? surface;
  final int? population;
  final String? phonePrefix;
  final int? regionId;

  Department({
    required this.id,
    required this.name,
    this.description,
    this.cityCapitalId,
    this.cityCapitalName,
    this.municipalities,
    this.surface,
    this.population,
    this.phonePrefix,
    this.regionId,
  });

  factory Department.fromJson(Map<String, dynamic> json) {
    final cityCapital = json['cityCapital'];
    return Department(
      id: json['id'] is int ? json['id'] as int : int.tryParse('${json['id']}') ?? 0,
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString(),
      cityCapitalId: json['cityCapitalId'] is int
          ? json['cityCapitalId'] as int
          : int.tryParse('${json['cityCapitalId']}'),
      cityCapitalName: cityCapital is Map<String, dynamic>
          ? cityCapital['name']?.toString()
          : null,
      municipalities: json['municipalities'] is int
          ? json['municipalities'] as int
          : int.tryParse('${json['municipalities']}'),
      surface: json['surface'] is int
          ? json['surface'] as int
          : int.tryParse('${json['surface']}'),
      population: json['population'] is int
          ? json['population'] as int
          : int.tryParse('${json['population']}'),
      phonePrefix: json['phonePrefix']?.toString(),
      regionId: json['regionId'] is int
          ? json['regionId'] as int
          : int.tryParse('${json['regionId']}'),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'cityCapitalId': cityCapitalId,
        'cityCapitalName': cityCapitalName,
        'municipalities': municipalities,
        'surface': surface,
        'population': population,
        'phonePrefix': phonePrefix,
        'regionId': regionId,
      };
}
