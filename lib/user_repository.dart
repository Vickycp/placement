import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  UserRepository({FirebaseAuth firebaseAuth, GoogleSignIn googleSignin})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignin ?? GoogleSignIn();

  Future<FirebaseUser> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await _firebaseAuth.signInWithCredential(credential);
    return _firebaseAuth.currentUser();
  }

  Future<void> signInWithCredentials(String email, String password) {
    return _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<FirebaseUser> signUp({String email, String password,String usn ,String first,String last,double cgpa,DateTime dob}) async {
    var fire= await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    print(usn);
    await adduser(fire,email: email,first: first,last: last,usn: usn,cgpa: cgpa,dob: dob);
    return fire.user;
  }

  Future<void> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  Future<bool> isSignedIn() async {
    final currentUser = await _firebaseAuth.currentUser();
    return currentUser != null;
  }

  Future<String> getUser() async {
    return (await _firebaseAuth.currentUser()).email;
  }


adduser(fire,{String email,String usn ,String first,String last,double cgpa,DateTime dob}){
               print(fire.user.uid);
             Firestore.instance.collection("placementapp").document(fire.user.uid).setData({"email":email,"firstname":first,"lastname":last,"usn":usn,"cgpa":cgpa,"dob":dob});


}



update(uid,{String usn ,String first,String last,double cgpa,int mobile})async{

             Firestore.instance.collection("placementapp").document(uid).updateData({"firstname":first,"lastname":last,"usn":usn,"cgpa":cgpa,"mobile":mobile});


}

adsdata({String companyname,String domain,String type,String venue,String contact,String imageurl,String time,String date}){
                   Firestore.instance.collection("palacementdetails").add({"company_name":companyname,"contact":contact,"domain":domain,"image":imageurl,"type":type,"venue":venue,"date":date,"time":time});


}



}


