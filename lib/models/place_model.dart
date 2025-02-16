import 'dart:io';

class PlaceModel {
  final String name;
  final String favoriteMember;
  final String photoUrl;
  final double latitude;
  final double longitude;
  final String description;
  final String placeType;
  final String directionsLink;

  PlaceModel({
    required this.name,
    required this.favoriteMember,
    required this.photoUrl,
    required this.latitude,
    required this.longitude,
    required this.description,
    required this.placeType,
    required this.directionsLink,
  });

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    return PlaceModel(
      name: json['name'] as String,
      favoriteMember: json['favorite_member'] as String,
      photoUrl: json['photo_url'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      description: json['description'] as String,
      placeType: json['place_type'] as String,
      directionsLink: json['directions_link'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'favorite_member': favoriteMember,
      'photo_url': photoUrl,
      'latitude': latitude,
      'longitude': longitude,
      'description': description,
      'place_type': placeType,
      'directions_link': directionsLink,
    };
  }
}



class VisitModel {
  final String favoriteMember;
  final String visitId;
  final File file;

  VisitModel({
    required this.favoriteMember,
    required this.visitId,
    required this.file,
  });
}