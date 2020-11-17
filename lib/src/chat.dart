import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';


class ChatPage extends StatefulWidget {
  ChatPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body:
        Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10.0,horizontal: 20),
                  child: new TextField(
                    decoration: new InputDecoration(
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(20.0),
                          ),
                        ),
                        filled: true,
                        hintStyle: new TextStyle(color: Colors.grey[800]),
                        hintText: "Type in your text",
                        fillColor: Colors.grey),
                  ),
                ),
                Container(
                    height: 100,
                    child: ListView(
                      // This next line does the trick.
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: AssetImage('assets/user-placeholder.png'),
                            )),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: AssetImage('assets/user-placeholder.png'),
                            )),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: AssetImage('assets/user-placeholder.png'),
                            )),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: AssetImage('assets/user-placeholder.png'),
                            )),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: AssetImage('assets/user-placeholder.png'),
                            )),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: AssetImage('assets/user-placeholder.png'),
                            )),
                      ],
                    )
                ),
                Text('Conversations',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),

              ],
            )
        )
    );
  }
}
