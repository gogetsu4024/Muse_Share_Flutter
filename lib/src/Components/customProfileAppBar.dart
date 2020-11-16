import 'package:flutter/material.dart';
class CustomProfileAppBar extends StatefulWidget implements PreferredSizeWidget {

  var user;
  var route;


  CustomProfileAppBar({Key key,@required this.route}) : preferredSize = Size.fromHeight(kToolbarHeight), super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  @override
  _CustomProfileAppBarState createState() => _CustomProfileAppBarState();
}


class _CustomProfileAppBarState extends State<CustomProfileAppBar>{
  @override
  Widget build(BuildContext context) {

    return AppBar(
      iconTheme: IconThemeData(
        color: Colors.black, //change your color here
      ),
      leading: widget.route =='singlePost'?null:Container(),
        title: Transform(
          // you can forcefully translate values left side using Transform
          transform:  Matrix4.translationValues(-20.0, 0.0, 0.0),
          child: Text('Gogetsu_JS',style: TextStyle(color: Colors.black,fontFamily: 'rabelo',fontWeight: FontWeight.bold, fontSize: 20)),),
      backgroundColor: Colors.white,
      actions: [
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: widget.route=='profile'?IconButton(
              icon: const Icon(Icons.more_vert,color: Colors.black,size: 26,),
              tooltip: 'Show Snackbar',
              onPressed: () {
              },
            ):null,
        ),
      ],
    );
  }
}