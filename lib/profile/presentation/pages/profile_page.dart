import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Flexible(
              flex: 3,
              fit: FlexFit.loose,
              child: Container(
                height: MediaQuery.of(context).size.longestSide * 3 / 5,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    image: DecorationImage(
                        image: ExactAssetImage('assets/profile.jpeg'),
                        fit: BoxFit.cover)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.loose,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Andrey Butuzov',
                              style: Theme.of(context).textTheme.headline3,
                            ),
                            Padding(padding: EdgeInsets.only(top: 8)),
                            Text(
                              'a.k.a сделай за 2 часа перед парой',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Padding(padding: EdgeInsets.only(top: 16)),
                            Text(
                              'Когда-нибудь это приложение станет моей вкр, но это не точно =(',
                              style: Theme.of(context).textTheme.caption,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(bottom: 120)),
          ]),
        ),
      ),
    );
  }
}
