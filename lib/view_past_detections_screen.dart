import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:Treet/home_screen.dart';
import 'package:Treet/view_details_screen.dart';
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
              .where('userId', isEqualTo: uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("Error");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading ....");
            }
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Expanded(
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
                            ],
                          ),
                        ),
                        SizedBox(width: 10.0),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ViewDetails(
                                  classificationName: "${snapshot.data?.docs[index]['classification']}",
                                  treatment: "${snapshot.data?.docs[index]['treatment']}",
                                  photoUrl: "${snapshot.data?.docs[index]['imgURL']}",
                                ),
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
                        SizedBox(width: 10.0),
                        ElevatedButton(
                          onPressed: () {
                            String? docId = snapshot.data?.docs[index].id;
                            collection
                                .doc(docId)
                                .delete();
                          },
                          child: Text('Delete'),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
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
            return Text("Loading");
          },
        ),
      ),
    );
  }




}
