import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:movie_app/core/network/api_constance.dart';
import 'package:movie_app/core/utils/colors_app.dart';
import 'package:movie_app/core/utils/app_constance.dart';
import 'package:movie_app/core/utils/components.dart';
import 'package:movie_app/core/utils/request_state.dart';
import 'package:movie_app/movies/presentation/controller/movies_bloc.dart';
import 'package:movie_app/movies/presentation/controller/movies_state.dart';
import 'package:movie_app/movies/presentation/screens/movie_detail_screen.dart';

class GetNoPlayingMoviesComponents extends StatelessWidget {
  const GetNoPlayingMoviesComponents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesBloc, MoviesState>(
      buildWhen: (previous, current) =>
          previous.nowPlayingState != current.nowPlayingState,
      builder: (context, state) {
        print('Builder  GetNowPlayingMMovies');
        print('sate ()=> ${state.nowPlayingState}');
        return AnimatedCrossFade(
          firstCurve: Curves.bounceInOut,
          crossFadeState: state.nowPlayingState == RequestState.loading
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          duration: const Duration(
            milliseconds: 500,
          ),
          firstChild: SizedBox(
            width: double.infinity,
            height: 150,
            child: Lottie.asset(
              loadingImage,
              width: 150,
              height: 200,
            ),
          ),
          secondChild: CarouselSlider(
            items: state.getNowPlaying.map((item) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieDetailsScreen(
                        id: item.id,
                      ),
                    ),
                  );
                },
                child: Stack(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ShaderMask(
                        blendMode: BlendMode.srcOver,
                        shaderCallback: (rect) {
                          return LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.transparent,
                              defaultColor.withOpacity(0.7),
                              defaultColor.withOpacity(1),
                            ],
                          ).createShader(
                            Rect.fromLTRB(0, 110, rect.height, rect.width),
                          );
                        },
                        child: CachedNetworkImage(
                          fadeInDuration: const Duration(
                            milliseconds: durationImage,
                          ),
                          imageUrl: ApiConstance.image(
                            item.backDropPath!,
                          ),
                          fit: BoxFit.cover,
                          height: double.infinity,
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              defaultIcon(
                                icon: Icons.circle,
                                color: Colors.red,
                                size: 15,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Now Playing'.toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          item.title,
                          style: const TextStyle(
                            fontSize: fontSizeNowPlaying,
                            fontWeight: FontWeight.w700,
                            color: whiteColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
            options: CarouselOptions(
              viewportFraction: 1.0,
              height: 350,
              //   autoPlay: true,
            ),
          ),
        );
      },
    );
  }
}
