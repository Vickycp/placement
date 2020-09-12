import 'package:flutter/material.dart';

class AddPlacement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
              child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(child: Column(children: <Widget>[
            TextField(decoration: InputDecoration(hintText: "company name",labelText: "company name"),),
              TextField(decoration: InputDecoration(hintText: "www.example.com",labelText: "domain"),),
    TextField(decoration: InputDecoration(hintText: "type",labelText: "type"),),
              TextField(decoration: InputDecoration(hintText: "venue",labelText: "venue"),),
                 TextField(decoration: InputDecoration(hintText: "987654321",labelText: "contact"),),
                 TextField(decoration: InputDecoration(hintText: "www.imageurl.jpeg",labelText: "image url"),),
                 TextField(decoration: InputDecoration(hintText: "00:00",labelText: "time"),),
                 TextField(decoration: InputDecoration(hintText: "00/00/00",labelText: "date"),),
          ],),),
        ),
      ),
      
    );
  }
}