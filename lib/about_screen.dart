import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class About extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlue.shade900,
          title: Text("About"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Text(
                    'Treet',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,

                    ),
                  ),
                ),
                SizedBox(height: 18.0),
                Text(
                  'Our application is designed to help farmers and gardeners detect and treat leaf diseases in plants. With our advanced image recognition technology, you can simply take a photo of a diseased leaf and our app will analyze the image and provide a diagnosis of the disease.',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 18.0),
                Text(
                  'In addition to diagnosis, our app also provides treatment recommendations for the diagnosed diseases. Our database includes a variety of plant diseases and treatments, and we are constantly updating and expanding our resources to provide the most accurate and up-to-date information.',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 18.0),
                Text(
                  'We are passionate about helping farmers and gardeners protect their crops and plants, and we believe that our app can be a valuable tool in achieving this goal.',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 18.0),
                Text(
                  'Using the app is simple and convenient. After installing it on your device, open the app and navigate to the leaf disease detection feature. From there, you can use your device\'s camera to take a clear picture of the diseased leaf. Once you capture the image, the app will process it using our powerful algorithms and provide you with an accurate diagnosis within seconds.',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 18.0),
                Text(
                  'Based on the diagnosis, the app will offer treatment recommendations tailored to the specific disease affecting your plant. These recommendations may include organic or chemical treatments, pruning affected areas, or implementing preventive measures. Our goal is to help you effectively manage leaf diseases and prevent further spread.',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 18.0),
                Text(
                  'We understand the importance of timely intervention, so we encourage users to regularly check their plants for any signs of leaf diseases and use our app to diagnose and treat them as early as possible. By doing so, you can protect your plants and increase your chances of a successful harvest or a flourishing garden.',
                  style: TextStyle(fontSize: 18.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}






