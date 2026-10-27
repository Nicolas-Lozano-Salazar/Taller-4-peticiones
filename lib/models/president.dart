class President {
  final int id;
  final String? image;
  final String name;
  final String? lastName;
  final String? startPeriodDate;
  final String? endPeriodDate;
  final String? politicalParty;
  final String? description;
  final int? cityId;
  final String? cityName;

  President({
    required this.id,
    this.image,
    required this.name,
    this.lastName,
    this.startPeriodDate,
    this.endPeriodDate,
    this.politicalParty,
    this.description,
    this.cityId,
    this.cityName,
  });

  factory President.fromJson(Map<String, dynamic> json) {
    final city = json['city'];
    return President(
      id: json['id'] is int ? json['id'] as int : int.tryParse('${json['id']}') ?? 0,
      image: json['image'] != null
          ? Uri.encodeFull(json['image'].toString())
          : null,
      name: json['name']?.toString() ?? '',
      lastName: json['lastName']?.toString(),
      startPeriodDate: json['startPeriodDate']?.toString(),
      endPeriodDate: json['endPeriodDate']?.toString(),
      politicalParty: json['politicalParty']?.toString(),
      description: json['description']?.toString(),
      cityId: json['cityId'] is int ? json['cityId'] as int : int.tryParse('${json['cityId']}'),
      cityName: city is Map<String, dynamic> ? city['name']?.toString() : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'image': image,
        'name': name,
        'lastName': lastName,
        'startPeriodDate': startPeriodDate,
        'endPeriodDate': endPeriodDate,
        'politicalParty': politicalParty,
        'description': description,
        'cityId': cityId,
        'cityName': cityName,
      };

  String get fullName => lastName == null || lastName!.isEmpty ? name : '$name $lastName';
}
