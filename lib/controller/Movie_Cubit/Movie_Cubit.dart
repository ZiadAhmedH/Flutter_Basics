import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';

import 'package:state_notifier/state_notifier.dart';

import '../../model/models/Movie_Model.dart';
import '../Movies_Repo.dart';
import 'Movie_State.dart';


class MovieCubit extends Cubit<MovieState> {
  final MoviesRepo moviesRepo;

  MovieCubit(this.moviesRepo) : super(MovieState.initial());



  // Fetch initial movies


  // Fetch more movies when scrolling
  Future<void> fetchMoreMovies() async {
    if (!state.hasMorePages || state.isLoading) return;
    try {
      emit(state.copyWith(isLoading: true));
      final movies = await moviesRepo.fetchMovies(page: state.currentPage + 1);
      emit(state.copyWith(
        movies: state.movies.addAll(movies),
        isLoading: false,
        hasMorePages: moviesRepo.hasMorePages,
        currentPage: state.currentPage + 1,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
