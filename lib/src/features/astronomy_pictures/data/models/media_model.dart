import 'package:nasa_explorer_app/src/features/astronomy_pictures/domain/entities/media_entity.dart';

class MediaModel {
  final String title;
  final String date;
  final String url;
  final String explanation;
  final String mediaType;

  MediaModel({
    required this.title,
    required this.date,
    required this.url,
    required this.explanation,
    required this.mediaType,
  })  : assert(title.isNotEmpty),
        assert(date.isNotEmpty),
        assert(url.isNotEmpty),
        assert(explanation.isNotEmpty),
        assert(mediaType.isNotEmpty);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'date': date,
      'url': url,
      'explanation': explanation,
      'media_type': mediaType,
    };
  }

  factory MediaModel.fromMap(Map<String, dynamic> map) {
    return MediaModel(
      title: map['title'] != null ? map['title'] as String : '',
      date: map['date'] != null ? map['date'] as String : '',
      url: map['url'] != null ? map['url'] as String : '',
      explanation:
          map['explanation'] != null ? map['explanation'] as String : '',
      mediaType: map['media_type'] != null ? map['media_type'] as String : '',
    );
  }

  @override
  String toString() {
    return 'MediaModel(title: $title, date: $date, url: $url, explanation: $explanation, media_type: $mediaType)';
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
