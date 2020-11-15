import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'data.dart';
class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);


  @override
  _HomePageState createState() => _HomePageState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _HomePageState extends State<HomePage> {
  var cards = Data.getData;



  Widget _buildCard(Map<String, Object> card) => Card(
    clipBehavior: Clip.antiAlias,

    child: Column(
      children: [
        ListTile(
          leading: Container(
              width: 60.0,
              height: 60.0,
              decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: new NetworkImage(
                          card['imageLink'])
                  )
              )),
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
          leading: Image.network(
            card['songCover'],
            fit: BoxFit.fill,
          ),
          title:  Text(card['songName'],style: TextStyle(fontSize: 18,fontFamily: 'rabelo',fontWeight: FontWeight.bold)),
          subtitle: Text(
            '29 minutes ago',
            style: TextStyle(fontSize: 16,color: Colors.grey.withOpacity(0.6)),
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
      body: ListView.builder(
        itemCount: cards.length,
        itemBuilder: (context, index) {
          return _buildCard(cards[index]);
        },
      ),
    );
  }
}