abstract class PageState {}

class PageStateInitial extends PageState {
  PageStateInitial();
}

class PageStateSuccess extends PageState {
  PageStateSuccess();
}

class PageStateLoading extends PageState {
  PageStateLoading();
}

class PageStateError extends PageState {
  final String description;
  PageStateError({required this.description});
}
