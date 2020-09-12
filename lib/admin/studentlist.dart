import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Studentlist extends StatefulWidget {
  @override
  _StudentlistState createState() => _StudentlistState();
}

class _StudentlistState extends State<Studentlist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: StreamBuilder(
              stream: Firestore.instance.collection("placementapp").snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                var datas = snapshot.data.documents;
                return ListView.builder(
                    itemCount: datas.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Studentview(datas: datas[index],)));
                        },
                                              child: Card(
                          child: ListTile(
                            title: Text(datas[index]["firstname"] +
                                "." +
                                datas[index]["lastname"]),
                            subtitle: Text(datas[index]["usn"]),
                          ),
                        ),
                      );
                    });
              }),
        ),
      ),
    );
  }
}


class Studentview extends StatelessWidget {
final datas;
Studentview({this.datas});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(child:Card(child: Container(
          height: double.infinity,
          width: double.infinity,
          child: Stack(children: <Widget>[
Positioned(
  left: 100,
  child: Container(child: Text("name :"+datas['firstname']+" "+datas['lastname']),)),

  Positioned(
    top: 30,
  left: 100,
  child: Container(child: Text("email :"+datas['email']),)),
  Positioned(
    top: 50,
  left: 100,
  child: Container(child: Text("usn   :"+datas['usn']),)),
  Positioned(
    top: 70,
  left: 100,
  child: Container(child: Text("mobile :"+datas['mobile'].toString()),)),
  Positioned(
    top: 90,
  left: 100,
  child: Container(child: Text("cgpa :"+datas['cgpa'].toString()),))

          ],),
        ),) ),
      ),
    );
  }
}