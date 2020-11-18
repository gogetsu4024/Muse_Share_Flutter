import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Components/customProfileAppBar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'Models/Comment.dart';
import 'package:bubble/bubble.dart';

class SinglePostPage extends StatefulWidget {
  var info;
  SinglePostPage({Key key,@required this.info}) : super(key: key);


  @override
  _SinglePostPageeState createState() => _SinglePostPageeState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _SinglePostPageeState extends State<SinglePostPage> {
  bool didFetchComments = false;
  List<Comment> fetchedComments = [];


  Future<List<Comment>> fetchComments() async {
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



  Future<List<Comment>> getComments() async {
    List<Comment> comments = [];

    comments = await fetchComments();
    return comments;
  }

  Widget buildSingleComment(Comment comment){
    return Column(
      children: <Widget>[
        ListTile(
          title: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
              child: Text(
                  comment.email,
                  style: TextStyle(fontSize: 16,fontFamily: 'rabelo',color: Colors.blue,fontWeight: FontWeight.bold)
              )),
          subtitle: Bubble(
            color: Color.fromRGBO(212, 234, 244, 1.0),
            child: Text(comment.body, style: TextStyle(fontSize: 11.0)),
          ),
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
        ),
        Divider(),
      ],
    );
  }


  Widget buildComments() {
    if (this.didFetchComments == false){
      return FutureBuilder<List<Comment>>(
          future: getComments(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Container(
                  alignment: FractionalOffset.center,
                  child: CircularProgressIndicator());
            }
            else{
              this.didFetchComments = true;
              this.fetchedComments = snapshot.data;
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return buildSingleComment(snapshot.data[index]);              },
              );
            }
          });
    } else {
      // for optimistic updating
      return ListView.builder(
        shrinkWrap: true,
        itemCount: fetchedComments.length,
        itemBuilder: (BuildContext context, int index) {
          return buildSingleComment(fetchedComments[index]);
        },
      );
    }
  }



  Widget _buildCard(Map<String, Object> card) =>

      Card(
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
                      Text(
                        '0 Likes',
                        style: TextStyle(fontSize: 16,color: Colors.blue.withOpacity(0.6)),
                      ),
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
      );

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomProfileAppBar(route:'singlePost'),
      body:  Column(
          children:[
            _buildCard(widget.info),
            Divider(),
            Expanded(
              child: buildComments(),
            ),
          ]
      ),
    );
  }
}