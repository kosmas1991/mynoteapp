import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

String _title ='';
String _des = '';

class AddNoteScreen extends StatefulWidget {
  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  @override
  void initState() {
    _title = '';
    _des = '';
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [UpperButtons(), FormWidget()],
        ),
      ),
    );
  }
}

class FormWidget extends StatelessWidget {
  const FormWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Form(
          child: Column(
        children: [
          TextFormField(
            onChanged: (value) {
              _title = value;
            },
            style: TextStyle(color: Colors.white, fontSize: 30),
            decoration: InputDecoration(
                hintText: 'Enter Title',
                hintStyle: TextStyle(color: Colors.white, fontSize: 30)),
          ),
          TextFormField(
            onChanged: (value) {
              _des = value;
            },
            style: TextStyle(color: Colors.white, fontSize: 20),
            decoration: InputDecoration(
                hintText: 'Enter Description',
                hintStyle: TextStyle(color: Colors.white, fontSize: 20)),
          ),
        ],
      )),
    );
  }
}

class UpperButtons extends StatelessWidget {
  const UpperButtons({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.deepPurple)),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Go Back'),
          ),
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.green[600])),
              onPressed: () {
                print(_title + ' ' + _des);
                CollectionReference ref = FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser.uid)
                    .collection('notes');
                var noteData = {
                  'title': _title,
                  'description': _des,
                  'date': DateTime.now()
                };
                ref.add(noteData);
                Navigator.of(context).pop();
              },
              child: Text('Save Note')),
        ],
      ),
    );
  }
}
