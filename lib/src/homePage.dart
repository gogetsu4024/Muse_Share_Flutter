import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'data.dart';
import 'singlePost.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'Models/Comment.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);


  @override
  _HomePageState createState() => _HomePageState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _HomePageState extends State<HomePage> {
  var cards = Data.getData;


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
        });


  }
  Widget _buildSingleLiker(Comment comment){
    return ListTile(
      leading: ClipOval(
          child:Container(
              width: 50,
              height: 50,
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
      title:  Text('gogetsu',style: TextStyle(fontSize: 16,fontFamily: 'rabelo',fontWeight: FontWeight.bold)),
      subtitle: Text(
        comment.email,
        style: TextStyle(fontSize: 14,color: Colors.grey.withOpacity(0.6)),
      ),
      trailing: Container(
          width: 75,
          child : RaisedButton(
            child: Text('follow'),
            textColor: Colors.white,
            color: Color(0xFF6200EE),
            onPressed: () {
              // Respond to button press
            },

          )
      ),
    );
  }

  Widget _buildLikesPopUp(){
    return GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(

                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Text('Likes',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold))
                          ),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                              child:  IconButton(
                                  icon: Icon(Icons.close,color: Colors.purpleAccent,size: 30,),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  }
                              )
                          )
                        ],
                      ),
                      Divider(thickness: 1.5),
                      Expanded(
                      child : _buildAllLikes(),
                      )
                    ],
                  ),
                );
              });
        },
        child: Text(
          '0 Likes',
          style: TextStyle(fontSize: 16,color: Colors.blue.withOpacity(0.6)),
        ));
  }

  Widget _buildCard(Map<String, Object> card) =>
      GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SinglePostPage(info: card),
              ),
            );
          },
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                ListTile(
                  leading: ClipOval(
                      child:Container(
                          width: 60,
                          height: 60,
                          child:CachedNetworkImage(
                            imageUrl: card['imageLink'],
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
                  title:  Text(card['name'],style: TextStyle(fontSize: 18,fontFamily: 'rabelo',fontWeight: FontWeight.bold)),
                  subtitle: Text(
                    '29 minutes ago',
                    style: TextStyle(fontSize: 16,color: Colors.grey.withOpacity(0.6)),
                  ),
                  trailing: Icon(Icons.more_vert),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      card['desc'],
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 17,color: Colors.black.withOpacity(0.8)),
                    ),
                  ),),
                ListTile(
                  leading: CachedNetworkImage(
                    imageUrl: card['songCover'],
                    fit: BoxFit.fill,
                    placeholder: (context, url) =>
                        Image(
                            fit: BoxFit.fill,
                            image: AssetImage('assets/soundcloud.png')
                        ),
                    errorWidget: (context, url, error) =>
                        Icon(Icons.error),
                  )
                  ,
                  title:  Text(card['songName'],style: TextStyle(fontSize: 18,fontFamily: 'rabelo',fontWeight: FontWeight.bold)),
                  subtitle: Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          _buildLikesPopUp(),
                          Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                          Text(
                            '0 Comments',
                            style: TextStyle(fontSize: 16,color: Colors.blue.withOpacity(0.6)),
                          )

                        ],
                      )
                  ),
                  trailing: Icon(Icons.cloud_download,size: 40,),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Divider(
                            thickness: 1,
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
                Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text.rich(
                          TextSpan(
                            style: TextStyle(
                              fontSize: 20,
                            ),
                            children: [
                              WidgetSpan(
                                  child: Container(
                                    padding: EdgeInsets.only(right:5.0),
                                    child: Icon(Icons.thumb_up_alt_outlined),
                                  )
                              ),
                              TextSpan(
                                text: 'Like',
                              ),
                            ],
                          ),
                        ),
                        Padding(padding: EdgeInsets.symmetric(horizontal: 50,vertical: 20)),
                        Text.rich(
                          TextSpan(
                            style: TextStyle(
                              fontSize: 20,
                            ),
                            children: [
                              WidgetSpan(
                                  child: Container(
                                    padding: EdgeInsets.only(right:5.0),
                                    child: Icon(Icons.comment),
                                  )
                              ),
                              TextSpan(
                                text: 'Comment',
                              ),
                            ],
                          ),
                        )

                      ],
                    )
                )
              ],
            ),
          ));

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:  Column(
          children:[
            Card(
              clipBehavior: Clip.antiAlias,
              child: ListTile(
                leading: Image(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/soundcloud.png',)
                ),
                title:  Text('Welcome to a whole new world of sound discovery. Select a track to start listening !'
                    ,style: TextStyle(fontSize: 18,)),

              ),
            ),
            Expanded(
                child:ListView.builder(
                  itemCount: cards.length,
                  itemBuilder: (context, index) {
                    return _buildCard(cards[index]);
                  },
                )
            ),
          ]
      ),
    );
  }
}