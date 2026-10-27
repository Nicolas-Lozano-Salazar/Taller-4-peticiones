class TouristicAttraction {
  final int id;
  final String name;
  final String? description;
  final List<String> images;
  final String? latitude;
  final String? longitude;
  final int? cityId;
  final String? cityName;

  TouristicAttraction({
    required this.id,
    required this.name,
    this.description,
    this.images = const [],
    this.latitude,
    this.longitude,
    this.cityId,
    this.cityName,
  });

  factory TouristicAttraction.fromJson(Map<String, dynamic> json) {
    final city = json['city'];
    final imgs = json['images'];
    return TouristicAttraction(
      id: json['id'] is int ? json['id'] as int : int.tryParse('${json['id']}') ?? 0,
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString(),
      images: imgs is List
          ? imgs.map((e) => Uri.encodeFull(e.toString())).toList()
          : const [],
      latitude: json['latitude']?.toString(),
      longitude: json['longitude']?.toString(),
      cityId: json['cityId'] is int ? json['cityId'] as int : int.tryParse('${json['cityId']}'),
      cityName: city is Map<String, dynamic> ? city['name']?.toString() : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'images': images,
        'latitude': latitude,
        'longitude': longitude,
        'cityId': cityId,
        'cityName': cityName,
      };
}
