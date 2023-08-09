import 'package:flutter/material.dart';
import 'package:flutter_arch/app_routes.dart';
import 'package:flutter_arch/modules/movie/data/movie_list.dart';
import 'package:flutter_arch/modules/movie/data/movie_list_model.dart';
import 'package:flutter_arch/modules/widget/expandable_text.dart';
import 'package:flutter_arch/modules/widget/overscroll_behavior.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class MovieListScreen extends StatelessWidget {
  const MovieListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ChangeNotifierProvider(
          create: (BuildContext context) => MovieListModel(),
          lazy: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _getMovieListTitle(context),
              _MovieTypeTabRow(
                onMovieTypeChanged: (bool movieShowing) {},
              ),
              const Divider(thickness: 1.0, height: 1.0),
              const _MovieSortTab(),
              const Expanded(child: _MovieList()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getMovieListTitle(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      title: Center(
        child: Text(
          AppLocalizations.of(context)!.title_movie_screen,
          style: const TextStyle(color: Colors.black, fontSize: 18.0),
        ),
      ),
    );
  }
}

class _MovieTypeTabRow extends StatefulWidget {
  const _MovieTypeTabRow({Key? key, required this.onMovieTypeChanged})
      : super(key: key);
  final ValueChanged<bool> onMovieTypeChanged;

  @override
  State<_MovieTypeTabRow> createState() => _MovieTypeTabRowState();
}

class _MovieTypeTabRowState extends State<_MovieTypeTabRow> {
  static const _movieTypeLabels = ["影院热映", "豆瓣热门"];
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _getTabBar(context),
        ),
        const Spacer(),
      ],
    );
  }

  Widget _getTabBar(BuildContext context) {
    return DefaultTabController(
      length: _movieTypeLabels.length,
      child: TabBar(
        labelColor: const Color(0xFF4C4C4C),
        unselectedLabelColor: const Color(0xFF828282),
        indicatorColor: Colors.black,
        indicatorPadding: const EdgeInsets.only(left: 10.0, right: 10.0),
        indicatorSize: TabBarIndicatorSize.label,
        tabs: [
          for (var movieType in _movieTypeLabels)
            Tab(height: 36.0, text: movieType)
        ],
        onTap: (int index) {
          if (_currentIndex != index) {
            _currentIndex = index;
            var showingMovie = index == 0;
            debugPrint("是否影院热映=$showingMovie");
            context.read<MovieListModel>().movieTypeChange(showingMovie);
          }
        },
      ),
    );
  }
}

class _MovieSortTab extends StatefulWidget {
  const _MovieSortTab({Key? key}) : super(key: key);

  @override
  State<_MovieSortTab> createState() => _MovieSortTabState();
}

enum MovieSort { recommend, time, rank }

class _MovieSortTabState extends State<_MovieSortTab> {
  final movieSortList = const ["热度", "最新", "评分"];
  final movieSortArgs = const [
    MovieSort.recommend,
    MovieSort.time,
    MovieSort.rank
  ];
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Container(
              decoration: const BoxDecoration(
                  color: Color(0xFFF7F7F7),
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: _buildTabBar(context),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTabBar(BuildContext context) {
    return DefaultTabController(
      length: movieSortList.length,
      child: TabBar(
        labelColor: const Color(0xFF353535),
        unselectedLabelColor: const Color(0xFF828282),
        indicator: BoxDecoration(
          backgroundBlendMode: BlendMode.src,
          border: Border.all(
            color: const Color(0xFFF7F7F7),
            width: 1.2,
          ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        tabs: movieSortList.map((name) => _buildTabView(name)).toList(),
        onTap: (int index) {
          if (index != _currentIndex) {
            var movieSort = movieSortArgs[index];
            debugPrint("排序选项=$index,参数=${movieSort.name}");
            context.read<MovieListModel>().movieSortChange(movieSort);
            setState(() {
              _currentIndex = index;
            });
          }
        },
      ),
    );
  }

  Widget _buildTabView(String name) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Text(
        name,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 14),
      ),
    );
  }
}

class _MovieList extends StatefulWidget {
  const _MovieList({Key? key}) : super(key: key);

  @override
  State<_MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<_MovieList> {
  late ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    var movieListModel = context.watch<MovieListModel>();
    if (movieListModel.needScrollTop) {
      Future.delayed(const Duration(milliseconds: 500), () {
        _controller.jumpTo(0);
        // _controller.animateTo(0,
        //     duration: const Duration(milliseconds: 200), curve: Curves.ease);
      });
    }
    return ScrollConfiguration(
      behavior: OverScrollBehavior(),
      child: SmartRefresher(
        controller: movieListModel.refreshController,
        enablePullUp: true,
        onRefresh: movieListModel.onRefresh,
        onLoading: movieListModel.onLoading,
        child: ListView.builder(
          controller: _controller,
          itemCount: movieListModel.movieList.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRouter.movieDetail,
                  arguments: movieListModel.movieList[index].id,
                );
              },
              child: _MovieItem(
                // key: Key(movieListModel.movieList[index].id),
                item: movieListModel.movieList[index],
                hasLine: index < movieListModel.movieList.length,
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _MovieItem extends StatelessWidget {
  const _MovieItem({Key? key, required this.item, required this.hasLine})
      : super(key: key);
  final bool hasLine;
  final MovieItem item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (item.honorInfos.isNotEmpty) _buildMovieHonor(item.honorInfos),
          _buildMovieImage(item.pic?.normal ?? "", item.photos),
          _buildMovieTitle(item.title, item.year),
          _buildMovieRating(context,item.rating),
          _buildMovieSubTitle(item.cardSubtitle),
          _buildMovieIntro(context,item.comment),
          if (hasLine) const Divider(height: 1),
        ],
      ),
    );
  }

  Widget _buildMovieHonor(List<HonorInfo> honorInfos) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
          color: const Color(0xFFFFF6E7),
          borderRadius: BorderRadius.circular(4)),
      child: Text(
        "${honorInfos[0].title} >",
        style: const TextStyle(color: Color(0xFFA9731B), fontSize: 14),
      ),
    );
  }

  Widget _buildMovieImage(String picUrl, List<String> photos) {
    return Row(
      children: [
        Expanded(
          flex: 38,
          child: AspectRatio(
            aspectRatio: 1.9 / 2.65,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                picUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        Expanded(
          flex: 89,
          child: AspectRatio(
            aspectRatio: 4.45 / 2.65,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return Image.network(
                    photos[index],
                    fit: BoxFit.cover,
                  );
                },
                itemCount: photos.length,
                pagination: const SwiperPagination(
                    margin: EdgeInsets.only(bottom: 6),
                    builder: DotSwiperPaginationBuilder(
                      activeColor: Colors.white,
                      size: 6,
                      activeSize: 6,
                      color: Color(0x61FFFFFF),
                    )),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMovieTitle(String title, String year) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Text(
        "$title（$year）",
        style: const TextStyle(fontSize: 20),
      ),
    );
  }

  Widget _buildMovieRating(BuildContext context,Rating? rating) {
    if (rating != null) {
      return Row(
        children: [
          RatingBar.builder(
            initialRating: rating.starCount,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            unratedColor: const Color(0xFFDBE2DB),
            itemCount: 5,
            itemSize: 14,
            ignoreGestures: true,
            itemPadding: const EdgeInsets.symmetric(horizontal: 1),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Color(0xFFF89216),
            ),
            onRatingUpdate: (rating) {},
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Text(
              rating.value.toString(),
              style: const TextStyle(color: Color(0xFFF89216)),
            ),
          ),
        ],
      );
    } else {
      return Text(
        AppLocalizations.of(context)!.label_no_rating,
        style: const TextStyle(color: Color(0xFF949494), fontSize: 10),
      );
    }
  }

  Widget _buildMovieSubTitle(String subTitle) {
    return Text(
      subTitle,
      style: const TextStyle(color: Color(0xFF949494), fontSize: 10),
    );
  }

  Widget _buildMovieIntro(BuildContext context,String intro) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: ExpandableText(
        intro,
        style: const TextStyle(
          color: Color(0xFF505050),
          fontSize: 14,
          letterSpacing: 0.5,
        ),
        linkColor: const Color(0xFF949494),
        expandText: AppLocalizations.of(context)!.label_expand,
        onlyExpand: true,
      ),
    );
  }
}
