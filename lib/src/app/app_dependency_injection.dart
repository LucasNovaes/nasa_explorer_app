import 'package:dio/dio.dart';

import '../core/core.dart';
import '../features/astronomy_pictures/data/data.dart';
import '../features/astronomy_pictures/domain/domain.dart';
import '../features/astronomy_pictures/presentation/presentation.dart';

class AppDependencyInjection extends DependencyInjection {
  Future<void> setup() async {
    /// infra
    register<CacheStorageClient>(CacheStorageAdapter());
    register<HttpClient>(
        DioAdapter(dio: Dio(), interceptors: [CustomInterceptor()]));

    /// data
    register<CacheMediaPicturesDatasource>(CacheMediaPicturesDatasourceImpl(
        cacheStorage: get<CacheStorageClient>()));
    register<ExternalApiMediaPicturesDatasource>(
        ExternalApiMediaPicturesDatasourceImpl(
            httpClient: get<HttpClient>(), baseUrl: EnvironmentConfig.baseUrl));

    /// repository
    register<MediaRepository>(MediaRepositoryImpl(
      cacheMediaPicturesDatasources: get<CacheMediaPicturesDatasource>(),
      externalApiMediaPicturesDatasources:
          get<ExternalApiMediaPicturesDatasource>(),
    ));

    /// usecase
    register<GetMediaPicturesListUsecase>(GetMediaPicturesListUsecase(
      repository: get<MediaRepository>(),
    ));
    register<SaveMediaPicturesListUsecase>(SaveMediaPicturesListUsecase(
      repository: get<MediaRepository>(),
    ));

    /// presenter
    register<PagePresenter>(PagePresenter(
      getMediaPicturesListUsecase: get<GetMediaPicturesListUsecase>(),
      saveMediaPicturesListUsecase: get<SaveMediaPicturesListUsecase>(),
    ));
  }
}
