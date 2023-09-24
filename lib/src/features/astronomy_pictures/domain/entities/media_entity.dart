class MediaEntity {
  final String title;
  final String date;
  final String url;
  final String explanation;
  final String mediaType;

  const MediaEntity({
    required this.title,
    required this.date,
    required this.url,
    required this.explanation,
    required this.mediaType,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'date': date,
      'url': url,
      'explanation': explanation,
      'media_type': mediaType,
    };
  }
}
