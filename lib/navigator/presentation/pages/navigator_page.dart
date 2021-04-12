import 'package:easy_commerce/order/presentation/pages/make_order_page.dart';
import 'package:easy_commerce/order/presentation/pages/orders_page.dart';
import 'package:easy_commerce/profile/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';

class NavigatorPage extends StatefulWidget {
  @override
  _NavigatorPageState createState() => _NavigatorPageState();
}

class _NavigatorPageState extends State<NavigatorPage> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Easy Commerce',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        //backgroundColor: Colors.transparent,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.portrait), title: Text('Profile')),
          BottomNavigationBarItem(
              icon: Icon(Icons.home), title: Text('Orders')),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), title: Text('Shop'))
        ],
        onTap: _onTappedBar,
        selectedItemColor: Theme.of(context).primaryColor,
        currentIndex: _selectedIndex,
      ),
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: Stack(children: [
        Positioned.fill(
            child: Image.asset(
          'assets/bckg.jpeg',
          fit: BoxFit.cover,
        )),
        Positioned(child: Container(color: Colors.black.withOpacity(0.4))),
        Positioned(
          child: PageView(
            controller: _pageController,
            children: <Widget>[
              ProfilePage(),
              OrdersPage(),
              MakeOrderPage()
              // ProfilePage(),
              // HomeTables(),
              // ShoppingPage(),
            ],
            onPageChanged: (page) {
              setState(() {
                _selectedIndex = page;
              });
            },
          ),
        ),
      ]),
    );
  }

  void _onTappedBar(int value) {
    setState(() {
      _selectedIndex = value;
    });
    _pageController.jumpToPage(value);
  }
}
