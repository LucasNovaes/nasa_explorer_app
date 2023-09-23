import 'package:get_it/get_it.dart';

class DependencyInjection {
  final GetIt _getIt = GetIt.instance;

  void register<T extends Object>(T dependency) =>
      _getIt.registerLazySingleton<T>(() => dependency);

  T get<T>() => _getIt<T>();
}
