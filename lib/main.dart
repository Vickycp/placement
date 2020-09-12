import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:placement/authentication_bloc/authentication_bloc.dart';
import 'package:placement/home_screen.dart';
import 'package:placement/login/login_screen.dart';
import 'package:placement/splash_screen.dart';
import 'package:placement/user_repository.dart';

import 'simple_bloc_delegate.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final UserRepository userRepository = UserRepository();
  runApp(
    BlocProvider(
      create: (context) => AuthenticationBloc(
        userRepository: userRepository,
      )..add(AuthenticationStarted()),
      child: App(userRepository: userRepository),
    ),
  );
}

class App extends StatelessWidget {
  final UserRepository _userRepository;

  App({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationFailure) {
            return LoginScreen(userRepository: _userRepository);
          }
          if (state is AuthenticationSuccess) {
            return HomeScreen(email: state.displayName);
          }
          return SplashScreen();
        },
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:placement/admin/adminhomepage.dart';


// void main (){
//   runApp(MaterialApp(
//     home:AdminHomepage(),
//   ));
// }