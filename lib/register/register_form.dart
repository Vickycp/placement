import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:placement/authentication_bloc/authentication_bloc.dart';
import 'package:placement/register/bloc/register_bloc.dart';
import 'package:placement/register/bloc/register_event.dart';
import 'package:placement/register/bloc/register_state.dart';
import 'package:placement/register/register_button.dart';

class RegisterForm extends StatefulWidget {
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _usnController = TextEditingController();
  final TextEditingController _firstController = TextEditingController();
  final TextEditingController _lastController = TextEditingController();
  final TextEditingController _cgpaController = TextEditingController();
  DateTime dob;

  RegisterBloc _registerBloc;

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isRegisterButtonEnabled(RegisterState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Registering...'),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }
        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context)
              .add(AuthenticationLoggedIn());
          Navigator.of(context).pop();
        }
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Registration Failure'),
                    Icon(Icons.error),
                  ],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
      },
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(20),
            child: Form(
              child: ListView(
                children: <Widget>[

                        TextFormField(
                    controller: _firstController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.person),
                      labelText: 'First name',
                    ),
                    
                    autocorrect: false,
                    autovalidate: true,
               
                  ),
                   TextFormField(
                    controller: _lastController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.person),
                      labelText: 'Last name',
                    ),
                    
                    autocorrect: false,
                    autovalidate: true,
                   
                  ),
                   TextFormField(
                    controller: _usnController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.person),
                      labelText: 'Usn',
                    ),
                    
                    autocorrect: false,
                    autovalidate: true,
                    
                  ),
                  Container(
              height: 60,
              width: double.infinity,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    left: 100,
                    child: Container(
                      width: 50,
                      child: TextFormField(
                        controller: _cgpaController,
                        decoration: InputDecoration(
                          labelText: "cgpa",
                          hintText: "cgpa",
                        ),
                        keyboardType: TextInputType.number,
                      
                      ),
                    ),
                  ),
                  Positioned(
                    right: 100,
                    child: Container(
                        width: 50,
                        child: IconButton(
                            icon: Icon(Icons.date_range),
                            onPressed: () {
                               showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1996),
                                lastDate: DateTime(2030),
                              ).then((val){setState(() {
                                dob=val;
                              });});
                            })),
                  ),
                ],
              ),
            ),
           
                  
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.email),
                      labelText: 'Email',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    autovalidate: true,
                    validator: (_) {
                      return !state.isEmailValid ? 'Invalid Email' : null;
                    },
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.lock),
                      labelText: 'Password',
                    ),
                    obscureText: true,
                    autocorrect: false,
                    autovalidate: true,
                    validator: (_) {
                      return !state.isPasswordValid ? 'Invalid Password' : null;
                    },
                  ),
                 
                  RegisterButton(
                    onPressed: isRegisterButtonEnabled(state)
                        ? _onFormSubmitted
                        : null,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    _registerBloc.add(
      RegisterEmailChanged(email: _emailController.text),
    );
  }

  void _onPasswordChanged() {
    _registerBloc.add(
      RegisterPasswordChanged(password: _passwordController.text),
    );
  }

  void _onFormSubmitted() {
    print(_usnController.text);
    _registerBloc.add(
      RegisterSubmitted(
        email: _emailController.text,
        password: _passwordController.text,
        usn: _usnController.text,
        firstname: _firstController.text,
        lastname: _lastController.text,
        cgpa: double.parse(_cgpaController.text),
        dob: dob


      ),
    );
  }
}