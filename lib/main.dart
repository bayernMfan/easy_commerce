import 'package:easy_commerce/auth/presentation/pages/auth_page.dart';
import 'package:easy_commerce/navigator/presentation/pages/navigator_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/intro',
      routes: {
        '/intro': (context) => IntroPage(),
        '/auth': (context) => AuthPage(),
        '/nav': (context) => NavigatorPage(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //home: IntroPage(),
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
    Navigator.of(context).pushReplacementNamed('/auth');
  }
}
