import 'package:dio/dio.dart';
import 'package:flutter_arch/modules/movie/data/movie_detail.dart';
import 'package:flutter_arch/modules/movie/data/movie_list.dart';
import 'package:retrofit/retrofit.dart';

import '../network/dio_initializer.dart';

part 'fresco_api.g.dart';

abstract class Fresco {
  static const apiKey = "0dad551ec0f84ed02907ff5c42e8ec70";
  static const userAgent =
      "Rexxar-Core/0.1.3 api-client/1 com.douban.frodo/7.27.0.beta(231) Android/29 product/capricorn vendor/Xiaomi model/MI 10 pro brand/Xiaomi  rom/miui6  network/wifi  udid/83d1a9c5774cbb6ad5290121cc35e89cae25569c  platform/mobile com.douban.frodo/7.27.0.beta(231) Rexxar/1.2.151  platform/mobile 1.2.151";
  static const baseUrl = "https://frodo.douban.com/";
}

final frescoApi = FrescoApi(dio);

@RestApi(baseUrl: Fresco.baseUrl)
abstract class FrescoApi {
  factory FrescoApi(Dio dio, {String baseUrl}) = _FrescoApi;

  @GET("api/v2/movie/movie_showing")
  Future<MoviePagingEntity> fetchShowingMovieList(
      {@Query("start") required int start,
      @Query("count") int count = 20,
      @Query("loc_id") int locId = 118201, // 厦门
      @Query("playable") int playable = 0,
      @Query("area") String area = "全部",
      @Query("sort") String sort = "recommend"});

  @GET("api/v2/movie/hot_gaia")
  Future<MoviePagingEntity> fetchHotMovieList(
      {@Query("start") required int start,
      @Query("count") int count = 20,
      @Query("playable") int playable = 0,
      @Query("area") String area = "全部",
      @Query("sort") String sort = "recommend"});

  @GET("api/v2/movie/{movie_id}")
  Future<MovieDetail> fetchMovieDetail(@Path("movie_id") String movieId,
      {@Query("event_source") String eventSource = "movie_showing"});

  @GET("api/v2/movie/{movie_id}/celebrities")
  Future<MovieCredits> fetchMovieCredits(@Path("movie_id") String movieId,
      {@Query("os_rom") String osRom = "miui13",
      @Query("channel") String channel = "Douban",
      @Query("timezone") String timezone = "Asia/Shanghai"});

  @GET("api/v2/movie/{movie_id}/photos")
  Future<MoviePhotos> fetchMoviePhotos(@Path("movie_id") String movieId,
      {@Query("count") int count = 8,
      @Query("os_rom") String osRom = "miui13",
      @Query("channel") String channel = "Douban",
      @Query("timezone") String timezone = "Asia/Shanghai"});

  @GET("api/v2/movie/{movie_id}/related_items")
  Future<RelatedItems> fetchRelatedItems(@Path("movie_id") String movieId,
      {@Query("count") int count = 10,
      @Query("os_rom") String osRom = "miui13",
      @Query("channel") String channel = "Douban",
      @Query("timezone") String timezone = "Asia/Shanghai"});
}
