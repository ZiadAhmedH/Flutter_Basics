import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/controller/Movie_Details_Cubit/detials_movie_cubit.dart';
import 'package:movies_app/controller/Movie_Details_Cubit/detials_movie_state.dart';
import 'package:provider/provider.dart';

import '../../controller/Movie_Cubit/Movie_Cubit.dart';
import '../../controller/Movies_Repo.dart';
import '../../view/Movie_Details_Page.dart';
import '../models/Movie_Model.dart';

class MovieWidget extends StatelessWidget {
  final Movie movie;

  const MovieWidget({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MoviesDetailsCubit(movie.id, context.read<MoviesRepo>()),
      child: BlocBuilder<MoviesDetailsCubit, MoviesDetailsState>(
        builder: (context, state) {
          return InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MovieDetailsPage(movieId: movie.id),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  CachedNetworkImage(
                      imageUrl: movie.imageUrl,
                      width: 100,
                      height: 150,
                      imageBuilder: (context, imageProvider) {
                        return Container(
                          width: 100,
                          height: 150,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          clipBehavior: Clip.antiAlias,
                        );
                      },
                      errorWidget: (context, error, stackTrace) {
                        return Container(
                          width: 100,
                          height: 150,
                          child: const Icon(Icons.error, color: Colors.white),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          clipBehavior: Clip.antiAlias,

                        );
                      },
                      placeholder: (context, url) {
                        return Container(
                          width: 100,
                          height: 150,
                          color: Colors.grey,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}