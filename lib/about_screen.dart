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
          body: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
          Text(
          'Leaf Disease Detection and Treatment',
          style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
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
    ],
    ),
    ),
    ),
    );
  }
}






