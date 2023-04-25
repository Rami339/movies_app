import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:movie_app/core/network/api_constance.dart';
import 'package:movie_app/core/utils/app_constance.dart';
import 'package:movie_app/core/utils/colors_app.dart';
import 'package:movie_app/core/utils/components.dart';
import 'package:movie_app/movies/presentation/controller/movies_bloc.dart';
import 'package:movie_app/movies/presentation/controller/movies_state.dart';

Widget defaultSeeMore({
  required BuildContext context,
  required String text,
  required Widget screen,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(
      horizontal: 6.0,
    ),
    child: Row(
      children: [
        defaultText(
            text: text,
            fontWeight: FontWeight.w500,
            fontSize: fontSizeDefaultSeeMore,
            color: whiteColor),
        const Spacer(),
        Row(
          children: [
            defaultTextButton(
              function: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => screen));
              },
              widget: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  defaultText(
                    text: 'See More',
                    fontWeight: FontWeight.w500,
                    fontSize: fontSizeNowPlaying,
                    color: whiteColor,
                  ),
                  defaultIcon(
                    icon: Icons.keyboard_arrow_right,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget defaultLoading() {
  return Lottie.asset(
    loadingImage,
    width: 150,
    height: 200,
  );
}

Widget buildMovie({
  required String pathImage,
  required String name,
  required String title,
  required String releaseDate,
  required dynamic voteAverage,
}) {
  return BlocBuilder<MoviesBloc, MoviesState>(
    builder: (context, state) {
      return Container(
        height: 170,
        width: 100,
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
        decoration: BoxDecoration(
            color: defaultColor,
            borderRadius: BorderRadius.circular(defaultBorder)),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              width: 105,
              height: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  defaultBorder,
                ),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: ApiConstance.image(pathImage),
                  fadeInDuration: const Duration(microseconds: durationImage),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    defaultText(
                      text: name,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      color: whiteColor,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 65,
                          height: 30,
                          decoration: BoxDecoration(
                            color: redColor,
                            borderRadius: BorderRadius.circular(
                              5,
                            ),
                          ),
                          child: Center(
                            child: defaultText(
                              text: releaseDate.split('-')[0],
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
                          text: voteAverage.toStringAsFixed(1),
                          fontWeight: FontWeight.normal,
                          fontSize: 18,
                          color: whiteColor,
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    defaultText(
                      text: title,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      color: whiteColor,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

PreferredSize buildAppbarMovie({
  required String title,
  required BuildContext context,
}) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(75.0),
    child: ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 10.0,
          sigmaY: 10.0,
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              centerTitle: true,
            ),
            Row(
              children: [
                defaultBackButton(function: () {
                  removeScreen(context);
                }),
                const SizedBox(
                  width: 45,
                ),
                defaultText(
                    text: title,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: whiteColor),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

Widget buildListMovies({
  required String? pathImage,

}) {
  return BlocBuilder<MoviesBloc,MoviesState>(
    builder: (context, state) {
      return Container(
        width: 145,
        height: 150,
        margin: const EdgeInsets.symmetric(
          horizontal: marginSeeMore,
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(
              circularSeeMore,
            ),
          ),
          child: CachedNetworkImage(
            fadeInDuration: const Duration(
              milliseconds: durationImage,
            ),
            imageUrl: pathImage == null
                ? failureDownloadImage
                : ApiConstance.image(pathImage),
            fit: BoxFit.cover,
          ),
        ),
      );
    },
  );
}
