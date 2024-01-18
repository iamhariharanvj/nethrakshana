import 'package:flutter/material.dart';

class RCard extends StatelessWidget {
  final title, url, subtitle, text;

  const RCard({Key? key, this.title, this.url, this.subtitle, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5, // Add a subtle shadow to the card
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Increase the border radius for a softer look
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Add a container with a BoxDecoration to provide a gradient and rounded corners to the image
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black.withOpacity(0.5), Colors.transparent],
              ),
            ),
            child: Image.network(
              url,
              height: 160,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.bold, // Make the title bold
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 10),

              ],
            ),
          ),
          Container(height: 5),
        ],
      ),
    );
  }
}
