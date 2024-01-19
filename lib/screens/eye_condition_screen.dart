import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class EyeBlogScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CommonEyeConditions'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: EyeBlogContent(),
      ),
    );
  }
}

class EyeBlogContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Common Eye Conditions',
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
        SizedBox(height: 20),
        Text(
          'Common Eye Conditions',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Html(
          data: """
            <p>1. **Myopia (Nearsightedness):** A common condition where distant objects appear blurry. It can be corrected with eyeglasses, contact lenses, or refractive surgery.</p>
            
            <p>2. **Hyperopia (Farsightedness):** Difficulty seeing close objects clearly. Corrected with eyeglasses or contact lenses.</p>
            
            <p>3. **Astigmatism:** Blurred or distorted vision due to an irregular shape of the cornea or lens. Corrected with eyeglasses, contact lenses, or surgery.</p>
            
            <p>4. **Presbyopia:** Age-related loss of near vision, usually occurring after the age of 40. Reading glasses or multifocal lenses are common solutions.</p>
            
            <p>5. **Cataracts:** Clouding of the eye's lens, leading to vision impairment. Surgical removal of the cataract and replacement with an artificial lens is a common treatment.</p>
            
            <p>6. **Glaucoma:** Increased pressure within the eye, damaging the optic nerve and leading to vision loss. Treatment may include eye drops, medications, or surgery.</p>
            
            <p>7. **Macular Degeneration:** Degeneration of the macula, affecting central vision. There is no cure, but treatments can slow its progression.</p>
            
            <p>8. **Conjunctivitis (Pink Eye):** Inflammation of the conjunctiva, causing redness and discomfort. Treatment depends on the cause, including antibiotics for bacterial infections.</p>
            
            <p>9. **Dry Eye Syndrome:** Insufficient tear production or poor-quality tears, causing dryness and discomfort. Artificial tears, medications, or punctal plugs may be recommended.</p>
            
            <p>10. **Diabetic Retinopathy:** Damage to the blood vessels of the retina due to diabetes. Monitoring and managing blood sugar levels are crucial, and treatment may involve laser therapy or surgery.</p>
          """,
        ),
        SizedBox(height: 20),
        YoutubePlayer(
          controller: YoutubePlayerController(
            initialVideoId: 'Aq3bCNGz_2E',
            flags: YoutubePlayerFlags(
              autoPlay: false,
              mute: false,
            ),
          ),
          showVideoProgressIndicator: true,
        ),
      ],
    );
  }
}
