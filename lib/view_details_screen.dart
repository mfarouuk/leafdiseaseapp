import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ViewDetails extends StatelessWidget {
  final String photoUrl;
  final String classificationName;
  final String treatment;

  const ViewDetails({
    Key? key,
    required this.photoUrl,
    required this.classificationName,
    required this.treatment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Details'),
          backgroundColor: Colors.lightBlue.shade900,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(
                  photoUrl,
                  height: 300,
                  width: 300,
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 10.0),
              Center(
                child: Text(
                   classificationName,
             
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,

                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Center(
                child: Text(
                treatment,
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}