import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class OphthalmologyBlogScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ophthalmology Overview'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: OphthalmologyBlogContent(),
      ),
    );
  }
}

class OphthalmologyBlogContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Ophthalmology Overview',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Html(
          data: """
            <p>Welcome to our mobile blog on ophthalmology! Ophthalmology is the branch of medicine that deals with the anatomy, physiology, and diseases of the eye. It is a fascinating field that plays a crucial role in maintaining our vision and eye health.</p>
            
            <img src="https://media.sciencephoto.com/image/c0314635/800wm/C0314635-Ophthalmology.jpg" alt="Ophthalmology Image" width="100%">
            
            <p>Watch the video below for a brief overview of ophthalmology:</p>
            
            <div style="width: 100%; height: 200px;">
              
            </div>
            
            <p>Understanding the structure of the eye, common eye conditions, and the importance of regular eye examinations is essential for maintaining good eye health. Ophthalmologists are specialized doctors who diagnose and treat a wide range of eye-related issues.</p>
            
            <p>Explore the various aspects of ophthalmology through our blog posts and stay informed about the latest advancements in eye care.</p>
          """,
        ),
        YoutubePlayer(controller: YoutubePlayerController(
          initialVideoId: 'Aq3bCNGz_2E',
          flags: YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
        ),
      ),
      showVideoProgressIndicator: true,
        )
      ],
    );
  }
}
