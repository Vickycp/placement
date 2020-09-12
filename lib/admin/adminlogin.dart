import 'package:flutter/material.dart';

class AdminLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Center(
         child: Container(
           height: 400,
           width: 700,
           child: SingleChildScrollView(
             child: Column(
            
               children: <Widget>[
                  SizedBox(height: 8,),
                 Padding(
                   padding: const EdgeInsets.all(10),
                   child: TextFormField(),
                 ),
               

                 Padding(
                   padding: const EdgeInsets.all(15),
                   child: TextFormField(),
                 ),
             
                 Padding(
                   padding: const EdgeInsets.all(15),
                   child: Container(
                     decoration: BoxDecoration(
   color: Colors.blue,
                       borderRadius: BorderRadius.circular(20)
                     ),
                     alignment: Alignment.center,
                     width: double.infinity,
                    
                     height: 20,

                     child: Text("login"),),
                 )

               ],
             ),
           ),
         ),
       ),
    );
  }
}

