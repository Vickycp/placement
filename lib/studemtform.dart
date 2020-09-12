import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:placement/user_repository.dart';









// class StudentStates extends StatelessWidget {
//   final  user ,email;
//   StudentStates({this.user,this.email});
// FormBloc formBloc =FormBloc();


//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder(
//       bloc: formBloc,
//       builder: (context, state) {
//         if(state is FormInitial){
//           return  StudentForm(user: user,) ;
//         }else 
//         if(state is Formload){
//           return Scaffold(body: Center(child: CircularProgressIndicator(),));
//         }else
//         if(state is FormSuccess){
//           return HomeScreen(email:email );
//         }
//       },
//     );
//   }
// }














class StudentForm extends StatefulWidget {
final user ;
StudentForm({this.user});

  @override
  _StudentFormState createState() => _StudentFormState();
}

class _StudentFormState extends State<StudentForm> {

  UserRepository userRepository=UserRepository();

  final _formKey = GlobalKey<FormState>();
  DateTime datetime;
  // String _email;
  String _firstname;
 String _lastname;
 String _usn;
double _cgpa;
int _mobile;




  @override
  Widget build(BuildContext context) {
    // print(widget.user.uid);
    return StreamBuilder(
      stream: Firestore.instance.collection("placementapp").where("email",isEqualTo: widget.user.email).snapshots(),
      builder: (context, snapshot) {
        var da=snapshot.data.documents;
        // print(da[0]['email']);
       
      return Scaffold(
        appBar: AppBar(
          title: Text("Student Form"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              //  Navigator.push(context,MaterialPageRoute(builder: (context)=>HomeScreen(email:da['email'])));
            },
          ),
          centerTitle: true,
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(hintText: da[0]['firstname']),
                    keyboardType: TextInputType.text,
                 
                   onChanged: (val){
                     _firstname=val;
                   },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(hintText:da[0]['lastname']),
                    onChanged: (val){
                     _lastname=val;
                   },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(hintText: da[0]['mobile']!=null?da[0]['mobile'].toString():"mobile no"),
                   onChanged: (val){
                     _mobile=int.parse(val);
                   },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(hintText:da[0]['usn']),
                  onChanged: (val){
                     _usn=val;
                   },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(hintText: da[0]['cgpa'].toString()),
                  onChanged: (val){
                     _cgpa=double.parse(val);
                   },
                  ),
                ),
                Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      
                      children: <Widget>[
                        // Text(da[0]['dob'].toString()),
                        RaisedButton.icon(
                            label: Text("DOB"),
                            icon: Icon(Icons.date_range),
                            onPressed: () {
                              showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2004),
                                      lastDate: DateTime(2030))
                                  .then((val) {
                                setState(() {
                                  datetime = val;
                                });
                                print(val.toString());
                              });
                            }),
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    child: Text("Submit"),
                    onPressed: ()async {
                   
                          var firstname=_firstname!=null?_firstname:da[0]['firstname'];
                          
                          var lastname=_lastname!=null?_lastname:da[0]['lastname'];
                          
                          var usn=_usn!=null?_usn:da[0]['usn'];
                          
                          var cgpa=_cgpa!=null?_cgpa:da[0]['cgpa'];
                          
                         await userRepository.update(widget.user.uid,cgpa: cgpa,usn: usn,first: firstname,last: lastname,mobile:_mobile);

                         Navigator.pop(context);


                        



                    },
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
