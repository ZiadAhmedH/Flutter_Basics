import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../../controller/ThreeDMovies/cubit/three_dcubit_cubit.dart';
import '../../../model/widgets/Movie_List_Widget.dart';


class LoadMoviesScreen extends StatefulWidget {
  @override
  _MoviesScreenState createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<LoadMoviesScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // Listen to the scroll controller
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        _loadMoreMovies();
      }
    });
  }

  void _loadMoreMovies() {
    final movieCubit = context.read<ThreeDcubitCubit>();
    if (movieCubit.state.hasMoreMovies && !movieCubit.state.isLoading) {
      movieCubit.fetchMoreMovies();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var state = context.watch<ThreeDcubitCubit>().state;

    return Scaffold(
      backgroundColor: Color.fromRGBO(44, 43, 43, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(44, 43, 43, 1),
        title: Text('Movies'),
      ),
      body: GridView.builder(
        controller: _scrollController, // Attach scroll controller
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 0.7,
        ),
        padding:const  EdgeInsets.all(10.0), // Padding around the grid
        itemCount: state.movies.length + (state.hasMoreMovies ? 1 : 0), // Extra item for loading indicator
        itemBuilder: (context, index) {
          if (index == state.movies.length) {
            return state.hasMoreMovies && !state.isLoading
                ?  Center(child: LoadingAnimationWidget.discreteCircle(color: Colors.grey, size: 20))
                : const SizedBox.shrink();
          }
          final movie = state.movies[index];
          return MovieWidget(movie: movie );
        },
      ),
    );
  }
}