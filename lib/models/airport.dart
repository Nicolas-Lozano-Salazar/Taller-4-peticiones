class Airport {
  final int id;
  final String name;
  final String? iataCode;
  final String? oaciCode;
  final String? type;
  final int? departmentId;
  final String? departmentName;
  final int? cityId;
  final String? cityName;
  final String? latitude;
  final String? longitude;

  Airport({
    required this.id,
    required this.name,
    this.iataCode,
    this.oaciCode,
    this.type,
    this.departmentId,
    this.departmentName,
    this.cityId,
    this.cityName,
    this.latitude,
    this.longitude,
  });

  factory Airport.fromJson(Map<String, dynamic> json) {
    final dept = json['department'];
    final city = json['city'];
    return Airport(
      id: json['id'] is int ? json['id'] as int : int.tryParse('${json['id']}') ?? 0,
      name: json['name']?.toString() ?? '',
      iataCode: json['iataCode']?.toString(),
      oaciCode: json['oaciCode']?.toString(),
      type: json['type']?.toString(),
      departmentId: (json['deparmentId'] ?? json['departmentId']) is int
          ? (json['deparmentId'] ?? json['departmentId']) as int
          : int.tryParse('${json['deparmentId'] ?? json['departmentId']}'),
      departmentName: dept is Map<String, dynamic> ? dept['name']?.toString() : null,
      cityId: json['cityId'] is int ? json['cityId'] as int : int.tryParse('${json['cityId']}'),
      cityName: city is Map<String, dynamic> ? city['name']?.toString() : null,
      latitude: json['latitude']?.toString(),
      longitude: json['longitude']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'iataCode': iataCode,
        'oaciCode': oaciCode,
        'type': type,
        'departmentId': departmentId,
        'departmentName': departmentName,
        'cityId': cityId,
        'cityName': cityName,
        'latitude': latitude,
        'longitude': longitude,
      };
}
