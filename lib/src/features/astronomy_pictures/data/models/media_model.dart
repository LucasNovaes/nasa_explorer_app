// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:nasa_explorer_app/src/features/astronomy_pictures/domain/entities/media_entity.dart';

class MediaModel {
  final String title;
  final DateTime date;
  final String url;
  final String explanation;
  final String mediaType;
  MediaModel({
    required this.title,
    required this.date,
    required this.url,
    required this.explanation,
    required this.mediaType,
  });

  MediaModel copyWith({
    String? title,
    DateTime? date,
    String? url,
    String? explanation,
    String? mediaType,
  }) {
    return MediaModel(
      title: title ?? this.title,
      date: date ?? this.date,
      url: url ?? this.url,
      explanation: explanation ?? this.explanation,
      mediaType: mediaType ?? this.mediaType,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'date': date.millisecondsSinceEpoch,
      'url': url,
      'explanation': explanation,
      'mediaType': mediaType,
    };
  }

  factory MediaModel.fromMap(Map<String, dynamic> map) {
    return MediaModel(
      title: map['title'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      url: map['url'] as String,
      explanation: map['explanation'] as String,
      mediaType: map['mediaType'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MediaModel.fromJson(String source) =>
      MediaModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MediaModel(title: $title, date: $date, url: $url, explanation: $explanation, mediaType: $mediaType)';
  }

  MediaEntity toEntity() {
    return MediaEntity(
      title: title,
      date: date,
      url: url,
      explanation: explanation,
      mediaType: mediaType,
    );
  }

  @override
  bool operator ==(covariant MediaModel other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.date == date &&
        other.url == url &&
        other.explanation == explanation &&
        other.mediaType == mediaType;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        date.hashCode ^
        url.hashCode ^
        explanation.hashCode ^
        mediaType.hashCode;
  }
}
