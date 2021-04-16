import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewNoteScreen extends StatefulWidget {
  final DocumentReference ref;
  final Map data;
  ViewNoteScreen({this.ref,this.data,});

  @override
  _ViewNoteScreenState createState() => _ViewNoteScreenState();
}

class _ViewNoteScreenState extends State<ViewNoteScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
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
                        MaterialStateProperty.all(Colors.red[600])),
                    onPressed: () async {
                      await widget.ref.delete();
                      Navigator.of(context).pop();
                    },
                    child: Text('Delete')),
              ],
            ),
            Text('${widget.data['title']}',style: TextStyle(color: Colors.white, fontSize: 30),),
            Text('${widget.data['description']}',style: TextStyle(color: Colors.white, fontSize: 30),),

          ],
        ),
      ),
    );
  }
}
