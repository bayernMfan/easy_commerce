import 'package:easy_commerce/auth/domain/entities/user.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key, this.user}) : super(key: key);
  final User user;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
  }

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
                              '${widget.user.name} ${widget.user.secondName}',
                              style: Theme.of(context).textTheme.headline3,
                            ),
                            Padding(padding: EdgeInsets.only(top: 8)),
                            Text(
                              'Phone: +7${widget.user.phone}',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Padding(padding: EdgeInsets.only(top: 16)),
                            Text(
                              'Welcome to Easy Commerce! You may now make your orders',
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
