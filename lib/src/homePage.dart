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
          leading: Icon(Icons.arrow_drop_down_circle),
          title:  Text(card['name']),
          subtitle: Text(
            'Secondary Text',
            style: TextStyle(color: Colors.black.withOpacity(0.6)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Greyhound divisively hello coldly wonderfully marginally far upon excluding.',
            style: TextStyle(color: Colors.black.withOpacity(0.6)),
          ),
        ),
        ButtonBar(
          alignment: MainAxisAlignment.start,
          children: [
            FlatButton(
              textColor: const Color(0xFF6200EE),
              onPressed: () {
                // Perform some action
              },
              child: const Text('ACTION 1'),
            ),
            FlatButton(
              textColor: const Color(0xFF6200EE),
              onPressed: () {
                // Perform some action
              },
              child: const Text('ACTION 2'),
            ),
          ],
        ),
        Image.network(
          card['imageLink'],
          fit: BoxFit.fill,
        ),
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