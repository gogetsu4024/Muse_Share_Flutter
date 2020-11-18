import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Models/Comment.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
class ChatPage extends StatefulWidget {
  ChatPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  Future<List<Comment>> getLikesApiCall() async {
    final response = await http.get('https://jsonplaceholder.typicode.com/comments?_start=0&_limit=10');
    print(response);
    if (response.statusCode == 200) {

      List<dynamic> body = jsonDecode(response.body);
      List<Comment> posts = body
          .map(
            (dynamic item) => Comment.fromJson(item),
      ).toList();
      return posts;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }


  Future<List<Comment>> getAllLikes() async {
    List<Comment> comments = [];

    comments = await getLikesApiCall();
    return comments;
  }

  Widget _buildAllLikes(){
    return FutureBuilder<List<Comment>>(
        future: getAllLikes(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(
                width: 400,
                alignment: FractionalOffset.center,
                child: CircularProgressIndicator());
          }
          else{
            return Container(width : 400,child:ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildSingleLiker(snapshot.data[index]);              },
            )
            );
          }
        }
        );
  }
  Widget _buildSingleLiker(Comment comment){
    return ListTile(
      leading: ClipOval(
          child:Container(
              width: 60,
              height: 60,
              child:CachedNetworkImage(
                imageUrl: 'https://images.genius.com/00848f3bc658466a2cf7cde003aded38.500x500x1.jpg',
                fit: BoxFit.fill,
                placeholder: (context, url) =>
                    Image(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/user-placeholder.png')
                    ),
                errorWidget: (context, url, error) =>
                    Icon(Icons.error),
              )
          )
      ),
      title:  Text('gogetsu',style: TextStyle(fontSize: 18,fontFamily: 'rabelo',fontWeight: FontWeight.bold)),
      subtitle: Text(
        comment.email,
        style: TextStyle(fontSize: 16,color: Colors.grey.withOpacity(0.6)),
      ),
      trailing: Icon(Icons.check_circle_outline),
    );
  }



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
                Divider(),
                Expanded(
                  child : _buildAllLikes(),
                )
              ],
            )
        )
    );
  }
}
