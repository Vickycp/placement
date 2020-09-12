import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterEmailChanged extends RegisterEvent {
  final String email;

  const RegisterEmailChanged({@required this.email});

  @override
  List<Object> get props => [email];

  @override
  String toString() => 'EmailChanged { email :$email }';
}

class RegisterPasswordChanged extends RegisterEvent {
  final String password;

  const RegisterPasswordChanged({@required this.password});

  @override
  List<Object> get props => [password];

  @override
  String toString() => 'PasswordChanged { password: $password }';
}

class RegisterSubmitted extends RegisterEvent {
  final String email;
  final String password;
  final String usn;
  final String firstname;
  final String lastname;
  final double cgpa;
  final DateTime dob;

  const RegisterSubmitted({
    @required this.email,
    @required this.password,
    @required this.usn,
    @required this.firstname,
    @required this.lastname,
    @required this.cgpa,
    @required this.dob,
  });

  // @override
  // List<Object> get props => [email, password,usn,firstname,lastname,cgpa,dob];

  // @override
  // String toString() {
  //   return 'Submitted { email: $email, password: $password }';
  // }
}
