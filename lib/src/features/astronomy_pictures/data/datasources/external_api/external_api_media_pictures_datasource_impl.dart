import 'package:nasa_explorer_app/src/features/astronomy_pictures/data/models/media_model.dart';
import 'package:nasa_explorer_app/src/features/astronomy_pictures/domain/entities/media_entity.dart';

import '../../../../../core/core.dart';
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
      final List response = await httpClient.request(
        method: "get",
        url: "$baseUrl/planetary/apod",
        queryParameters: {"count": "10"},
      );

      if (response.isNotEmpty) {
        final result =
            response.map((e) => MediaModel.fromMap(e).toEntity()).toList();
        return result;
      } else {
        throw const Failure("getMediaPicturesList return is NULL",
            type: FailureType.emptyData);
      }
    } catch (_) {
      rethrow;
    }
  }
}
