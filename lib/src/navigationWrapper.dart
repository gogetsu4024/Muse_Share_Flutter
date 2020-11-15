import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'homePage.dart';
class NavigationWrapper extends StatefulWidget {
  NavigationWrapper({Key key}) : super(key: key);

  @override
  _NavigationWrapperState createState() => _NavigationWrapperState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _NavigationWrapperState extends State<NavigationWrapper> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static  List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedIndex!=2?AppBar(
        leading: Icon(Icons.library_music_outlined,color: Colors.black54,size: 28),
        backgroundColor: Colors.white,
        title: Image(
          image: AssetImage('assets/social_hub.png',
          ),
        )
        ,
        actions: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Image(
                image: AssetImage('assets/top-right-bar.png',
                ),
                height: 40,
                width: 40,
              )
          ),
        ],
      ):null,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xffD15573),
        unselectedItemColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            label: 'chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black54,
        onTap: _onItemTapped,
      ),
    );
  }
}