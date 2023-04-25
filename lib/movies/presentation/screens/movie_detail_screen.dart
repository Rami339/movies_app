import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/network/api_constance.dart';
import 'package:movie_app/core/services/services_locator.dart';
import 'package:movie_app/core/utils/app_constance.dart';
import 'package:movie_app/core/utils/colors_app.dart';
import 'package:movie_app/core/utils/components.dart';
import 'package:movie_app/core/utils/request_state.dart';
import 'package:movie_app/core/utils/ui_components.dart';
import 'package:movie_app/movies/domain/entities/genres_entities.dart';
import 'package:movie_app/movies/presentation/controller/movie_details_bloc.dart';
import 'package:movie_app/movies/presentation/controller/movie_details_event.dart';
import 'package:movie_app/movies/presentation/controller/movie_details_state.dart';

class MovieDetailsScreen extends StatelessWidget {
  final int id;

  const MovieDetailsScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<MovieDetailsBloc>()
        ..add(GetMovieDetailsEvent(id))
        ..add(GetRecommendationMovieEvent(id)),
      child: BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
        builder: (context, state) {
          switch (state.detailsState) {
            case RequestState.loading:
              return Scaffold(
                backgroundColor: anotherGeryDarkColor,
                body: Center(
                  child: defaultLoading(),
                ),
              );
            case RequestState.loaded:
              return Scaffold(
                backgroundColor: const Color(0xff1E1E29),
                body: Stack(
                  children: [
                    CustomScrollView(
                      physics: const BouncingScrollPhysics(
                        decelerationRate: ScrollDecelerationRate.fast,
                      ),
                      slivers: <Widget>[
                        _buildSliverAppBar(context),
                        _buildDetailsMovie(),
                        _buildRecommendationMovie(),
                      ],
                    ),
                    Positioned(
                      top: 40,
                      left: 1,
                      child: defaultBackButton(
                        function: () {
                          removeScreen(context);
                        },
                      ),
                    ),
                  ],
                ),
              );
            case RequestState.error:
              return Container();
          }
        },
      ),
    );
  }
}

Widget _buildRecommendationMovie() {
  return BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
    builder: (context, state) {
      return SliverPadding(
        padding: const EdgeInsets.only(right: 3.5, left: 3.5),
        sliver: SliverGrid.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.7,
              crossAxisSpacing: 0.9,
              mainAxisSpacing: 0.8,
            ),
            itemCount: state.recommendationsModel.length,
            itemBuilder: (context, index) {
              final recommendation = state.recommendationsModel[index];
              return Container(
                margin: const EdgeInsets.all(2),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(5)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: CachedNetworkImage(
                    imageUrl: recommendation.backDropPath == null
                        ? failureDownloadImage
                        : ApiConstance.image(recommendation.backDropPath!),
                    fadeInDuration: const Duration(
                      milliseconds: 550,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }),
      );
    },
  );
}

Widget _buildDetailsMovie() {
  return BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
    builder: (context, state) {
      return SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              defaultText(
                text: state.detailsModel!.title,
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: whiteColor,
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Container(
                    width: 65,
                    height: 30,
                    decoration: BoxDecoration(
                      color: grayDarkColor,
                      borderRadius: BorderRadius.circular(
                        5,
                      ),
                    ),
                    child: Center(
                      child: defaultText(
                        text: state.detailsModel!.releaseDate.split('-')[0],
                        fontWeight: FontWeight.w400,
                        fontSize: 22,
                        color: whiteColor,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  defaultIcon(
                    icon: Icons.star,
                    size: 25,
                    color: Colors.yellow,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  defaultText(
                    text: state.detailsModel!.voteAverage.toStringAsFixed(1),
                    fontWeight: FontWeight.normal,
                    fontSize: 18,
                    color: whiteColor,
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  defaultText(
                    text: _showDuration(state.detailsModel!.runTime),
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    color: greyColor,
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              defaultText(
                text: state.detailsModel!.overView,
                fontWeight: FontWeight.w400,
                fontSize: 15,
                color: whiteColor,
              ),
              const SizedBox(height: 10),
              defaultText(
                text: 'Genres: ${_showGenres(state.detailsModel!.genres)}',
                fontWeight: FontWeight.w400,
                fontSize: 13,
                color: greyColor,
              ),
              const SizedBox(
                height: 35,
              ),
              state.recommendationsModel.isEmpty
                  ? defaultText(
                      text: 'There Is No More Like This',
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      color: whiteColor,
                    )
                  : defaultText(
                      text: 'MORE LIKE THIS',
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      color: whiteColor,
                    ),
              const SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      );
    },
  );
}

String _showGenres(List<GenresEntities> genres) {
  String result = '';
  for (var genre in genres) {
    result += '${genre.name}, ';
  }

  if (result.isEmpty) {
    return result;
  }

  return result.substring(0, result.length - 2);
}

String _showDuration(dynamic runtime) {
  final int hours = runtime ~/ 60;
  final int minutes = runtime % 60;

  if (hours > 0) {
    return '${hours}h  ${minutes.toString().padLeft(2, '0')}m';
  } else {
    return '${minutes.toString().padLeft(2, '0')}m';
  }
}

Widget _buildSliverAppBar(BuildContext context) {
  return BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
    builder: (context, state) {
      return SliverAppBar(
        automaticallyImplyLeading: false,
        pinned: true,
        toolbarHeight: 65,
        expandedHeight: 250,
        stretch: true,
        backgroundColor: const Color(
          0xff1E1E29,
        ).withOpacity(0.10),
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaY: 10,
              sigmaX: 10,
            ),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: FlexibleSpaceBar(
                stretchModes: const [
                  StretchMode.blurBackground,
                  StretchMode.zoomBackground,
                ],
                background: ShaderMask(
                  blendMode: BlendMode.srcOver,
                  shaderCallback: (rect) {
                    return LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.8),
                          Colors.black.withOpacity(0.5),
                          // Colors.red,
                          Colors.transparent,
                        ]).createShader(const Rect.fromLTRB(0, 35, 0, 140));
                  },
                  child: CachedNetworkImage(
                    fadeInDuration: const Duration(milliseconds: 550),
                    imageUrl:
                        ApiConstance.image(state.detailsModel!.backDropPath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
