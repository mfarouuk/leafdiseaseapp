import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ViewDetails extends StatelessWidget {
  final String photoUrl;
  final String  classificationName;
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
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image: NetworkImage(photoUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Center(
                child: Text(
                  classificationName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                  ),

                ),
              ),
              SizedBox(height: 20.0),
              Text(
                treatment,
                style: TextStyle(
                  fontSize: 18.0,

                ),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  SizedBox(width: 20.0),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


}