import 'package:dio/dio.dart';
import 'package:nasa_explorer_app/src/core/constants/environment_config.dart';
import 'package:nasa_explorer_app/src/core/infra/cache_storage/adapter/cache_storage_adapter.dart';
import 'package:nasa_explorer_app/src/core/infra/cache_storage/client/cache_storage_client.dart';
import 'package:nasa_explorer_app/src/core/infra/http/adapter/dio_adapter.dart';
import 'package:nasa_explorer_app/src/core/infra/http/client/http_client.dart';
import 'package:nasa_explorer_app/src/features/astronomy_pictures/data/repositories/media_repository_impl.dart';
import 'package:nasa_explorer_app/src/features/astronomy_pictures/domain/repositories/media_repository.dart';
import 'package:nasa_explorer_app/src/features/astronomy_pictures/presentation/presenters/page_presenter.dart';

import '../core/injection/dependency_injection.dart';
import '../features/astronomy_pictures/data/datasources/cache/cache_media_pictures_datasource_impl.dart';
import '../features/astronomy_pictures/data/datasources/datasources.dart';
import '../features/astronomy_pictures/data/datasources/external_api/external_api_media_pictures_datasource_impl.dart';
import '../features/astronomy_pictures/domain/usecases/get_media_pictures_list_usecase.dart';
import '../features/astronomy_pictures/domain/usecases/save_media_pictures_list_usecase.dart';

class AppDependencyInjection extends DependencyInjection {
  Future<void> setup() async {
    /// infra
    register<CacheStorageClient>(CacheStorageAdapter());
    register<HttpClient>(DioAdapter(dio: Dio()));

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
