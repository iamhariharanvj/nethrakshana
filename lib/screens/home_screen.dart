import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:icare/common_widgets/Card.dart';
import 'package:icare/utils/theme/theme.dart';
import 'package:flutter/services.dart';
import 'package:dots_indicator/dots_indicator.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          MyImageSlider(),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text("Explore", style: AppTheme.headline2),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: RCard(
              url: "https://aravind.org/wp-content/uploads/2019/07/merge.jpg",
              title: "Book Eye Care Appointment",
              subtitle: "",
              text:
              "Take the first step towards healthier eyes. Schedule your eye care appointment today for personalized attention and expert care.",
              route: "/book",
            ),
          ),
          SizedBox(height: 20),
          // Add more cards with generic information
          Padding(
            padding: EdgeInsets.all(16.0),
            child: RCard(
              url: "https://www.healthstatus.com/wp-content/uploads/2020/06/eye-optometrist-exam-ophthalmologist.jpg",
              title: "Ophthalmology Overview",
              subtitle: "",
              text:
              "Learn about the fundamentals of ophthalmology and how it plays a crucial role in maintaining eye health.",
              route: "/overview",
            ),
          ),
          SizedBox(height: 20),
          // Add more cards with generic information
          Padding(
            padding: EdgeInsets.all(16.0),
            child: RCard(
              url: "https://c3a2x9v5.rocketcdn.me/wp-content/uploads/2020/05/womanThickFrameGlasses_xl-845x321.jpg",
              title: "Common Eye Conditions",
              subtitle: "",
              text:
              "Explore common eye conditions such as cataracts, glaucoma, and more. Understand their symptoms and treatments.",
              route: "/eyeconditions",
            ),
          ),
          // Add more cards with generic information

          SizedBox(height: 20),
        ],
      ),
    );
  }
}

class MyImageSlider extends StatefulWidget {
  @override
  _MyImageSliderState createState() => _MyImageSliderState();
}

class _MyImageSliderState extends State<MyImageSlider> {
  final List<String> images = [
    'https://www.birlaeye.org/images/aravind-eye-care.jpg',
    'https://aravind.org/wp-content/uploads/2019/06/Phacoemulsification.jpg',
    'https://aravind.org/wp-content/uploads/2019/06/Aurolab-1.jpg',
    // Add more image paths as needed
  ];

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 200, // Adjust the height as needed
          child: PageView.builder(
            itemCount: images.length,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return Image.network(
                images[index],
                fit: BoxFit.cover,
              );
            },
          ),
        ),
        DotsIndicator(
          dotsCount: images.length,
          position: currentIndex,
          decorator: DotsDecorator(
            size: const Size.square(8.0),
            activeSize: const Size(20.0, 8.0),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
        ),
      ],
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
