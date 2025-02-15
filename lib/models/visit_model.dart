class VisitModel {
  final String id;
  final String name;
  final String favoriteMember;
  final double latitude;
  final double longitude;
  final String photoUrl;
  final String description;
  final String placeType;
  final String directionsLink;
  final String createdAt;

  const VisitModel({
    required this.id,
    required this.name,
    required this.favoriteMember,
    required this.latitude,
    required this.longitude,
    required this.photoUrl,
    required this.description,
    required this.placeType,
    required this.directionsLink,
    required this.createdAt,
  });

  factory VisitModel.fromJson(Map<String, dynamic> json) {
    return VisitModel(
      id: json['id'],
      name: json['name'],
      favoriteMember: json['favorite_member'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      photoUrl: json['photo_url'],
      description: json['description'],
      placeType: json['place_type'],
      directionsLink: json['directions_link'],
      createdAt: json['created_at'],
    );
  }

  VisitModel copyWith(
    String? id,
    String? name,
    String? favoriteMember,
    double? latitude,
    double? longitude,
    String? photoUrl,
    String? description,
    String? placeType,
    String? directionsLink,
    String? createdAt,
  ) {
    return VisitModel(
      id: id ?? this.id,
      name: name ?? this.name,
      favoriteMember: favoriteMember ?? this.favoriteMember,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      photoUrl: photoUrl ?? this.photoUrl,
      placeType: placeType ?? this.placeType,
      directionsLink: directionsLink ?? this.directionsLink,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
