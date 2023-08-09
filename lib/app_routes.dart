import 'package:flutter/material.dart';
import 'package:flutter_arch/modules/movie/movie_detail_screen.dart';

abstract class AppRouter {
  static const String movieDetail = '/movie/detail';
}

Map<String, WidgetBuilder> getAppRoutes() {
  return {
    AppRouter.movieDetail: (context) => const MovieDetailScreen()
  };
}
