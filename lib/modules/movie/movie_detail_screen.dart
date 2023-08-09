import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_arch/modules/movie/data/movie_detail.dart';
import 'package:flutter_arch/modules/movie/data/movie_detail_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class MovieDetailScreen extends StatelessWidget {
  const MovieDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var movieId = ModalRoute
        .of(context)!
        .settings
        .arguments as String;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: ChangeNotifierProvider(
          lazy: false,
          create: (BuildContext context) => MovieDetailModel(movieId),
          child: const MovieDetailBody(),
        ),
      ),
    );
  }
}

class MovieDetailBody extends StatelessWidget {
  const MovieDetailBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var movieDetail =
    context.select((MovieDetailModel model) => model.movieDetail);
    if (movieDetail == null) {
      return _buildLoadingWidget();
    }

    var padding = MediaQuery
        .of(context)
        .padding;
    return Container(
      padding: padding,
      color: _getMovieDetailBgColor(movieDetail.headerBgColor),
      child: Column(
        children: [
          _buildTitleBar(context),
          Expanded(
            child: ListView(
              children: [
                _MovieHeader(movieDetail: movieDetail),
                const SizedBox(height: 16),
                _MovieIntro(movieIntro: movieDetail.intro),
                const SizedBox(height: 16),
                const _MovieCredits(),
                const SizedBox(height: 16),
                const _MovieTrailerAndPhotos(),
                const SizedBox(height: 16),
                const _MovieRelatedItems(),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getMovieDetailBgColor(String headerBgColor) {
    var colorVal = int.parse("ff$headerBgColor", radix: 16);
    return Color(colorVal);
  }

  Widget _buildLoadingWidget() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildTitleBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: SizedBox(
        height: 56,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              ),
            ),
            Align(
              child: Text(
                AppLocalizations.of(context)!.title_movie_detail,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MovieHeader extends StatelessWidget {
  const _MovieHeader({Key? key, required this.movieDetail}) : super(key: key);
  final MovieDetail movieDetail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: AspectRatio(
                  aspectRatio: 1.8 / 2.5,
                  child: Image.network(
                    movieDetail.coverUrl,
                    fit: BoxFit.cover,
                  )),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movieDetail.title,
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Text(
                    "${movieDetail.originalTitle} (${movieDetail.year})",
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  if (movieDetail.honorInfos.isNotEmpty) _buildMovieHonorInfo(),
                  _buildMovieBasicInfo(),
                ],
              ))
        ],
      ),
    );
  }

  Widget _buildMovieHonorInfo() {
    var honorInfo = movieDetail.honorInfos[0];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                color: const Color(0xFFFFE6BE),
                child: Text(
                  "No.${honorInfo.rank}",
                  style: const TextStyle(
                    color: Color(0xFF915800),
                    fontSize: 12,
                  ),
                )),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              color: const Color(0xFFFABB5A),
              child: Text(
                "${honorInfo.title} >",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Color(0xFF915800), fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMovieBasicInfo() {
    var desc =
        "${movieDetail.countries[0]} / ${movieDetail.genres.join(
        " ")} / ${movieDetail.pubDate[0]}上映";
    if (movieDetail.durations.isNotEmpty) {
      desc += " / 片长${movieDetail.durations[0]} >";
    } else {
      desc += " >";
    }
    return Text(
      desc,
      style: TextStyle(
        color: Colors.white.withOpacity(0.5),
        fontSize: 12,
      ),
    );
  }
}

class _MovieIntro extends StatelessWidget {
  const _MovieIntro({Key? key, required this.movieIntro}) : super(key: key);
  final String movieIntro;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              AppLocalizations.of(context)!.label_intro,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            movieIntro,
            // 行高=fontSize*height
            strutStyle: const StrutStyle(fontSize: 26, height: 1),
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _MovieCredits extends StatelessWidget {
  const _MovieCredits({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 16),
          child: Text(
            AppLocalizations.of(context)!.label_movie_credits,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Consumer<MovieDetailModel>(
          builder:
              (BuildContext context, MovieDetailModel model, Widget? child) {
            var creditItems = <SimpleCharacterInfo>[];
            if (model.movieCredits != null) {
              creditItems.addAll(model.movieCredits!.directors
                  .map((item) => item.toSimpleCharacterInfo()));
              creditItems.addAll(model.movieCredits!.actors
                  .map((item) => item.toSimpleCharacterInfo()));
            }

            var itemWidth = (MediaQuery
                .of(context)
                .size
                .width - 16 * 5) / 4;
            // 由于Column嵌套横向ListView会出错，网上虽然有用Stack进行处理的方法，但过于复杂,
            // 考虑到项数也不多，故采用Row来实现。
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: [
                const SizedBox(
                  width: 8,
                ),
                for (var creditItem in creditItems)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child:
                    _buildMovieCreditItem(context, itemWidth, creditItem),
                  ),
                const SizedBox(
                  width: 8,
                ),
              ]),
            );
          },
        ),
      ],
    );
  }

  Widget _buildMovieCreditItem(BuildContext context, double itemWidth,
      SimpleCharacterInfo characterInfo) {
    return SizedBox(
      width: itemWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: AspectRatio(
                  aspectRatio: 1.45 / 2,
                  child: Image.network(
                    characterInfo.avatar.normal,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              if (characterInfo.inDouban)
                Container(
                    width: itemWidth * 0.6,
                    margin: const EdgeInsets.only(bottom: 4),
                    color: const Color(0xFFFF9600),
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Text(
                      AppLocalizations.of(context)!.label_in_douban,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white, fontSize: 10),
                    )),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              characterInfo.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          Text(
            characterInfo.character,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style:
            TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _MovieTrailerAndPhotos extends StatelessWidget {
  const _MovieTrailerAndPhotos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 16),
          child: Text(
            AppLocalizations.of(context)!.label_movie_photos,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Consumer<MovieDetailModel>(
          builder:
              (BuildContext context, MovieDetailModel model, Widget? child) {
            var itemWidth = (screenWidth - 16 * 2) * 2 / 3;
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  const SizedBox(width: 16),
                  if (model.movieDetail?.trailer != null)
                    Padding(
                      padding: const EdgeInsets.only(right: 2),
                      child: _buildTrailerItem(
                        context,
                        itemWidth,
                        model.movieDetail!.trailer!,
                      ),
                    ),
                  if (model.moviePhotos?.photos != null)
                    ..._buildBigPhotoItem(
                        itemWidth, model.moviePhotos!.photos!),
                  if (model.moviePhotos?.photos != null)
                    _buildSmallPhotoItem(
                        screenWidth - 16 * 2, model.moviePhotos!.photos!),
                  const SizedBox(width: 16),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildTrailerItem(BuildContext context, double itemWidth,
      Trailer trailer) {
    // 外层的AspectRatio如果不加的话，会导致Stack没有高度，这样会影响到子Widget的Align效果（无法底部对齐）
    return SizedBox(
      width: itemWidth,
      child: AspectRatio(
        aspectRatio: 4.35 / 2.9,
        child: Stack(
          children: [
            AspectRatio(
              aspectRatio: 4.35 / 2.9,
              child: Image.network(
                trailer.coverUrl ?? "",
                fit: BoxFit.cover,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 4, top: 4),
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                  color: const Color(0xFFFF9600),
                  borderRadius: BorderRadius.circular(4)),
              child: Text(
                AppLocalizations.of(context)!.label_trailer,
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
            Align(
              child: Image.asset(
                "images/3.0x/ic_video_large.png",
                width: 80,
                height: 80,
                fit: BoxFit.contain,
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8, right: 16),
                child: Text(
                  trailer.runtime ?? "",
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildBigPhotoItem(double itemWidth, List<Photos> photos) {
    var showPhotoList = photos;
    if (photos.length > 2) {
      showPhotoList = photos.sublist(0, 2);
    }
    final photoWidgets = <Widget>[];
    for (var photo in showPhotoList) {
      var widget = Container(
          width: itemWidth,
          margin: const EdgeInsets.only(right: 2),
          child: AspectRatio(
            aspectRatio: 4.35 / 2.9,
            child: Image.network(
              photo.image?.normal?.url ?? "",
              fit: BoxFit.cover,
            ),
          ));
      photoWidgets.add(widget);
    }
    return photoWidgets;
  }

  Widget _buildSmallPhotoItem(double baseItemWidth, List<Photos> photos) {
    var showPhotoList = photos.sublist(2);
    var gridViewWidth = baseItemWidth;
    var gridViewHeight = baseItemWidth * 2 / 3 * 2.9 / 4.35;

    // GridView的子Widget的宽高是通过childAspectRatio来指定的，直接设置宽高无效！
    return SizedBox(
      width: gridViewWidth,
      height: gridViewHeight,
      child: GridView.count(
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 2,
          crossAxisSpacing: 2,
          childAspectRatio: 2.9 / 4.35,
          children: [
            for (var photo in showPhotoList)
              Image.network(
                photo.image?.normal?.url ?? "",
                fit: BoxFit.cover,
              )
          ]),
    );
  }
}

class _MovieRelatedItems extends StatelessWidget {
  const _MovieRelatedItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 16),
          child: Text(
            AppLocalizations.of(context)!.label_movie_related,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Consumer<MovieDetailModel>(
          builder: (BuildContext context,
              MovieDetailModel model,
              Widget? child,) {
            if (model.relatedItems == null) return const SizedBox(height: 16);

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _buildRelatedItems(context, model.relatedItems!),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  List<Widget> _buildRelatedItems(BuildContext context,
      RelatedItems relatedItems) {
    var itemWidth = (MediaQuery
        .of(context)
        .size
        .width - 16 * 5) / 4;
    final relatedWidgets = <Widget>[];
    for (var i = 0; i < relatedItems.subjects.length; i++) {
      var item = Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            _buildRelatedMovieItem(
              context,
              itemWidth,
              relatedItems.subjects[i],
            ),
            const SizedBox(height: 16),
            if (i < relatedItems.doulists.length)
              _buildRelatedDouItem(
                context,
                itemWidth,
                relatedItems.doulists[i],
              ),
          ],
        ),
      );
      relatedWidgets.add(item);
    }
    return relatedWidgets;
  }

  Widget _buildRelatedMovieItem(BuildContext context, double itemWidth,
      Subject subject) {
    late Widget ratingWidget;
    if (subject.rating != null) {
      ratingWidget = Row(
        children: [
          RatingBar.builder(
            initialRating: subject.rating!.starCount,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            unratedColor: Colors.white.withOpacity(0.5),
            itemCount: 5,
            itemSize: 8,
            ignoreGestures: true,
            itemPadding: const EdgeInsets.symmetric(horizontal: 1),
            itemBuilder: (context, _) =>
            const Icon(
              Icons.star,
              color: Color(0xFFFAAE36),
            ),
            onRatingUpdate: (rating) {},
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Text(
              subject.rating!.value.toString(),
              style: TextStyle(
                color: Colors.white.withOpacity(0.5),
                fontSize: 10,
              ),
            ),
          ),
        ],
      );
    } else {
      ratingWidget = Text(
        AppLocalizations.of(context)!.label_no_rating,
        style: TextStyle(
          color: Colors.white.withOpacity(0.5),
          fontSize: 11,
        ),
      );
    }

    return SizedBox(
      width: itemWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: AspectRatio(
              aspectRatio: 1.42 / 2.2,
              child: Image.network(
                subject.pic?.normal ?? "",
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subject.title ?? "",
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: const TextStyle(color: Colors.white, fontSize: 13),
          ),
          ratingWidget,
        ],
      ),
    );
  }

  Widget _buildRelatedDouItem(BuildContext context, double itemWidth,
      DouList douList) {
    return SizedBox(
      width: itemWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Image.network(
                      douList.coverUrl ?? "",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                if (douList.isOfficial)
                  Positioned(
                    left: 4,
                    top: 4,
                    child: Image.asset(
                      "images/3.0x/ic_dou_official_label_s.png",
                      width: 16,
                      height: 16,
                    ),
                  ),
                if (douList.iconText.isNotEmpty)
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      width: itemWidth / 2,
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      decoration: const BoxDecoration(
                        color: Color(0xA0000000),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'images/3.0x/ic_videos_s.png',
                            color: Colors.white,
                            width: 16,
                            height: 16,
                          ),
                          Text(
                            douList.iconText,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 8),
                          )
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            douList.title ?? "",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            strutStyle: const StrutStyle(fontSize: 20, height: 1),
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                AppLocalizations.of(context)!
                    .fmt_movie_watch_num(douList.doneCount),
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
              Expanded(
                child: Text(
                  "/${douList.itemsCount}",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 12,
                  ),
                ),
              )
            ],
          ),
          Container(
            width: itemWidth / 2,
            margin: const EdgeInsets.only(top: 4),
            decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFFF7F7F7),
                  width: 1.2,
                ),
                borderRadius: BorderRadius.circular(8),
                shape: BoxShape.rectangle),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                width: itemWidth / 2,
                child: LinearProgressIndicator(
                  value: douList.doneCount / douList.itemsCount,
                  minHeight: 8,
                  backgroundColor: Colors.transparent,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
