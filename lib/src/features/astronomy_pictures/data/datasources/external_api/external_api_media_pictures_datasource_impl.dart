import 'package:nasa_explorer_app/src/features/astronomy_pictures/data/models/media_model.dart';
import 'package:nasa_explorer_app/src/features/astronomy_pictures/domain/entities/media_entity.dart';

import '../../../../../core/core.dart' show HttpClient, Failure;
import '../../../../../core/failure/failure_type.dart';
import 'external_api_media_pictures_datasource.dart';

class ExternalApiMediaPicturesDatasourceImpl
    implements ExternalApiMediaPicturesDatasource {
  final HttpClient httpClient;
  final String baseUrl;

  const ExternalApiMediaPicturesDatasourceImpl({
    required this.httpClient,
    required this.baseUrl,
  });

  @override
  Future<List<MediaEntity>> getMediaPicturesList() async {
    try {
      final response = await httpClient.request(
        method: "get",
        url: baseUrl,
        queryParameters: {"count": "10"},
      );

      final data = response.data;

      if (data.isNotEmpty) {
        return data.map((e) => MediaModel.fromMap(e).toEntity()).toList();
      } else {
        throw const Failure("getMediaPicturesList return is NULL",
            type: FailureType.emptyData);
      }
    } catch (_) {
      rethrow;
    }
  }
}
