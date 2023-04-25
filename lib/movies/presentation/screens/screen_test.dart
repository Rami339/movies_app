import 'package:cached_network_image/cached_network_image.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/network/api_constance.dart';
import 'package:movie_app/core/utils/app_constance.dart';
import 'package:movie_app/core/utils/colors_app.dart';
import 'package:movie_app/core/utils/components.dart';

import '../../../core/services/services_locator.dart';
import '../controller/movie_details_bloc.dart';
import '../controller/movie_details_event.dart';
import '../controller/movie_details_state.dart';

class ScreenTest extends StatelessWidget {
  const ScreenTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<MovieDetailsBloc>()
        ..add(GetMovieDetailsEvent(603692))
        ..add(GetRecommendationMovieEvent(603692)),
      child: BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.brown,
            body: ListView.builder(
              itemCount: 15,
              itemBuilder: (context, index) {
                return Container(
                  height: 170,
                  width: 100,
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
                  decoration: BoxDecoration(
                      color: defaultColor,
                      borderRadius: BorderRadius.circular(defaultBorder)),
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        width: 105,
                        height: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                            defaultBorder,
                          ),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl:
                                'https://img.freepik.com/free-photo/red-black-brush-stroke-banner-background-perfect-canva_1361-3597.jpg?w=740&t=st=1682245127~exp=1682245727~hmac=e65b8e8fa3daf4d1c080934ec25c1074d5a6bc19ba0185f3eb2884a0bdfb2052',
                            fadeInDuration:
                                const Duration(microseconds: durationImage),
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
                                text: 'red-black-brush-stroke-banner-background-',
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
                                        text: state.detailsModel!.releaseDate
                                            .split('-')[0],
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
                                    text: state.detailsModel!.voteAverage
                                        .toStringAsFixed(1),
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
                                text:
                                    'Taupe is a dark gray-brown color. The word derives from the French noun taupe meaning "mole". The name originally referred only to the average color of the',
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
            ),
          );
        },
      ),
    );
  }
}
