import 'package:flutter/material.dart';

import 'Session/Singleton.dart';

class FollowersAndFollowing extends StatelessWidget {

  Singleton _instance = Singleton.getState();

  @override
  void initState() {
    // do something with this data: service.fetchPostsForUser(4);
    // like a post , return bool : service.likePost(13, 4);
    // dislike a post , return bool : service.dislikePost(13, 4);
    // do something with this data : service.fetchCommentsForPost(15);
    // like a comment , return bool : service.likeComment(13, 4);
    // dislike a comment , return bool : service.dislikeComment(13, 4);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.black, //change your color here
            ),
            title: Transform(
              // you can forcefully translate values left side using Transform
              transform:  Matrix4.translationValues(10, 0.0, 0.0),
              child: Text(_instance.user.username,style: TextStyle(color: Colors.black,fontFamily: 'rabelo',fontWeight: FontWeight.bold, fontSize: 20)),),
            backgroundColor: Colors.white,
            actions: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: IconButton(
                  icon: const Icon(Icons.more_vert,color: Colors.black,size: 26),
                  tooltip: 'Show Snackbar',
                  onPressed: () {
                  },
                ),
              ),
            ],
              bottom: TabBar(
                tabs: [
                  Tab(child: Text("Followers",style: TextStyle(color: Colors.black,fontSize: 20),),),
                  Tab(child: Text("Following",style: TextStyle(color: Colors.black,fontSize: 20),)),
                ],
              )
          ),
          body: TabBarView(
            children: [
              Icon(Icons.directions_car),
              Icon(Icons.directions_transit),
            ],
          ),
        ),
      ),
    );
  }
}