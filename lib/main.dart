import 'package:flutter/material.dart';
import 'package:flutter_login_signup/src/Models/items.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wonderpush_flutter/wonderpush_flutter.dart';

import 'src/loginPage.dart';
import 'src/player.dart';

void main() {
  runApp(MyApp());
  WonderPush.subscribeToNotifications();
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
         primarySwatch: Colors.blue,
         textTheme:GoogleFonts.latoTextTheme(textTheme).copyWith(
           bodyText1: GoogleFonts.montserrat(textStyle: textTheme.bodyText1),
         ),
      ),
      debugShowCheckedModeBanner: false,
      home:LoginPage(),
    );
  }
}
