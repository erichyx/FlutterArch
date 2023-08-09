import 'package:flutter_arch/api/api_call.dart';
import 'package:flutter_arch/api/fresco_api.dart';
import 'package:flutter_arch/modules/movie/data/movie_detail.dart';

import 'movie_list.dart';

class MovieRepo {
  const MovieRepo._internal();

  factory MovieRepo() => const MovieRepo._internal();

  Future<MoviePagingEntity?> fetchMovieList(
      bool showingMovie, String sort, int start) {
    return safeApiCall(() => showingMovie
        ? frescoApi.fetchShowingMovieList(start: start, sort: sort)
        : frescoApi.fetchHotMovieList(start: start, sort: sort));
  }

  Future<MovieDetail?> fetchMovieDetail(String movieId,
      {String eventSource = "movie_showing"}) {
    return safeApiCall(
      () => frescoApi.fetchMovieDetail(movieId, eventSource: eventSource),
    );
  }

  Future<MovieCredits?> fetchMovieCredits(String movieId) {
    return safeApiCall(() => frescoApi.fetchMovieCredits(movieId));
  }

  Future<MoviePhotos?> fetchMoviePhotos(String movieId) {
    return safeApiCall(() => frescoApi.fetchMoviePhotos(movieId));
  }

  Future<RelatedItems?> fetchRelatedItems(String movieId) {
    return safeApiCall(() => frescoApi.fetchRelatedItems(movieId));
  }
}
