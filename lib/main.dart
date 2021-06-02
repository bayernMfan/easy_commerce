import 'package:easy_commerce/auth/domain/repository/user_repository.dart';
import 'package:easy_commerce/auth/presentation/pages/auth_page.dart';
import 'package:easy_commerce/navigator/presentation/pages/navigator_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UserRepository>(
          create: (context) => UserRepository(),
        ),
      ],
      // child: MultiBlocProvider(
      //   providers: [
      //     // BlocProvider<BlocA>(
      //     //   create: (BuildContext context) => BlocA(),
      //     // ),
      //   ],
        child: MaterialApp(
          title: 'Easy Commerce',
          theme: ThemeData(
            // Define the default brightness and colors.
            brightness: Brightness.light,
            primaryColor: Color(0xFF29058D),
            accentColor: Color(0xFF7923E8),

            // Define the default font family.
            fontFamily: 'Rubick',

            // Define the default TextTheme. Use this to specify the default
            // text styling for headlines, titles, bodies of text, and more.
            textTheme: TextTheme(
              headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
              headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
              bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
            ),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          initialRoute: '/intro',
          routes: {
            '/intro': (context) => IntroPage(),
            '/auth': (context) => AuthPage(),
            '/nav': (context) => NavigatorPage(),
          },
          //home: IntroPage(),
        ),
     // ),
    );
  }
}

class IntroPage extends StatefulWidget {
  IntroPage({Key key}) : super(key: key);

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Easy Commerce application',
            ),
            Text(
              'Welcome',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _redirect();
  }

  void _redirect() async {
    await Future.delayed(Duration(seconds: 2));
    await Firebase.initializeApp();
    Navigator.of(context).pushReplacementNamed('/auth');
  }
}
