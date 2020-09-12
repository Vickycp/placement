import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:placement/authentication_bloc/authentication_bloc.dart';
import 'package:placement/cloudmeassage/inbox.dart';
import 'package:placement/studemtform.dart';

class HomeScreen extends StatelessWidget {
  final String email;

  HomeScreen({Key key, @required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (context, snap) {
          var user = snap.data;
          print(user.uid);
          return Scaffold(
              appBar: AppBar(
                title: Text("Home"),
              ),
              drawer: drawer(context, user),
              body: StreamBuilder(
                  stream: Firestore.instance
                      .collection("palacementdetails")
                      .snapshots(),
                  builder: (context, snapshot) {
                    var details = snapshot.data.documents;

                    return ListView.builder(
                      itemCount: details.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          height: 220,
                          child: Card(
                            elevation: 5,
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      "https://firebasestorage.googleapis.com/v0/b/fir-bd757.appspot.com/o/Screenshot%20from%202020-05-05%2022-50-51.png?alt=media&token=e38ea8dd-e226-477f-a6ec-29ff846c6530",
                                    )),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(7),
                                child: Stack(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.all(3),
                                      child: Container(
                                        height: 30,
                                        width: double.infinity,
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: <Widget>[
                                            Positioned(
                                                left: 5,
                                                child: CircleAvatar(
                                                    radius: 15,
                                                    child: Icon(Icons.pages))),
                                            Text(
                                              details[index]['company_name'],
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                        top: 34,
                                        left: 0,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 80),
                                          child: Container(
                                            height: 20,
                                            width: 140,
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: <Widget>[
                                                Text(
                                                  details[index]['domain'],
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )
                                              ],
                                            ),
                                          ),
                                        )),
                                    Positioned(
                                        bottom: 0,
                                        left: 0,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Container(
                                              height: 30,
                                              width: 140,
                                              child: Stack(children: <Widget>[
                                                Positioned(
                                                  top: 0,
                                                  left: 0,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 2, left: 5),
                                                    child: Row(
                                                      children: <Widget>[
                                                        Text("contact",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white)),
                                                        Text(":",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white)),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 5),
                                                          child: Text(
                                                              details[index]
                                                                  ['contact'],
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white)),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  bottom: 0,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 5, left: 5),
                                                    child: Row(
                                                      children: <Widget>[
                                                        Text("venue",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white)),
                                                        Text("   :",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white)),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 5),
                                                          child: Text(
                                                              details[index]
                                                                  ['venue'],
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white)),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ])),
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }));
        });
  }

  Widget drawer(context, user) {
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            otherAccountsPictures: <Widget>[
              IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StudentForm(user: user)));
                  })
            ],
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                  child: Image.network(
                "https://firebasestorage.googleapis.com/v0/b/fir-bd757.appspot.com/o/Screenshot%20from%202020-05-05%2022-50-51.png?alt=media&token=e38ea8dd-e226-477f-a6ec-29ff846c6530",
              )),
            ),
            accountEmail: Text(email),
            accountName: null,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => InboxMessage()));
            },
            child: ListTile(
              title: Row(
                children: <Widget>[
                  Text("inbox"),
                  FaIcon(FontAwesomeIcons.github),
                ],
              ),
            ),
          ),
          Divider(
            height: 5,
            color: Colors.grey,
            indent: 15,
            endIndent: 30,
          ),
          ListTile(
            title: Text("data"),
          ),
          Divider(
            height: 5,
            color: Colors.grey,
            indent: 15,
            endIndent: 30,
          ),
          ListTile(
            title: Text("data"),
          ),
          Divider(
            height: 5,
            color: Colors.grey,
            indent: 15,
            endIndent: 30,
          ),
          SizedBox(
            height: 100,
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: () {
                  BlocProvider.of<AuthenticationBloc>(context).add(
                    AuthenticationLoggedOut(),
                  );
                },
                child: ListTile(
                  trailing: IconButton(
                      icon: Icon(Icons.exit_to_app),
                      onPressed: () {
                        BlocProvider.of<AuthenticationBloc>(context).add(
                          AuthenticationLoggedOut(),
                        );
                      }),
                  title: Text("logout"),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
