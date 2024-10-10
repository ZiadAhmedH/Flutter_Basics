import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../Constant/ApiEndPoints.dart';
import '../../Data/Models/Series_Model.dart';
class SeriesWidget extends StatelessWidget {

  final Series series;

  const SeriesWidget({super.key, required this.series});

  @override
  Widget build(BuildContext context) {


    return GestureDetector(
      onTap: () {

      },
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${series.posterPath}',
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
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(8),
              ),
              clipBehavior: Clip.antiAlias,
              child: const Icon(
                  Icons.sms_failed_outlined, color: Colors.white),
            );
          },
          placeholder: (context, url) {
            return Container(
              width: 100,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: Colors.white54,
                  size: 20,
                ),
              ),
            );
          },
        ),
      ),
    );


  }
}
