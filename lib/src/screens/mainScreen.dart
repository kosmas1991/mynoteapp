import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'addNoteScreen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'viewNoteScreen.dart';

class MainScreen extends StatefulWidget {
  final GoogleSignInAccount googleSignInAccount;

  MainScreen({this.googleSignInAccount});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  CollectionReference ref = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser.uid)
      .collection('notes');
  List<Color> myColors = [
    Colors.yellow,
    Colors.green,
    Colors.white70,
    Colors.lightBlue,
    Colors.redAccent,
    Colors.pink,
    Colors.indigo,
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: GoogleUserCircleAvatar(
                    identity: widget.googleSignInAccount,
                    backgroundColor: Colors.white,
                  ),
                ),
                Text(
                  FirebaseAuth.instance.currentUser.displayName,
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.8,
              child: FutureBuilder<QuerySnapshot>(
                future: ref.get(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    Random random = Random();
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) {
                          Map data = snapshot.data.docs[index].data();
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ViewNoteScreen(data: data,ref: snapshot.data.docs[index].reference,),
                              )).then((value) {
                                setState(() {

                                });
                              });
                            },
                            child: Card(
                              color: myColors[random.nextInt(myColors.length)],
                              child: Column(
                                children: [
                                  Text(
                                    '${data['title']}',
                                    style: TextStyle(
                                        fontSize: 40, fontFamily: 'ballon'),
                                  ),
                                  Text('${data['description']}',
                                      style: TextStyle(
                                          fontSize: 20, fontFamily: 'ballon')),
                                  Container(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      DateFormat
                                              .yMMMd() //////////// OMG nice tip
                                          .add_jm()
                                          .format(data['date'].toDate()),
                                      style: TextStyle(
                                          fontSize: 18, fontFamily: 'ballon'),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return Center(
                      child: Text('Loading'),
                    );
                  }
                },
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddNoteScreen(),
            )).then((value) {
              setState(() {

              });
            });
          },
          backgroundColor: Colors.deepPurple,
          child: Icon(
            Icons.note_add_sharp,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
