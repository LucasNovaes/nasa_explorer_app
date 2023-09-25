import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_explorer_app/src/features/astronomy_pictures/data/repositories/media_repository_impl.dart';
import 'package:nasa_explorer_app/src/features/astronomy_pictures/domain/entities/media_entity.dart';
import 'package:nasa_explorer_app/src/features/astronomy_pictures/data/datasources/datasources.dart';
import 'package:nasa_explorer_app/src/features/astronomy_pictures/utils/check_connectivity.dart';

import '../../../../mocks/entities/mock_media_entity.dart';
import '../../../../mocks/http/mock_http_client.dart';

class MockCacheMediaPicturesDatasource extends Mock
    implements CacheMediaPicturesDatasource {
  void mockCall(List<MediaEntity> response) async {
    when(() => getMediaPicturesList()).thenAnswer((_) async => response);
  }
}

class MockInternetAddress extends Mock implements InternetAddress {}

class MockExternalApiMediaPicturesDatasource extends Mock
    implements ExternalApiMediaPicturesDatasource {
  void mockCall(List<MediaEntity> response) async {
    when(() => getMediaPicturesList()).thenAnswer((_) async => response);
  }
}

void main() {
  late MediaEntity mockMediaEntity;
  // late List<String> listEncode;
  late CacheMediaPicturesDatasource mockCacheDataSource;
  late ExternalApiMediaPicturesDatasource mockExternalApiDataSource;
  late MediaRepositoryImpl repository;
  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    mockCacheDataSource = MockCacheMediaPicturesDatasource();
    mockExternalApiDataSource = MockExternalApiMediaPicturesDatasource();
    repository = MediaRepositoryImpl(
      cacheMediaPicturesDatasources: mockCacheDataSource,
      externalApiMediaPicturesDatasources: mockExternalApiDataSource,
    );
    mockMediaEntity = MockMediaEntity.makeEntity();
    // listEncode =
    //     [mockMediaEntity].map((media) => jsonEncode(media.toMap())).toList();
  });
  test(
      'getMediaPicturesList should return data from external API when connected',
      () async {
    final list = [mockMediaEntity];
    when(() => mockExternalApiDataSource.getMediaPicturesList())
        .thenAnswer((_) => Future.value(list));

    await repository.getMediaPicturesList();
  });

  // test('getMediaPicturesList should return data from cache when not connected',
  //     () {
  //   // Simular que não está conectado à internet

  //   // Simular a resposta do cache

  //   when(() => checkConnectivity()).thenAnswer((invocation) async => true);
  //   // final list = [mockMediaEntity];
  //   // when(() => mockCacheDataSource.getMediaPicturesList())
  //   //     .thenAnswer((_) async => list);

  //   // Executar a função a ser testada
  //   // final result = await repository.getMediaPicturesList();
  // });

  // test('saveMediaPicturesList should call cache data source', () async {
  //   // Configurar os mocks
  //   final cacheDataSource = MockCacheMediaPicturesDatasource();
  //   final externalApiDataSource = MockExternalApiMediaPicturesDatasource();
  //   final repository = MediaRepositoryImpl(
  //     cacheMediaPicturesDatasources: cacheDataSource,
  //     externalApiMediaPicturesDatasources: externalApiDataSource,
  //   );

  //   // Dados de teste
  //   final dataToSave = [
  //     mockMediaEntity,
  //     mockMediaEntity,
  //   ];

  //   // Executar a função a ser testada
  //   await repository.saveMediaPicturesList(listData: dataToSave);

  //   // Verificar que a função do cache foi chamada com os dados corretos
  //   verify(() => cacheDataSource.saveMediaPicturesList(listData: dataToSave))
  //       .called(1);

  //   // Verificar que a função da API externa não foi chamada
  //   verifyNever(() => externalApiDataSource.getMediaPicturesList());
  // });
}
