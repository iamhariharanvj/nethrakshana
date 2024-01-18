import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:icare/common_widgets/Card.dart';
import 'package:icare/screens/appointments_screen.dart';
import 'package:icare/utils/theme/theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ImageSlider(),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text("Explore", style: AppTheme.headline2),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: RCard(
              url: "https://aravind.org/wp-content/uploads/2019/07/merge.jpg",
              title: "Book Eye Care Appointment",
              subtitle: "",
              text:
              "Take the first step towards healthier eyes. Schedule your eye care appointment today for personalized attention and expert care.",
            ),
          ),

          SizedBox(height: 20),
        ],
      ),
    );
  }
}

class ImageSlider extends StatelessWidget {
  const ImageSlider({Key? key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: [
        //1st Image of Slider
        Container(
          margin: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            image: DecorationImage(
              image: NetworkImage(
                  "https://aravind.org/wp-content/uploads/2024/01/Webpage.jpg"),
              fit: BoxFit.fill,
            ),
          ),
        ),

        //2nd Image of Slider
        Container(
          margin: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            image: DecorationImage(
              image: NetworkImage(
                  "https://aravind.org/wp-content/uploads/2023/11/Header_1519-x-564_Heads.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),

        //3rd Image of Slider
        Container(
          margin: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            image: DecorationImage(
              image: NetworkImage(
                  "https://aravind.org/wp-content/uploads/2023/11/Header_1519-x-564_management-1.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
      //Slider Container properties
      options: CarouselOptions(
        height: 180.0,
        enlargeCenterPage: true,
        autoPlay: true,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        viewportFraction: 0.8,
      ),
    );
  }
}
