import 'package:flutter/foundation.dart';
import 'package:nasa_explorer_app/src/features/astronomy_pictures/domain/usecases/get_media_pictures_list_usecase.dart';
import 'package:nasa_explorer_app/src/features/astronomy_pictures/presentation/states/page_state.dart';

import '../../domain/entities/media_entity.dart';

class PagePresenter {
  final GetMediaPicturesListUsecase getMediaPicturesListUsecase;

  PagePresenter({
    required this.getMediaPicturesListUsecase,
  });

  late ValueNotifier<PageState> pageState;
  late ValueNotifier<List<MediaEntity>> mediaList;
  late ValueNotifier<MediaEntity?> mediaNotifier;

  void init() {
    pageState = ValueNotifier(PageStateInitial());
    mediaList = ValueNotifier([]);
    mediaNotifier = ValueNotifier(null);
  }

  void setMedia(MediaEntity media) {
    mediaNotifier.value = media;
  }

  Future<void> getMediaList() async {
    try {
      pageState.value = PageStateLoading();
      mediaList.value = await getMediaPicturesListUsecase();
      pageState.value = PageStateSuccess();
    } catch (e) {
      pageState.value = PageStateError(
          description:
              "Ocorreu um erro ao carregar as imagens. Tente novamente");
      rethrow;
    }
  }
}
