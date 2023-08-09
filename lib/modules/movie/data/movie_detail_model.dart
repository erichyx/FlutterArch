import 'package:flutter/material.dart';
import 'package:flutter_arch/modules/movie/data/movie_detail.dart';
import 'package:flutter_arch/modules/movie/data/movie_repo.dart';

class MovieDetailModel extends ChangeNotifier {
  MovieDetail? _movieDetail;

  MovieDetail? get movieDetail => _movieDetail;

  MovieCredits? _movieCredits;

  MovieCredits? get movieCredits => _movieCredits;

  MoviePhotos? _moviePhotos;

  MoviePhotos? get moviePhotos => _moviePhotos;

  RelatedItems? _relatedItems;

  RelatedItems? get relatedItems => _relatedItems;

  final _movieRepo = MovieRepo();
  final String _movieId;

  MovieDetailModel(this._movieId) {
    fetchMovieDetailInfo();
  }

  void fetchMovieDetailInfo() async {
    // 由于要先拿到detail数据，所以先等这个接口完成，之后需要更新页面整体背景色
    await _movieRepo.fetchMovieDetail(_movieId).then((value) {
      _movieDetail = value;
      // 这里不需要调用notifyListeners，否则会有‘演职员’那块布局会被调用2次，造成内容跳动
      // notifyListeners();
    });

    var movieCreditsFuture = _movieRepo
        .fetchMovieCredits(_movieId)
        .then((value) => _movieCredits = value);

    var moviePhotosFuture = _movieRepo
        .fetchMoviePhotos(_movieId)
        .then((value) => _moviePhotos = value);

    var movieRelatedItemsFuture = _movieRepo
        .fetchRelatedItems(_movieId)
        .then((value) => _relatedItems = value);

    await Future.wait([movieCreditsFuture, moviePhotosFuture, movieRelatedItemsFuture]);
    notifyListeners();
  }
}
