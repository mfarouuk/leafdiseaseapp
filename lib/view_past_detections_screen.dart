import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:leafdisease/home_screen.dart';
import 'package:leafdisease/view_details_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PastDetection extends StatefulWidget {
  @override
  _PastDetectionState createState() => _PastDetectionState();
}

class _PastDetectionState extends State<PastDetection> {

  final uid = FirebaseAuth.instance.currentUser?.uid;

  CollectionReference collection = FirebaseFirestore.instance.collection("detections");

  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Past Detection'),
          backgroundColor: Colors.lightBlue.shade900,
        ),
        body: StreamBuilder(
            stream: collection
                .where('userId', isEqualTo:uid )

                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text("Error");
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("loding ....");
              }
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    //return Text("${snapshot.data?.docs[index]['classification']}");
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 4.0),
                        Text(
                          "${snapshot.data?.docs[index]['classification']}",
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(height:10,),


                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ViewDetails(
                                  classificationName: "${snapshot.data?.docs[index]['classification']}",
                                  treatment:"${snapshot.data?.docs[index]['treatment']}",
                                      photoUrl: "${snapshot.data?.docs[index]['imgURL']}",),
                              ),
                            );
                          },
                          child: Text('View Details'),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.lightBlue.shade900,
                            textStyle: TextStyle(fontSize: 16.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                  },
                );
              }
              return Text("loding");
            }),

      ),
    );
  }



}
