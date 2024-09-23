import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:state_management/Movie_App/common/utils.dart';
import 'package:state_management/Movie_App/models/tv_series_model.dart';
import 'package:state_management/Movie_App/screens/movie_details_screen.dart';


class CustomCarouselSlider extends StatelessWidget {
  const CustomCarouselSlider({
    super.key,
    required this.data,
  });
  final TvSeriesModel data;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;  // Measure the total amount of size
    var carouselOptions = CarouselOptions(
      height: (size.height * 0.33 < 300) ? 300 : size.height * 0.33,
      aspectRatio: 16 / 9,
      viewportFraction: 0.9,
      initialPage: 0,
      enableInfiniteScroll: true,
      reverse: false,
      autoPlay: true,
      autoPlayInterval: const Duration(seconds: 3),
      autoPlayAnimationDuration: const Duration(milliseconds: 800),
      autoPlayCurve: Curves.fastOutSlowIn,
      enlargeCenterPage: true,
      scrollDirection: Axis.horizontal,
    );
    return SizedBox(
      width: size.width,
      height: (size.height * 0.33 < 300) ? 300 : size.height * 0.33,
      child: CarouselSlider.builder(
        itemCount: data.results?.length,
        itemBuilder: (BuildContext context, int index, int realIndex) {
          var url = data.results?[index].backdropPath.toString();
          return GestureDetector(
            onTap: () {

                // print("pressed");
                Navigator.push(context, MaterialPageRoute(builder: (context)=> MovieDetailScreen(movieId: data.results![index].id!)
                  ,));

            },
            child: Column(
              children: [

                CachedNetworkImage(imageUrl: "$imageUrl$url"),
                FittedBox(child: Text(data.results![index].originalTitle.toString())) ,

              ]


            ),
          );
        },
        options: carouselOptions,
      ),
    );
  }
}