import 'package:flutter/material.dart';
import 'package:placement/admin/addplacement.dart';
import 'package:placement/admin/studentlist.dart';

class AdminHomepage extends StatefulWidget {
  @override
  _AdminHomepageState createState() => _AdminHomepageState();
}

class _AdminHomepageState extends State<AdminHomepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: GridView.count(crossAxisCount: 2,
        padding: EdgeInsets.all(10),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>AddPlacement()));
              },
                          child: Container(
              color: Colors.blue,
               child: Text("Add placement"),),
            ),
          ),
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: InkWell(
               onTap: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>Studentlist()));
               },
                            child: Container( 
                 color: Colors.blue,
                 child: Text("student list"),),
             ),
           ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(color: Colors.blue, child: Text("message"),),
            ),
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Container(color: Colors.blue, child: Text("etc"),),
             ),
        ],),
      ),
    );
  }
}