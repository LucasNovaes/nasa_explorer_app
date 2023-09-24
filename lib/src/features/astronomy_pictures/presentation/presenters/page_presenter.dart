import 'package:flutter/material.dart';
import 'package:nasa_explorer_app/src/features/astronomy_pictures/presentation/states/page_state.dart';

import '../../domain/entities/media_entity.dart';
import '../../domain/usecases/get_media_pictures_list_usecase.dart';
import '../../domain/usecases/save_media_pictures_list_usecase.dart';

class PagePresenter {
  final GetMediaPicturesListUsecase getMediaPicturesListUsecase;
  final SaveMediaPicturesListUsecase saveMediaPicturesListUsecase;

  PagePresenter({
    required this.getMediaPicturesListUsecase,
    required this.saveMediaPicturesListUsecase,
  });

  late ValueNotifier<PageState> pageState;
  late ValueNotifier<List<MediaEntity>> mediaList;
  late ValueNotifier<MediaEntity?> mediaNotifier;
  List<MediaEntity> filteredMediaList = [];

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
      await saveMediaPicturesListUsecase(list: mediaList.value);
      pageState.value = PageStateSuccess();
    } catch (e) {
      pageState.value = PageStateError(
          description:
              "Ocorreu um erro ao carregar as imagens. Tente novamente");
      rethrow;
    }
  }

  Future<void> search(String value) async {
    final filteredList = mediaList.value.where((element) {
      return element.date.contains(value) ||
          element.title.toLowerCase().contains(value.toLowerCase());
    }).toList();
    filteredMediaList = filteredList;
  }
}
