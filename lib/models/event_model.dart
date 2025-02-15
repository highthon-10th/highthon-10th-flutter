class EventModel {
  final String id;
  final String favoriteMember;
  final double latitude;
  final double longitude;
  final String photoUrl;
  final String eventName;
  final String eventTime;
  final String eventLink;
  final String userName;
  final String description;
  final String createdAt;

  const EventModel({
    required this.id,
    required this.favoriteMember,
    required this.latitude,
    required this.longitude,
    required this.photoUrl,
    required this.eventName,
    required this.eventTime,
    required this.eventLink,
    required this.userName,
    required this.description,
    required this.createdAt,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'],
      favoriteMember: json['favorite_member'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      photoUrl: json['photo_url'],
      eventName: json['event_name'],
      eventTime: json['event_time'],
      eventLink: json['event_link'],
      userName: json['user_name'],
      description: json['description'],
      createdAt: json['created_at'],
    );
  }

  EventModel copyWith(
      String? id,
      String? favoriteMember,
      double? latitude,
      double? longitude,
      String? photoUrl,
      String? eventName,
      String? eventTime,
      String? eventLink,
      String? userName,
      String? description,
      String? createdAt,
      ) {
    return EventModel(
      id: id ?? this.id,
      favoriteMember: favoriteMember ?? this.favoriteMember,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      photoUrl: photoUrl ?? this.photoUrl,
      eventName: eventName ?? this.eventName,
      eventTime: eventTime ?? this.eventTime,
      eventLink: eventLink ?? this.eventLink,
      userName: userName ?? this.userName,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
