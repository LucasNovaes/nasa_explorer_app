import 'package:flutter_test/flutter_test.dart';
import 'package:nasa_explorer_app/src/features/astronomy_pictures/data/data.dart';

void main() {
  const String title = 'My Title';
  const String date = '2023-09-26';
  const String url = 'https://example.com/image.jpg';
  const String explanation = 'My explanation';
  const String mediaType = 'image';

  test('Should create a valid MediaModel from a map', () {
    final map = {
      'title': title,
      'date': date,
      'url': url,
      'explanation': explanation,
      'media_type': mediaType,
    };

    final mediaModel = MediaModel.fromMap(map);

    expect(mediaModel.title, title);
    expect(mediaModel.date, date);
    expect(mediaModel.url, url);
    expect(mediaModel.explanation, explanation);
    expect(mediaModel.mediaType, mediaType);
  });

  test('Should create a valid MediaModel from a map with missing fields', () {
    final map = {
      'title': title,
      'date': date,
      'url': url,
      'explanation': explanation,
      'media_type': mediaType,
    };

    final mediaModel = MediaModel.fromMap(map);

    expect(mediaModel.title, title);
    expect(mediaModel.date, date);
    expect(mediaModel.url, url);
    expect(mediaModel.explanation, explanation);
    expect(mediaModel.mediaType, mediaType);
  });

  test('Should create a valid MediaEntity from a MediaModel', () {
    final mediaModel = MediaModel(
      title: title,
      date: date,
      url: url,
      explanation: explanation,
      mediaType: mediaType,
    );

    final mediaEntity = mediaModel.toEntity();

    expect(mediaEntity.title, title);
    expect(mediaEntity.date, date);
    expect(mediaEntity.url, url);
    expect(mediaEntity.explanation, explanation);
    expect(mediaEntity.mediaType, mediaType);
  });

  test('Should return a valid map from the toMap() method', () async {
    final mediaModel = MediaModel(
      title: title,
      date: date,
      url: url,
      explanation: explanation,
      mediaType: mediaType,
    );

    final map = mediaModel.toMap();

    expect(map['title'], title);
    expect(map['date'], date);
    expect(map['url'], url);
    expect(map['explanation'], explanation);
    expect(map['media_type'], mediaType);
  });

  test('Should equal another MediaModel with the same properties', () {
    final mediaModel1 = MediaModel(
      title: title,
      date: date,
      url: url,
      explanation: explanation,
      mediaType: mediaType,
    );
    final mediaModel2 = MediaModel(
      title: title,
      date: date,
      url: url,
      explanation: explanation,
      mediaType: mediaType,
    );

    final isEqual = mediaModel1 == mediaModel2;

    expect(isEqual, true);
  });

  test('Should return a valid string from the toString() method', () async {
    final mediaModel = MediaModel(
      title: title,
      date: date,
      url: url,
      explanation: explanation,
      mediaType: mediaType,
    );

    final string = mediaModel.toString();

    expect(string,
        'MediaModel(title: $title, date: $date, url: $url, explanation: $explanation, media_type: $mediaType)');
  });

  test('Should not equal another MediaModel with different properties', () {
    final mediaModel1 = MediaModel(
      title: title,
      date: date,
      url: url,
      explanation: explanation,
      mediaType: mediaType,
    );
    final mediaModel2 = MediaModel(
      title: 'My Other Title',
      date: date,
      url: url,
      explanation: explanation,
      mediaType: mediaType,
    );

    final isEqual = mediaModel1 == mediaModel2;

    expect(isEqual, false);
  });
}
